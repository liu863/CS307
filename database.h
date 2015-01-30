struct Databases{
	int initDatabases();
	int addUser(char* userName, char* password);
	int ifUserExist(char* userName);
	int passwordCheck(char* userName, char* password);
	int createEvent(char* userName, char* eventDes, char* eventTime, char* eventLoc);
	int deleteEvent(char* userName, char* eventDes, char* eventTime, char* eventLoc);
	char* getUserEventList(char* userName);
	
	int destroyDatabases();	
	void closedatabase();
};
