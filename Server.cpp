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

const char *DBERROR = "Database error\n";

const char *SUCCESS = "SUCCESS\n";

const char *XUEBENG = "XUEBENG\n";

const char *UREXIST = "urexist\n";

const char *LGNFAIL = "lgnfail\n";

const char *UNEXIST = "unexist\n";


extern "C" void background(int sig) {
	int status;
	struct rusage usage;
	pid_t pid = wait3(&status, 0, &usage);
}
    
int QueueLength = 5;
pthread_mutex_t mutex;
int port = 6667;
char cport[20] = {0};
int splitLength = 0;
struct Databases database;

//Processes time request

int main(int argc, char **argv) {
	if (database.initDatabases() != 1) {
		fprintf(stderr, "Database start error\n");
		exit(-1);
	}
    	
    	//Set the IP address and port for this server
    	struct sockaddr_in serverIPAddress; 
    	memset( &serverIPAddress, 0, sizeof(serverIPAddress) );
    	serverIPAddress.sin_family = AF_INET;
    	serverIPAddress.sin_addr.s_addr = INADDR_ANY;
   		serverIPAddress.sin_port = htons((u_short) port);
    
    	//Allocate a socket
    	int masterSocket =  socket(PF_INET, SOCK_STREAM, 0);
    	if ( masterSocket < 0) {
        	perror("socket");
        	exit(-1);
    	}
    
    	//Set socket options to reuse port. Otherwise we will
    	//have to wait about 2 minutes before reusing the same port number
    	int optval = 1; 
    	int err = setsockopt(masterSocket, SOL_SOCKET, SO_REUSEADDR, (char*)&optval, sizeof(int));
    
    	//Bind the socket to the IP address and port
    	int error = bind(masterSocket, (struct sockaddr *)&serverIPAddress, sizeof(serverIPAddress)); 
	if (error) {
        	perror("bind");
        	exit(-1);
    	}
    
    	//Put socket in listening mode and set the 
    	//size of the queue of unprocessed connections
    	error = listen( masterSocket, QueueLength);
    	if (error) {
       	perror("listen");
        	exit(-1);
    	}

	signal(SIGCHLD, background);

    	while (1) {
        
        //Accept incoming connections
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
    
    //Currently character read
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
	
	splitCommend = split(msg, '|');

	if (!strcmp(splitCommend[0], "createu")) {
		int reval = createu(splitCommend);
		if (reval == -1) {
			write(fd, DBERROR, strlen(DBERROR));
		}
		else if (reval == -2) {
			write(fd, UREXIST, strlen(UREXIST));
		}	
		else {
			write(fd, SUCCESS, strlen(SUCCESS));
		}
	}

	/* Newly Added' */
	else if (!strcmp(splitCommend[0], "loginur")) {
		int reval = loginur(splitCommend);
		if (reval == -1)
			write(fd, DBERROR, strlen(DBERROR));
		else
			write(fd, SUCCESS, strlen(SUCCESS));
	}
	else if (!strcmp(splitCommend[0], "getuinf")) {
		char* reval = "aaa";//getuinf(splitCommend);
		if(reval != NULL)
			write(fd, "name|password|email", strlen("name|password|email"));
		else
			write(fd, DBERROR, strlen(DBERROR));
	}
	else if (!strcmp(splitCommend[0], "getclst")) {
		char* reval = getclst(splitCommend);
		if(reval != NULL)
			write(fd, SUCCESS, strlen(SUCCESS));
		else
			write(fd, DBERROR, strlen(DBERROR));
	}
	else if (!strcmp(splitCommend[0], "resetpw")) {
		int reval = resetpw(splitCommend);
		if(reval == 1)
			write(fd, SUCCESS, strlen(SUCCESS));
		else
			write(fd, DBERROR, strlen(DBERROR));
	}
	else if (!strcmp(splitCommend[0], "changen")) {
		int reval = changen(splitCommend);
		if(reval == 1)
			write(fd, SUCCESS, strlen(SUCCESS));
		else
			write(fd, DBERROR, strlen(DBERROR));
	}
	else if (!strcmp(splitCommend[0], "changee")) {
		int reval = changee(splitCommend);
		if(reval == 1)
			write(fd, SUCCESS, strlen(SUCCESS));
		else
			write(fd, DBERROR, strlen(DBERROR));
	}

	/* Newly Added */
	else if ( !strcmp(splitCommend[0], "changec") ) {
		int reval = changec(splitCommend);
		if (reval == -1) {
			write(fd, "change course err\n", strlen("change course err\n"));
		}
		else if (reval == 0) {
			write(fd, "callback err\n", strlen("callback err\n"));
		}
		else {
			write(fd, "change course success\n", strlen("change course success\n"));
		}
	}
	else if ( !strcmp(splitCommend[0], "getcinf") ) {
		char * courseinfo = getcinf(splitCommend);

		if (courseinfo == NULL) {
			write(fd, "courseinfo err\n", strlen("courseinfo err\n"));
		}
		else {
			write (fd, courseinfo, strlen(courseinfo));
			write(fd, "courseinfo success\n", strlen("comment success\n"));
			
		}
	}

	else if ( !strcmp(splitCommend[0], "comment") ) {
		char * username = splitCommend[1];
		char * course = splitCommend[2];
		char * rating = splitCommend[3];
		char * tags = splitCommend[4];
		char * comments = splitCommend[5];

		int reval = database.ifUserExist(username);
		if (reval == -1) {
			write(fd, "comment database err\n", strlen("comment database err\n"));
		}
		else if (reval == 0) {
			write(fd, "comment call back err\n", strlen("comment call back err\n"));
		}
		else {
			comment(splitCommend);
			write(fd, "comment success\n", strlen("comment success\n"));
		}
	}

	else
		write(fd, "check connection\n", 17);
}

/* return 1 if create success
   return 0 otherwise */
int createu(char **commendList) {
	char *username = commendList[1];
	char *password = commendList[2];
	char *email = commendList[3];

	int reval = database.addUser(username, password, email);
	return reval;
	
}

/* return 1 if create success
   return 0 otherwise */
int loginur(char **commendList) {
	char *username = commendList[1];
	char *password = commendList[2];
	int reval = database.passwordCheck(username, password);
	return reval;
}

/* return user info */
char* getuinf(char **commendList) {
	char *username = commendList[1];
	char* reval = database.getUser(username);
	return reval;
}

/* return course list 
   [with or without tags] */
char* getclst(char **commendList) {
	char* reval;
	if(commendList[1]==NULL) {//check!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		reval = database.getCourselist((char *)"000");
	}
	else {
		char *tags = commendList[1];
		reval = database.getCourselist(tags);
	}
	return reval;
}

/* return 1 if create success
   return 0 otherwise */
int resetpw(char **commendList) {
	char *username = commendList[1];
	char *email_address = commendList[2];
	int reset = (rand() % (999999 - 100000 + 1)) + 100000;
	//to do send reset to email
	char *password;
	sprintf(password, "%d\0", reset);
	int reval = database.changePassword(username, password);//check cast
	return reval;
}

/* return 1 if create success
   return 0 otherwise */
int changen(char **commendList) {
	char *username = commendList[1];
	char *new_nickname = commendList[2];
	int reval = database.changeNickname(username, new_nickname);
	return reval;
}

/* return 1 if create success
   return 0 otherwise */
int changee(char **commendList) {
	char *username = commendList[1];
	char *new_email_address = commendList[2];
	int reval = database.changeEmail(username, new_email_address);
	return reval;
}

/* return 1 if create success
   return 0 otherwise */
int changec(char **commendList) {
	char * user = commendList[1];
	char * coursetoken = commendList[2];
	return database.changeCourse(user, coursetoken);
}

/* return course info */
char* getcinf(char **commendList) {
	char * course = commendList[1];
	return database.getCourse(course);
}

/* update comment */
void comment(char **commendList) {
	char * course = commendList[2];
	char * rating = commendList[3];
	if ( rating[0] == 6 ) {
		rating[0] = 0;
	}
	char * tags = commendList[4];
	char * comment = (char*)malloc(strlen(commendList[1])+10+strlen(commendList[5]));
	*comment = '\0';
	strcat(comment, "User ");
	strcat(comment, commendList[1]);
	strcat(comment, ": ");
	strcat(comment, commendList[5]);
	database.updateComment(course, comment); 
	database.updateRating(course, rating); 
	database.updateTags(course, tags);
}

char** split(char* str, char id) {
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




