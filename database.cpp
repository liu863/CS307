#include <stdio.h>
#include <stdlib.h>
#include <sqlite3.h> 
#include <string.h>
#include <cstring>
#include <ctime>
#include "database.h"

const char *DATABASE_NAME = "DEMODATABASE.db";

const char *SQL_CREATE_USER = "CREATE TABLE IF NOT EXISTS USER("
							  "USERNAME   TEXT      NOT NULL,"
							  "PASSWORD   CHAR(50)  NOT NULL);";

const char *SQL_CREATE_EVENT = "CREATE TABLE IF NOT EXISTS EVENT("
							   "USERNAME     TEXT      NOT NULL,"
							   "EVENTTIME    TEXT      NOT NULL,"
							   "DESCRIPTION  TEXT      NOT NULL,"
							   "LOCATION     TEXT);";

const char *SQL_INSERT_USER = "INSERT INTO USER (USERNAME, PASSWORD) "
							  "VALUES ('%s', '%s');";

const char *SQL_CHECK_USER = "SELECT USERNAME from USER where USERNAME like '%s';";

const char *SQL_CHECK_PASSWORD = "SELECT USERNAME from USER where "
								 "USERNAME like '%s' and PASSWORD like '%s';";

const char *SQL_ADD_EVENT = "INSERT INTO EVENT "
							"(USERNAME, EVENTTIME, DESCRIPTION, LOCATION) "
							"VALUES ('%s', '%s', '%s', '%s');";

const char *SQL_REMOVE_EVENT = "DELETE from EVENT where "
							   "USERNAME = '%s' and EVENTTIME = '%s' and "
							   "DESCRIPTION = '%s' and LOCATION = '%s';";

const char *SQL_GET_EVENT = "SELECT from EVENT where "
							"USERNAME like '%s';";


sqlite3 *db;
char *zErrMsg = 0;
int rc;
sqlite3_stmt *statement;
const char *pzTest;
int res = 0;
int userCount;


int 
Databases::initDatabases() {
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
	rc += sqlite3_exec(db, SQL_CREATE_EVENT, NULL, 0, &zErrMsg);

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

int
Databases::addUser(char* userName, char* password) {
	
    if (ifUserExist(userName))
		return -2;
	
	char insertBuffer[300];
	sprintf(insertBuffer, SQL_INSERT_USER, userName, password);
	rc = sqlite3_exec(db, insertBuffer, NULL, 0, &zErrMsg);
	if( rc != SQLITE_OK ){
   		fprintf(stderr, "SQL error: %s\n", zErrMsg);
      	sqlite3_free(zErrMsg);
      	return -1;
   	}

   	return 0;
}

int
cbIfUserExist(void *NotUsed, int argc, char **argv, char **azColName) {
	int i;
	userCount++;
	for(i = 0; i < argc; i++){
		fprintf(stderr, "%d %s = %s\n",argc, azColName[i], argv[i] ? argv[i] : "NULL");
	}

	return 0;
}

int 
Databases::ifUserExist(char* userName) {
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

int 
Databases::passwordCheck(char* userName, char* passWord){
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

int
Databases::createEvent(char* userName, char* eventDes, char* eventTime, char* eventLoc) {

	if (!ifUserExist(userName))
		return -2;

	if (eventDes == NULL || eventTime == NULL)
		return -3;

	char checkBuffer[300];
	sprintf(checkBuffer, SQL_ADD_EVENT, userName, eventDes, eventTime, eventLoc);
	rc = sqlite3_exec(db, checkBuffer, NULL, 0, &zErrMsg);
	
	if( rc != SQLITE_OK ){
   		fprintf(stderr, "SQL error: %s\n", zErrMsg);
      	sqlite3_free(zErrMsg);
      	return -1;
   	}
	
   	return 0;
}

int
Databases::deleteEvent(char* userName, char* eventDes, char* eventTime, char* eventLoc) {

	if (userName == NULL || !ifUserExist(userName))
		return -2;

	if (eventDes == NULL || eventTime == NULL)
		return -3;

	char checkBuffer[300];
	sprintf(checkBuffer, SQL_REMOVE_EVENT, userName, eventDes, eventTime, eventLoc);
	rc = sqlite3_exec(db, checkBuffer, NULL, 0, &zErrMsg);
	
	if( rc != SQLITE_OK ){
   		fprintf(stderr, "SQL error: %s\n", zErrMsg);
      	sqlite3_free(zErrMsg);
      	return -1;
   	}
	
   	return 0;
}

//time|des|loc||...
char* 
Databases::getUserEventList(char* userName) {
	char checkBuffer[300];
	sprintf(checkBuffer, SQL_GET_EVENT, userName);
	char tmp[999999] = {0};


	if (sqlite3_prepare(db, checkBuffer, -1, &statement, &pzTest) == SQLITE_OK) {
		fprintf(stderr, "prep ok\n");
		while (1) {
			res = sqlite3_step(statement);
			if (res == SQLITE_ROW){
				strcat(tmp, (char*)sqlite3_column_text(statement, 1));
				strcat(tmp, "|");
				strcat(tmp, (char*)sqlite3_column_text(statement, 2));
				strcat(tmp, "|");
				strcat(tmp, (char*)sqlite3_column_text(statement, 3));
				strcat(tmp, "||");
			}
			else {
				if (tmp == NULL || strlen(tmp) - 4 < 1)
					return NULL;
				char *re = (char*)malloc(strlen(tmp) - 1);
				strncpy(re, tmp, strlen(tmp) - 2);
				re[strlen(tmp) - 2] = 0;
				return re;
	        }
    	}
	}
	else
		return NULL;
}




