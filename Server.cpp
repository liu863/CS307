#include <fcntl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>
#include <pthread.h>
#include <signal.h>
#include <wait.h>
#include <sys/resource.h>
#include <dirent.h>
#include "Server.h"
#include "database.h"


const char *SUCCESS = "SUCCESS\n";

const char *DBERROR = "Database error\n";

const char *USREXIST = "User already exist\n";

const char *WRONGPW = "Unmatched username and password\n";

const char *USRNOTEXIST = "User not exist\n";

const char *WRONGEVENTINFO = "Invalid event information\n";

const char *LOADEVENTLISTERROR = "Fail to load event list\n";

extern "C" void background(int sig) {
	int status;
	struct rusage usage;
	pid_t pid = wait3(&status, 0, &usage);
}
    
int QueueLength = 5;
pthread_mutex_t mutex;
int port = 6666;
char cport[20] = {0};
int splitLength = 0;
struct Databases database;

// Processes time request
void processRequest(int socket);
void processThreadRequest(int slaveSocket);
char** split(char* str, char id);

int main(int argc, char **argv) {
	if (database.initDatabases() != 1) {
		fprintf(stderr, "Database start error\n");
		exit(-1);
	}
    
    // Set the IP address and port for this server
    struct sockaddr_in serverIPAddress; 
    memset( &serverIPAddress, 0, sizeof(serverIPAddress) );
    serverIPAddress.sin_family = AF_INET;
    serverIPAddress.sin_addr.s_addr = INADDR_ANY;
    serverIPAddress.sin_port = htons((u_short) port);
    
    // Allocate a socket
    int masterSocket =  socket(PF_INET, SOCK_STREAM, 0);
    if ( masterSocket < 0) {
        perror("socket");
        exit(-1);
    }
    
    // Set socket options to reuse port. Otherwise we will
    // have to wait about 2 minutes before reusing the same port number
    int optval = 1; 
    int err = setsockopt(masterSocket, SOL_SOCKET, SO_REUSEADDR, (char*)&optval, sizeof(int));
    
    // Bind the socket to the IP address and port
    int error = bind(masterSocket, (struct sockaddr *)&serverIPAddress, sizeof(serverIPAddress)); 
	if (error) {
        perror("bind");
        exit(-1);
    }
    
    // Put socket in listening mode and set the 
    // size of the queue of unprocessed connections
    error = listen( masterSocket, QueueLength);
    if (error) {
        perror("listen");
        exit(-1);
    }

	signal(SIGCHLD, background);

    while (1) {
        
        // Accept incoming connections
        struct sockaddr_in clientIPAddress;
        int alen = sizeof( clientIPAddress );
        int slaveSocket = accept( masterSocket,	
                                 (struct sockaddr *)&clientIPAddress,
                                 (socklen_t*)&alen);
        
        if (slaveSocket < 0) {
            perror( "accept" );
            exit(-1);
        }
	
		pthread_t t;
		pthread_attr_t attr;
   		pthread_attr_init(&attr);
   		pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);
		pthread_mutex_init(&mutex,NULL);
		pthread_create(&t, &attr, (void * (*)(void *))processThreadRequest, (void *)slaveSocket);
   	}
}

void processThreadRequest(int slaveSocket) {
	processRequest(slaveSocket);
	close(slaveSocket);
}

void processRequest(int fd) {
    char msg[5000] = {0};
    int msglen = 0;
    int n;
	char** splitCommend;
    
    // Currently character read
    unsigned char newChar;
	unsigned char lastChar = 0;
    
    while (msglen < 5000 && (n = read(fd, &newChar, sizeof(newChar))) > 0) {
		if (lastChar == '\015' && newChar == '\012') {
			msglen--;
			break;
		}
        msg[msglen] = newChar;
        msglen++;
		lastChar = newChar;
    }
    // Add null character at the end of the string
    msg[msglen] = 0;   
    printf("msg:%s$\n", msg);
	/*
	Server receive:
	createu|user|pw
	loginur|user|pw
	createe|user|time|des|loc
	deletee|user|time|des|loc
	loadevs|user

	Server send:
	SUCCESS
	Database error
	User already exist
	Unmatched username and password
	User not exist
	Invalid event information
	Fail to load event list
	id|time|des|loc||...
	*/
	splitCommend = split(msg, '|');

	if (!strcmp(splitCommend[0], "createu")) {
		char *username = splitCommend[1];
		char *password = splitCommend[2];

		int reval = database.addUser(username, password);
		if (reval == -1)
			write(fd, DBERROR, strlen(DBERROR));
		else if (reval == -2)
			write(fd, USREXIST, strlen(USREXIST));			
		else
			write(fd, SUCCESS, strlen(SUCCESS));
	}
	else if (!strcmp(splitCommend[0], "loginur")) {
		char *username = splitCommend[1];
		char *password = splitCommend[2];

		int reval = database.passwordCheck(username, password);
		if (reval == -1)
			write(fd, DBERROR, strlen(DBERROR));
		else if (reval == 0)
			write(fd, WRONGPW, strlen(WRONGPW));
		else
			write(fd, SUCCESS, strlen(SUCCESS));
	}
	else if (!strcmp(splitCommend[0], "createe")) {
		char *username = splitCommend[1];
		char *eventtime = splitCommend[2];
		char *eventdes = splitCommend[3];
		char *eventloc = splitCommend[4];

		int reval = database.createEvent(username, eventtime, eventdes, eventloc);
		if (reval == -1)
			write(fd, DBERROR, strlen(DBERROR));
		else if (reval == -2)
			write(fd, USRNOTEXIST, strlen(USRNOTEXIST));
		else if (reval == -3)
			write(fd, WRONGEVENTINFO, strlen(WRONGEVENTINFO));
		else
			write(fd, SUCCESS, strlen(SUCCESS));
	}
	else if (!strcmp(splitCommend[0], "deletee")) {
		char *username = splitCommend[1];
		char *eventtime = splitCommend[2];
		char *eventdes = splitCommend[3];
		char *eventloc = splitCommend[4];

		int reval = database.deleteEvent(username, eventtime, eventdes, eventloc);
		if (reval == -1)
			write(fd, DBERROR, strlen(DBERROR));
		else if (reval == -2)
			write(fd, USRNOTEXIST, strlen(USRNOTEXIST));
		else if (reval == -3)
			write(fd, WRONGEVENTINFO, strlen(WRONGEVENTINFO));
		else
			write(fd, SUCCESS, strlen(SUCCESS));
	}
	else if (!strcmp(splitCommend[0], "loadevs")) {
		char *username = splitCommend[1];

		if (!database.ifUserExist(username))
			write(fd, USRNOTEXIST, strlen(USRNOTEXIST));
		else {
			char *eventlist = database.getUserEventList(username);
			if (eventlist != NULL)
				write(fd, eventlist, strlen(eventlist));
			else
				write(fd, LOADEVENTLISTERROR, strlen(LOADEVENTLISTERROR));
		}
	}
	else
		write(fd, "check connection\n", 17);
}

char** split(char* str, char id){
	splitLength = 1;
	if (str==NULL)
		return NULL;
	int size = 1;
	for (int i = strlen(str) - 1; i >= 0 && str[i] == id; i--)
		str[i] = 0;
	for (int i = 1; i < strlen(str) && i != 0; i++)
		if (str[i] == id)
			size++;
	char** splited = (char**)malloc((size + 1) * sizeof(char*));
	splited[size] = NULL;
	splited[0] = (char*)malloc(strlen(str) + 1);
	
	for (int i = 0, l = 0, k = 0; i < strlen(str); i++) {
		if (str[i] == id){
			splited[++l] = (char*)malloc(strlen(str) + 1);
			splitLength++;
			k = 0;
		}
		else{
			splited[l][k++] = str[i];
			splited[l][k] = 0;
		}
	}
	return splited;
}




