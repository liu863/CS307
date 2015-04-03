struct Databases{
	int initDatabases();
	int addUser(char* userName, char* password, char* email);
	int ifUserExist(char* userName);
	int passwordCheck(char* userName, char* password);
	int changeNickname(char* userName, char* nickname);
	int changeEmail(char* userName, char* email);
	int changeCourse(char* userName, char* course);
	int changePassword(char* userName, char* password);
	char* getUser(char* userName);
	char* getCourselist(char* tags);
	char* getCourse(char* course);
	int updateRating(char* course, char* rating);
	int updateTags(char* course, char* tags);
	int updateComment(char* course, char* comment);
	
	
	int destroyDatabases();	
	void closedatabase();
};
