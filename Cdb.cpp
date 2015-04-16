#include <stdio.h>
#include <stdlib.h>
#include <sqlite3.h> 
#include <string.h>
#include <cstring>
#include <ctime>
#include "database.h"
#include "Server.h"

const char *COURSE_DATABASE_NAME = 	"PCA_course.db";

const char *SQL_CREATE_COURSE = 	"CREATE TABLE IF NOT EXISTS COURSE("
							   		"COURSENAME		TEXT	NOT NULL,"
							   		"RATING			TEXT,"
							   		"DESCRIPTION	TEXT	NOT NULL,"
									"TAGS			TEXT,"
							   		"PRETEST		TEXT,"
									"COMMENT		TEXT);";

const char *SQL_INSERT_COURSE = 	"INSERT INTO COURSE (COURSENAME, DESCRIPTION, TAGS, PRETEST) "
							  		"VALUES ('%s', '%s', '%s', '%s');";


sqlite3 *coursedb;
char *zErrMsg = 0;
int rc;


int initDatabases() {
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

int insertCourses(char* coursename, char* description, char* pretest) {
	char insertBuffer[2048];
	char tags[50] = "0000;0000;0000;0000;0000;0000;0000;0000;0000;0000";
	sprintf(insertBuffer, SQL_INSERT_COURSE, coursename, description, tags, pretest);
	rc = sqlite3_exec(coursedb, insertBuffer, NULL, 0, &zErrMsg);
	if( rc != SQLITE_OK ){
   		fprintf(stderr, "SQL error: %s\n", zErrMsg);
      	sqlite3_free(zErrMsg);
      	return -1;
   	}
   	return 0;
}


int main(int argc, char **argv) {
	initDatabases();
	insertCourses("CS381", "Algorithm", "test");
	insertCourses("CS307", "Software Engineering", "test");
	insertCourses("CS180", "O-O Programing", "test");
}





