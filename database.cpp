#include <stdio.h>
#include <stdlib.h>
#include <sqlite3.h> 
#include <string.h>
#include <cstring>
#include <ctime>
#include "database.h"

const char *DATABASE_NAME = 	"PCA.db";

const char *SQL_CREATE_USER = 	"CREATE TABLE IF NOT EXISTS USER("
							  	"USERNAME	TEXT		NOT NULL,"
							  	"PASSWORD	CHAR(50)	NOT NULL,"
								"EMAIL		TEXT		NOT NULL,"
								"NICKNAME	TEXT,"
								"COURSES	TEXT);";

const char *SQL_CREATE_COURSE = 	"CREATE TABLE IF NOT EXISTS COURSE("
							   		"COURSENAME		TEXT	NOT NULL,"
							   		"RATING			TEXT"
							   		"DESCRIPTION	TEXT	NOT NULL,"
									"TAGS			TEXT,"
							   		"COMMENT		TEXT,"
									"PRETEST		TEXT);";

const char *SQL_INSERT_USER = 	"INSERT INTO USER (USERNAME, PASSWORD, EMAIL) "
							  	"VALUES ('%s', '%s', '%s');";

const char *SQL_CHECK_USER = 	"SELECT USERNAME from USER where USERNAME like '%s';";

const char *SQL_CHECK_PASSWORD = 	"SELECT USERNAME from USER where "
								 	"USERNAME like '%s' and PASSWORD like '%s';";

const char *SQL_ADD_EVENT = 	"INSERT INTO EVENT "
								"(USERNAME, EVENTTIME, DESCRIPTION, LOCATION) "
								"VALUES ('%s', '%s', '%s', '%s');";

const char *SQL_REMOVE_EVENT = 	"DELETE from EVENT where "
							   	"USERNAME = '%s' and EVENTTIME = '%s' and "
							   	"DESCRIPTION = '%s' and LOCATION = '%s';";

const char *SQL_GET_EVENT = 	"SELECT from EVENT where "
								"USERNAME like '%s';";


sqlite3 *db;
char *zErrMsg = 0;
int rc;
sqlite3_stmt *statement;
const char *pzTest;
int res = 0;
int userCount;


int Databases::initDatabases() {
	rc = sqlite3_open(DATABASE_NAME, &db);
	/* Open database */
	if (rc) {
		fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
		return 0;
	}
	else {
      	fprintf(stdout, "Opened database successfully\n");
	}

	rc = sqlite3_exec(db, SQL_CREATE_USER, NULL, 0, &zErrMsg);
	rc += sqlite3_exec(db, SQL_CREATE_COURSE, NULL, 0, &zErrMsg);

	/* Execute SQL statement */
	if (rc != (SQLITE_OK * 3)){
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return -1;
	}
	else {
		fprintf(stdout, "Table created successfully\n");
	}
	
	return 1;
}

int Databases::addUser(char* userName, char* password, char* email) {
	
    if (ifUserExist(userName))
		return -2;
	
	char insertBuffer[300];
	sprintf(insertBuffer, SQL_INSERT_USER, userName, password, email);
	rc = sqlite3_exec(db, insertBuffer, NULL, 0, &zErrMsg);
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
	rc = sqlite3_exec(db, checkBuffer, cbIfUserExist, 0, &zErrMsg);

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
	rc = sqlite3_exec(db, checkBuffer, cbIfUserExist, 0, &zErrMsg);
	
	if(rc != SQLITE_OK){
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return -1;
	}
	
	return userCount;
}

int Databases::changeNickname(char* userName, char* nickname) {
	return 0;
}

int Databases::changeEmail(char* userName, char* email) {
	return 0;
}

int Databases::changeCourse(char* userName, char* course) {
	return 0;
}

int Databases::changePassword(char* userName, char* password) {
	return 0;
}

char* Databases::getUser(char* userName) {
	return NULL;
}

char* Databases::getCourselist(char* tags) {
	return NULL;
}

char* Databases::getCourse(char* course) {
	return NULL;
}

int Databases::updateRating(char* course, char* rating) {
	return 0;
}

int Databases::updateTags(char* course, char* tags) {
	return 0;
}

int Databases::updateComment(char* course, char* comment) {
	return 0;
}







