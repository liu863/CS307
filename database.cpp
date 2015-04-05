#include <stdio.h>
#include <stdlib.h>
#include <sqlite3.h> 
#include <string.h>
#include <cstring>
#include <ctime>
#include "database.h"

const char *USER_DATABASE_NAME = 	"PCA_user.db";

const char *COURSE_DATABASE_NAME = 	"PCA_course.db";

const char *SQL_CREATE_USER = 	"CREATE TABLE IF NOT EXISTS USER("
							  	"USERNAME	TEXT		NOT NULL,"
							  	"PASSWORD	CHAR(50)	NOT NULL,"
								"EMAIL		TEXT		NOT NULL,"
								"NICKNAME	TEXT,"
								"COURSES	TEXT);";

const char *SQL_CREATE_COURSE = 	"CREATE TABLE IF NOT EXISTS COURSE("
							   		"COURSENAME		TEXT	NOT NULL,"
							   		"RATING			TEXT,"
							   		"DESCRIPTION	TEXT	NOT NULL,"
									"TAGS			TEXT,"
							   		"COMMENT		TEXT,"
									"PRETEST		TEXT);";

const char *SQL_INSERT_USER = 	"INSERT INTO USER (USERNAME, PASSWORD, EMAIL, NICKNAME) "
							  	"VALUES ('%s', '%s', '%s', '%s');";

const char *SQL_CHECK_USER = 	"SELECT USERNAME from USER where USERNAME like '%s';";

const char *SQL_CHECK_PASSWORD = 	"SELECT USERNAME from USER where "
								 	"USERNAME like '%s' and PASSWORD like '%s';";

const char *SQL_UPDATE_PASSWORD = "UPDATE USER SET PASSWORD = '%s' WHERE USERNAME = '%s';";

const char *SQL_UPDATE_EMAIL = "UPDATE USER SET EMAIL = '%s' WHERE USERNAME = '%s';";

const char *SQL_UPDATE_NICKNAME = "UPDATE USER SET NICKNAME = '%s' WHERE USERNAME = '%s';";

const char *SQL_UPDATE_COURSE = "UPDATE USER SET COURSES = '%s' WHERE USERNAME = '%s';";

const char *SQL_UPDATE_RATING = "UPDATE COURSE SET RATING = '%s' WHERE COURSENAME = '%s';";

const char *SQL_UPDATE_TAGS = "UPDATE COURSE SET TAGS = '%s' WHERE COURSENAME = '%s';";

const char *SQL_UPDATE_COMMENT = "UPDATE COURSE SET COMMENT = '%s' WHERE COURSENAME = '%s';";

const char *SQL_GET_USER = "SELECT * from USER where USERNAME like '%s';";

const char *SQL_GET_COURSE = "SELECT * from COURSE where COURSENAME like '%s';";

const char *SQL_GET_COURSELIST = "SELECT COURSENAME, TAGS from COURSE;";

sqlite3 *userdb, *coursedb;
char *zErrMsg = 0;
int rc;
sqlite3_stmt *statement;
const char *pzTest;
int res = 0;
int userCount;//if cbuser is called


int Databases::initDatabases() {
	rc = sqlite3_open(USER_DATABASE_NAME, &userdb);
	/* Open database */
	if (rc) {
		fprintf(stderr, "Can't open user database: %s\n", sqlite3_errmsg(userdb));
		return 0;
	}
	else {
      	fprintf(stdout, "Opened user database successfully\n");
	}

	rc = sqlite3_exec(userdb, SQL_CREATE_USER, NULL, 0, &zErrMsg);

	/* Execute SQL statement */
	if (rc != (SQLITE_OK * 3)){
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return -1;
	}
	else {
		fprintf(stdout, "User table created successfully\n");
	}
	
	
	rc = sqlite3_open(COURSE_DATABASE_NAME, &coursedb);

	if (rc) {
		fprintf(stderr, "Can't open course database: %s\n", sqlite3_errmsg(coursedb));
		return 0;
	}
	else {
      	fprintf(stdout, "Opened course database successfully\n");
	}
	
	rc = sqlite3_exec(coursedb, SQL_CREATE_COURSE, NULL, 0, &zErrMsg);
	if (rc != (SQLITE_OK * 3)){
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return -1;
	}
	else {
		fprintf(stdout, "Course table created successfully\n");
	}
	
	return 1;
}

int Databases::addUser(char* userName, char* password, char* email) {
	//if user already exists, return -2
    if (ifUserExist(userName))
		return -2;
	
	char insertBuffer[300];
	sprintf(insertBuffer, SQL_INSERT_USER, userName, password, email, userName);
	rc = sqlite3_exec(userdb, insertBuffer, NULL, 0, &zErrMsg);
	if( rc != SQLITE_OK ){
   		fprintf(stderr, "SQL error: %s\n", zErrMsg);
      	sqlite3_free(zErrMsg);
      	return -1;
   	}

   	return 0;
}

int cbIfUserExist(void *NotUsed, int argc, char **argv, char **azColName) {
	int i;
	userCount++;
	for(i = 0; i < argc; i++){
		fprintf(stderr, "%d %s = %s\n",argc, azColName[i], argv[i] ? argv[i] : "NULL");
	}

	return 0;
}

int Databases::ifUserExist(char* userName) {
	char checkBuffer[300];	
	sprintf(checkBuffer, SQL_CHECK_USER, userName);
	userCount = 0;
	rc = sqlite3_exec(userdb, checkBuffer, cbIfUserExist, 0, &zErrMsg);

	if( rc != SQLITE_OK ){
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return -1;
	}
	
	return userCount;
}

int Databases::passwordCheck(char* userName, char* passWord){
	char checkBuffer[300];
	sprintf(checkBuffer, SQL_CHECK_PASSWORD, userName, passWord);
	userCount = 0;
	rc = sqlite3_exec(userdb, checkBuffer, cbIfUserExist, 0, &zErrMsg);
	
	if(rc != SQLITE_OK){
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return -1;
	}
	
	return userCount;
}


int Databases::changeNickname(char* userName, char* nickName) {
	char checkBuffer[300];
	sprintf(checkBuffer, SQL_UPDATE_NICKNAME, nickName, userName);
	fprintf(stderr, "cheb: %s\n", checkBuffer);
	rc = sqlite3_exec(userdb, checkBuffer, NULL, 0, &zErrMsg);

	if (rc != SQLITE_OK) {
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return -1;
	}

	return 1;
}
//niu
int Databases::changeEmail(char* userName, char* email) {
	
	char checkBuffer[300];
	sprintf(checkBuffer, SQL_UPDATE_EMAIL, email, userName);
	fprintf(stderr, "cheb: %s\n", checkBuffer);
	rc = sqlite3_exec(userdb, checkBuffer, NULL, 0, &zErrMsg);

	if (rc != SQLITE_OK) {
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return -1;
	}

	return 1;
}
//xu
int Databases::changeCourse(char* userName, char* course) {
	char checkBuffer[300];
	sprintf(checkBuffer, SQL_UPDATE_COURSE, course, userName);
	fprintf(stderr, "cheb: %s\n", checkBuffer);
	rc = sqlite3_exec(userdb, checkBuffer, NULL, 0, &zErrMsg);

	if (rc != SQLITE_OK) {
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return -1;
	}

	return 1;
}
//xu
int Databases::changePassword(char* userName, char* password) {
	char checkBuffer[300];
	sprintf(checkBuffer, SQL_UPDATE_PASSWORD, password, userName);
	//fprintf(stderr, "cheb: %s\n", checkBuffer);
	rc = sqlite3_exec(userdb, checkBuffer, NULL, 0, &zErrMsg);

	if (rc != SQLITE_OK) {
		//fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return -1;
	}
	//fprintf(stderr, "cheb: %s\n", checkBuffer);
	return 1;
}
//liu
int cbGetInfo(void *info, int argc, char **argv, char **azColName) {
	int i;
	for(i = 0; i < argc; i++){
		fprintf(stderr, "%d %s = %s\n",argc, azColName[i], argv[i] ? argv[i] : "NULL");
		if (!strcmp(azColName[i], "RATING")) {
			strcat((char*)info, argv[i] ? argv[i] : "");
			strcat((char*)info, "|");;
		}
		else if (!strcmp(azColName[i], "TAGS")) {
			strcat((char*)info, argv[i] ? argv[i] : "");
			strcat((char*)info, "|");
		}
		else {
			strcat((char*)info, argv[i] ? argv[i] : "");
			strcat((char*)info, "|");
		}
	}
	//printf("%s\n", (char*)info);
	return 0;
}

char* Databases::getUser(char* userName) {
	char *userinfo = (char*)malloc(500);
	memset(userinfo, 0, 500);
	char checkBuffer[300];
	sprintf(checkBuffer, SQL_GET_USER, userName);

	rc = sqlite3_exec(userdb, checkBuffer, cbGetInfo, userinfo, &zErrMsg);
	if (rc != SQLITE_OK) {
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return NULL;
	}
	userinfo[strlen(userinfo) - 1] = 0;
	return userinfo;
}
//liu
char* Databases::getCourselist(char* tags) {
	char *courselist = (char*)malloc(2048);
	memset(courselist, 0, 2048);
	char checkBuffer[300];
	//sprintf(checkBuffer, SQL_GET_COURSELIST);

	rc = sqlite3_exec(coursedb, SQL_GET_COURSELIST, cbGetInfo, courselist, &zErrMsg);
	if (rc != SQLITE_OK) {
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return NULL;
	}
	courselist[strlen(courselist) - 1] = 0;
	return courselist;
	//SQL_GET_COURSELIST
}
//liu
char* Databases::getCourse(char* course) {
	char *courseinfo = (char*)malloc(32768);
	memset(courseinfo, 0, 32768);
	char checkBuffer[300];
	sprintf(checkBuffer, SQL_GET_COURSE, course);

	rc = sqlite3_exec(coursedb, checkBuffer, cbGetInfo, courseinfo, &zErrMsg);
	if (rc != SQLITE_OK) {
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return NULL;
	}
	courseinfo[strlen(courseinfo) - 1] = 0;
	return courseinfo;
}

//xu
//the format for rating: 6X == 0.X
//otherwise XX=X.X
//error: cannot greater than 6, need to check in client
//format for rating XXXXX first two means the rate and second XX means how many people rated
int Databases::updateRating(char* course, char* rating) {
	//get the newly arrived rating
	fprintf(stderr, "rating is passed in database = %s\n", rating);
	fprintf(stderr, "coursename is %s\n", course);
	double rate = 0.0;
	if (rating == NULL)
		return -1;
	if (rating[0] == '6') {
		rating[0] = rating[1];
		rating[1] = '\0';
		rate = atoi(rating) / 10;
	}
	else {
		rate = (double)atoi(rating)/10;
	}
	fprintf(stderr,"here the rate is %.1f\n", rate);
	char* courseinfo = (char*) malloc(32768);
	memset(courseinfo, 0, 32768);
	char sql_to_execute[300];
	sprintf(sql_to_execute, SQL_GET_COURSE, course);
	rc = sqlite3_exec(coursedb, sql_to_execute, cbGetInfo, courseinfo, &zErrMsg);
	if (rc != SQLITE_OK) {
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return 0;
	}
	fprintf(stderr, "courseinfo is :%s\n", courseinfo);
	char* pt = strstr(courseinfo, "|");
	fprintf(stderr,"11111 here the char is\n");
	char rat[8];
	int counter = 0;
	pt++;
	while (*pt != '|') {
		printf("entered!\n");
		rat[counter++] = *pt;
		pt++;
	}
	rat[counter] = '\0';
	fprintf(stderr, "original rate: %s\n", rat);
	double c_rate;
	char* t_people = (char*) malloc(sizeof(char) * 8);
	int total;
	if (rat == NULL) {
		c_rate = 0.0;
	}
	if (rat[0] == '6') {
		char m = rat[1];
		c_rate = atoi(&m)/10;
	} 
	fprintf(stderr,"current rate is %.1f\n", c_rate);
	int c = 2;
	while (rat[c] != '\0') {
		t_people[c-2] = rat[c++];
	}
	if (t_people[0] == '\0')	total = 0;
	total = atoi(t_people);
	total++;
	c_rate+=rate;
	c_rate = (double)c_rate/total;
	fprintf(stderr, "now the rate is %.1f\n", c_rate);
	char to_be_update[10];
	if (c_rate < 1) {		
		to_be_update[0] = '6';
		int temp = (int)c_rate*10;
		char rated = (char)(((int)'0')+temp);
		to_be_update[1] = rated;
	} else {
		int temp1 = (int)c_rate;
		int temp2 = c_rate*10 - 10*temp1;
		printf("temp 2 is %d\n", temp2);
		char tem1 = (char)(((int)'0')+temp1);
		char tem2 = (char)(((int)'0')+temp2);
		to_be_update[0] = tem1;
		to_be_update[1] = tem2;
	}
	char ppl[15];
	sprintf(ppl, "%d", total);
	strcat(to_be_update, ppl);
	fprintf(stderr, "the write back thing is %s\n", to_be_update);
	char query2[300];
	sprintf(query2, SQL_UPDATE_RATING, to_be_update, course);
	rc = sqlite3_exec(coursedb, query2, NULL, 0, &zErrMsg);
	if (rc != SQLITE_OK) {
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return 0;
	}
	return 0;
}
//liu
int Databases::updateTags(char* course, char* tags) {
	return 0;
}

//xu
int Databases::updateComment(char* course, char* comment) {
	fprintf( stderr, "\nStart Update Comment\n" );
	fprintf( stderr, "Update Comment: course = %s, comment = %s\n", course, comment );
	
	// Get the current course info
	char sql_command[300];
	sprintf( sql_command, SQL_GET_COURSE, course );
	char* courseInfo = (char*)malloc( 9999*sizeof(char) );
	memset( courseInfo, 0, 9999 );
	rc = sqlite3_exec( coursedb, sql_command, cbGetInfo, courseInfo, &zErrMsg );
	
	if (rc != SQLITE_OK) {
		fprintf( stderr, "SQL error: %s\n", zErrMsg );
		sqlite3_free(zErrMsg);
		return 0;
	}
	fprintf( stderr, "The course: %s\n", courseInfo );
	
	// Get the current course comment
	char* start = strstr( courseInfo, "User" );
	fprintf( stderr, "Current comment: %s\n", start );
	
	// Check if this is the first comment
	if ( start == NULL ) {
		// Update the new course comment
		char commitBuffer[9999];
		sprintf( commitBuffer, SQL_UPDATE_COMMENT, comment, course );
		rc = sqlite3_exec( coursedb, commitBuffer, NULL, 0, &zErrMsg );
		if (rc != SQLITE_OK) {
			fprintf(stderr, "SQL error: %s\n", zErrMsg);
			sqlite3_free(zErrMsg);
			return -1;
		}
		fprintf( stderr, "Update Comment Finished\n\n" );
		return 1;
	}
	else {
		// Add the comment after the current comment
		char* new_comment = (char*)malloc( strlen(start)+5+strlen(comment) );
		sprintf( new_comment, "%s%s", start, comment );
		fprintf( stderr, "New comment: %s\n", new_comment );	
	
		// Update the new course comment
		char commitBuffer[9999];
		sprintf( commitBuffer, SQL_UPDATE_COMMENT, new_comment, course );
		rc = sqlite3_exec( coursedb, commitBuffer, NULL, 0, &zErrMsg );
		if (rc != SQLITE_OK) {
			fprintf(stderr, "SQL error: %s\n", zErrMsg);
			sqlite3_free(zErrMsg);
			return -1;
		}
		fprintf( stderr, "Update Comment Finished\n\n" );
		return 1;
	}
}







