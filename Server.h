struct Server {
	static struct Database database;

	
};

int createu(char **commendList);
int loginur(char **commendList);
char* getuinf(char **commendList);
char* getclst(char **commendList);
int resetpw(char **commendList);
int changen(char **commendList);
int changee(char **commendList);
int changec(char **commendList);
char* getcinf(char **commendList);
void comment(char **commendList);
char** split(char* str, char id);

void processRequest(int socket);
void processThreadRequest(int slaveSocket);
