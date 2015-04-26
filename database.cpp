#include <stdio.h>
#include <stdlib.h>
#include <sqlite3.h> 
#include <string.h>
#include <cstring>
#include <ctime>
#include "database.h"
#include "Server.h"

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
							   		"PRETEST		TEXT,"
									"COMMENT		TEXT);";

const char *SQL_INSERT_USER = 	"INSERT INTO USER (USERNAME, PASSWORD, EMAIL, NICKNAME) "
							  	"VALUES ('%s', '%s', '%s', '%s');";

const char *SQL_CHECK_USER = 	"SELECT USERNAME from USER where USERNAME like '%s';";

const char *SQL_CHECK_COURSE = 	"SELECT COURSENAME from COURSE where COURSENAME like '%s';";

const char *SQL_CHECK_PASSWORD = 	"SELECT USERNAME from USER where "
								 	"USERNAME like '%s' and PASSWORD like '%s';";

const char *SQL_UPDATE_PASSWORD = "UPDATE USER SET PASSWORD = '%s' WHERE USERNAME = '%s';";

const char *SQL_UPDATE_EMAIL = "UPDATE USER SET EMAIL = '%s' WHERE USERNAME = '%s';";

const char *SQL_UPDATE_NICKNAME = "UPDATE USER SET NICKNAME = '%s' WHERE USERNAME = '%s';";

const char *SQL_UPDATE_COURSE = "UPDATE USER SET COURSES = '%s' WHERE USERNAME = '%s';";

const char *SQL_UPDATE_RATING = "UPDATE COURSE SET RATING = '%s' WHERE COURSENAME = '%s';";

const char *SQL_GET_TAGS = "SELECT TAGS from COURSE where COURSENAME like '%s';";

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
int courseCount;
int tagflag; //indicate get tags(0), get tag counts(1), select course(2)
char *urtags;


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

int cbIfCourseExist(void *NotUsed, int argc, char **argv, char **azColName) {
	int i;
	courseCount++;
	for(i = 0; i < argc; i++){
		fprintf(stderr, "%d %s = %s\n",argc, azColName[i], argv[i] ? argv[i] : "NULL");
	}
	return 0;
}

int Databases::ifCourseExist(char* courseName) {
	char checkBuffer[300];	
	sprintf(checkBuffer, SQL_CHECK_COURSE, courseName);
	courseCount = 0;
	rc = sqlite3_exec(coursedb, checkBuffer, cbIfCourseExist, 0, &zErrMsg);

	if( rc != SQLITE_OK ){
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return -1;
	}
	
	return courseCount;
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
	
	fprintf(stderr, "change -- name = %s, email = %s\n", userName, email);
	
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
		//fprintf(stderr, "%d %s = %s\n",argc, azColName[i], argv[i] ? argv[i] : "NULL");
		if (!strcmp(azColName[i], "TAGS")) {
			if (tagflag == 0) {
				int j, k, tags[10] = {0};
				//change into 3 ints
				for (j = 0; j < 10; j++) {
					char temp[5] = {0};
					strncpy(temp, argv[i] + j * 5, 4);
					tags[j] = atoi(temp);
				}
				/*
				for (j = 0; j < 10; j++)
					fprintf(stderr, "%d ", tags[j]);
				*/
				int in1 = -1, in2 = -1, in3 = -1;
				for (j = 0; j < 10; j++) {
					if (in1 == -1)
						in1 = j;
					in1 = tags[j] >= tags[in1] ? j : in1;
				}
				for (j = 0; j < 10; j++) {
					if (j != in1) {
						if (in2 == -1)
							in2 = j;
						in2 = tags[j] >= tags[in2] ? j : in2;
					}
				}
				for (j = 0; j < 10; j++) {
					if (j != in1 && j != in2) {
						if (in3 == -1)
							in3 = j;
						in3 = tags[j] >= tags[in3] ? j : in3;
					}
				}
				//fprintf(stderr, "index: %d %d %d\n", in1, in2, in3);
				char tagtouser[4] = {0};
				int small = 0, middle = 0, large = 0;
				if (in1 > in2 && in1 > in3) {
					tagtouser[2] = in1 + '0';
					if (in2 > in3) {
						tagtouser[1] = in2 + '0';
						tagtouser[0] = in3 + '0';
					}
					else {
						tagtouser[0] = in2 + '0';
						tagtouser[1] = in3 + '0';
					}
				}
				else if (in2 > in1 && in2 > in3) {
					tagtouser[2] = in2 + '0';
					if (in1 > in3) {
						tagtouser[1] = in1 + '0';
						tagtouser[0] = in3 + '0';
					}
					else {
						tagtouser[0] = in1 + '0';
						tagtouser[1] = in3 + '0';
					}
				}
				else if (in3 > in1 && in3 > in2) {
					tagtouser[2] = in3 + '0';
					if (in2 > in1) {
						tagtouser[1] = in2 + '0';
						tagtouser[0] = in1 + '0';
					}
					else {
						tagtouser[0] = in2 + '0';
						tagtouser[1] = in1 + '0';
					}
				}
				/*
				tagtouser[0] = in1 + '0';
				tagtouser[1] = in2 + '0';
				tagtouser[2] = in3 + '0';
				*/
				//fprintf(stderr, "tag2user: %s$\n", tagtouser);
				strcat((char*)info, tagtouser);
				strcat((char*)info, "|");
			}
			else if (tagflag == 2) {
				//select course
				if (!strcmp(urtags, "000")) {
					;
				}
			}
			else {
				//get raw tags string
				strcat((char*)info, argv[i] ? argv[i] : "");
			}
		}
		else {
			strcat((char*)info, argv[i] ? argv[i] : "");
			strcat((char*)info, "|");
		}
	}
	//printf("%s\n", (char*)info);
	return 0;
}

//liu
int Databases::updateTags(char* course, char* tags) {
	if (tags == NULL || !strcmp(tags, ""))
		return 1;
	int reval;
	char tagcount[100];
	memset(tagcount, 0, 100);
	char checkBuffer[300];
	memset(checkBuffer, 0, 300);
	sprintf(checkBuffer, SQL_GET_TAGS, course);
	tagflag = 1;

	rc = sqlite3_exec(coursedb, checkBuffer, cbGetInfo, tagcount, &zErrMsg);
	if (rc != SQLITE_OK) {
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return -1;
	}
	fprintf(stderr, "tags:%s$\n", tagcount);
	
	//tags from user
	int tag1 = tags[0] - '0';
	int tag2 = tags[1] - '0';
	int tag3 = tags[2] - '0';
//	fprintf(stderr, "user tags: %d %d %d\n", tag1, tag2, tag3);
	if (!strcmp(tagcount, "")) {
		//firsttime
		int i;
		for (i = 0; i < 10; i++) {
			if (i == tag1 || i == tag2 || i == tag3) {
				strcat(tagcount, "0001;");
			}
			else {
				strcat(tagcount, "0000;");
			}
		}
		tagcount[strlen(tagcount) - 1] = 0;

		memset(checkBuffer, 0, 300);
		sprintf(checkBuffer, SQL_UPDATE_TAGS, tagcount, course);
		rc = sqlite3_exec(coursedb, checkBuffer, NULL, 0, &zErrMsg);
		if (rc != SQLITE_OK) {
			fprintf(stderr, "SQL error: %s\n", zErrMsg);
			sqlite3_free(zErrMsg);
			return -1;
		}
	}
	else {
		int i, count;
		char temp[5] = {0};
		char bytes[6] = {0};
		char newtagcount[100] = {0};
		for (i = 0; i < 10; i++) {
			//get old tag count
			strncpy(temp, tagcount + i * 5, 4);
			count = atoi(temp);
			//add 1
			if (i == tag1 || i == tag2 || i == tag3)
				count++;
			//fprintf(stderr, "new count %d\n", count);
			//strcat to newtagcount
			bytes[0] = count / 1000 + '0';
			bytes[1] = (count - count / 1000) / 100 + '0';
			bytes[2] = ((count - count / 1000) / 100) / 10 + '0';
			bytes[3] = count - ((count - count / 1000) / 100) / 10 + '0';
			bytes[4] = ';';
//			fprintf(stderr, "bytes %d is: %s\n", i, bytes);
			strcat(newtagcount, bytes);
		}
		newtagcount[strlen(newtagcount) - 1] = 0;
//		fprintf(stderr, "newcount: %s\n", newtagcount);

		memset(checkBuffer, 0, 300);
		sprintf(checkBuffer, SQL_UPDATE_TAGS, newtagcount, course);
		rc = sqlite3_exec(coursedb, checkBuffer, NULL, 0, &zErrMsg);
		if (rc != SQLITE_OK) {
			fprintf(stderr, "SQL error: %s\n", zErrMsg);
			sqlite3_free(zErrMsg);
			return -1;
		}

	}
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
	char courselist[2048];
	memset(courselist, 0, 2048);
	char *relist = (char*)malloc(2048);
	memset(relist, 0, 2048);
	char checkBuffer[300];
	urtags = tags;
	tagflag = 0;

	rc = sqlite3_exec(coursedb, SQL_GET_COURSELIST, cbGetInfo, courselist, &zErrMsg);
	if (rc != SQLITE_OK) {
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return NULL;
	}
	courselist[strlen(courselist) - 1] = 0;
	
	char **clisttag = split(courselist, '|');
	int i = 0;
	while (clisttag[i] != NULL) {
		//fprintf(stderr, "%d:%s$%s\n", i, clisttag[i], clisttag[i+1]);
		if (!strcmp(clisttag[i + 1], tags) || !strcmp(tags, "000")) {
			strcat(relist, clisttag[i]);
			strcat(relist, "|");
		}
		i = i + 2;
	}
	relist[strlen(relist) - 1] = '\0';
	//fprintf(stderr, "%s\n", relist); // CS381||CS307||CS180|
	return relist;
	//SQL_GET_COURSELIST
}

//liu
char* Databases::getCourse(char* course) {
	char *courseinfo = (char*)malloc(32768);
	memset(courseinfo, 0, 32768);
	char checkBuffer[300];
	sprintf(checkBuffer, SQL_GET_COURSE, course);
	tagflag = 0;
	
	rc = sqlite3_exec(coursedb, checkBuffer, cbGetInfo, courseinfo, &zErrMsg);
	if (rc != SQLITE_OK) {
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return NULL;
	}
	
	/* Unused code, use to init course tag
	char * tag = courseinfo;
	for ( int i = 0; i < 3; i++ ) {
		tag = strstr(tag, "|");
	}
	if ( *(tag+1) == '|' ) {
		*tag = '\0';
		fprintf(stderr, "%s\n", tag);	
		tag = tag+1;
		char * newcinfo = (char*)malloc(9999);
		memset(courseinfo, 0, 9999);
		sprintf(newcinfo, "%s|123%s", courseinfo, tag);
		//fprintf(stderr, "%s\n", newcinfo);	
		return newcinfo;
	}
	*/
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
//	fprintf(stderr, "rating is passed in database = %s\n", rating);
//	fprintf(stderr, "coursename is %s\n", course);
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
//	fprintf(stderr,"here the rate is %.1f\n", rate);
	char* courseinfo = (char*) malloc(32768);
	memset(courseinfo, 0, 32768);
	char sql_to_execute[300];
	sprintf(sql_to_execute, SQL_GET_COURSE, course);
	rc = sqlite3_exec(coursedb, sql_to_execute, cbGetInfo, courseinfo, &zErrMsg);
	if (rc != SQLITE_OK) {
//		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		return 0;
	}
//	fprintf(stderr, "courseinfo is :%s\n", courseinfo);
	char* pt = strstr(courseinfo, "|");
//	fprintf(stderr,"11111 here the char is\n");
	char rat[8] = {0};
	int counter = 0;
	pt++;
	while (*pt != '|') {
//		printf("entered!\n");
		rat[counter++] = *pt;
		pt++;
	}
	rat[counter] = '\0';
//	fprintf(stderr, "original rate: %s\n", rat);
	double c_rate;
	char t_people[8] = {0};//(char*) malloc(sizeof(char) * 8);
	int total;
	if (rat == NULL || !strcmp(rat, "")) {
		c_rate = 0.0;
	}
	else if (rat[0] == '6') {
		char m = rat[1];
		c_rate = ((double)(0 + (m - '0')))/10;
	} 
	else {
		char t1 = rat[0];
		char t2 = rat[1];
		double tt1 = (0 + (t1- '0'));
		double tt2 = ((double)(0 + (t2 - '0')))/10;
		c_rate = tt1+tt2;
	}
//	fprintf(stderr,"current rate is %.1f\n", c_rate);
	int c = 2;
	while (rat[c] != '\0') {
		t_people[c-2] = rat[c++];
	}
	if (t_people[0] == '\0')	total = 0;
	total = atoi(t_people);
	c_rate = c_rate*total;
	total++;
	c_rate+=rate;
	c_rate = (double)c_rate/total;
//	fprintf(stderr, "now the rate is %.1f\n", c_rate);
	char to_be_update[10] = {0};
	if (c_rate < 1) {		
		to_be_update[0] = '6';
		int temp = c_rate*10;
//		fprintf(stderr, "dec is %d\n", temp);
		char rated = (char)(((int)'0')+temp);
		to_be_update[1] = rated;
	} else {
		int temp1 = (int)c_rate;
		int temp2 = c_rate*10 - 10*temp1;
//		printf("temp 2 is %d\n", temp2);
		char tem1 = (char)(((int)'0')+temp1);
		char tem2 = (char)(((int)'0')+temp2);
		to_be_update[0] = tem1;
		to_be_update[1] = tem2;
	}
	char ppl[15] = {0};
	sprintf(ppl, "%d", total);
//	fprintf(stderr, "ppl is %s\n", ppl);
	strcat(to_be_update, ppl);
//	fprintf(stderr, "the write back thing is %s\n", to_be_update);
	char query2[300];
	sprintf(query2, SQL_UPDATE_RATING, to_be_update, course);
	rc = sqlite3_exec(coursedb, query2, NULL, 0, &zErrMsg);
	if (rc != SQLITE_OK) {
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		free(courseinfo);
		return 0;
	}
	free(courseinfo);
	return 0;
}

/**
 *	qi33
 *	Use to update the comment
 *	If there is no comment, then add a new comment
 *	Otherwise will concatenate the new comment after original comment list
 *	Comment use '||' to separate
 *	No maximum comments
 **/
 
// Set to 1 to start debug
int debug_for_comment = 0; 
 
int Databases::updateComment(char* course, char* comment) {

	if ( debug_for_comment ) {
		fprintf( stderr, "\nStart Update Comment\n" );
		fprintf( stderr, "Update Comment: course = %s, comment = %s\n", course, comment );
	}
	
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
	
	if ( debug_for_comment ) {
		fprintf( stderr, "The course: %s\n", courseInfo );
	}
	
	// Get the current course comment
	char* start = strstr( courseInfo, "User" );
	
	if ( debug_for_comment ) {
		fprintf( stderr, "Current comment: %s\n", start );
	}
	
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
		
		if ( debug_for_comment ) {
			fprintf( stderr, "Update Comment Finished\n\n" );
		}
		return 1;
	}
	else {
		// Add the comment after the current comment
		char* new_comment = (char*)malloc( strlen(start)+5+strlen(comment) );
		sprintf( new_comment, "%s%s", start, comment );
		
		if ( debug_for_comment ) {		
			fprintf( stderr, "New comment: %s\n", new_comment );	
		}
		
		// Update the new course comment
		char commitBuffer[9999];
		sprintf( commitBuffer, SQL_UPDATE_COMMENT, new_comment, course );
		rc = sqlite3_exec( coursedb, commitBuffer, NULL, 0, &zErrMsg );
		if (rc != SQLITE_OK) {
			fprintf(stderr, "SQL error: %s\n", zErrMsg);
			sqlite3_free(zErrMsg);
			return -1;
		}
		
		if ( debug_for_comment ) {
			fprintf( stderr, "Update Comment Finished\n\n" );
		}
		return 1;
	}
}

void encode ( char * plainText ){
	encrypt( "cs307", plainText );
}

void decode ( char * plainText ){
	decrypt( "cs307", plainText );
}

void encrypt( char *key, char *string )
{
    int i, string_length = strlen(string);
    //fprintf(stderr, "strlen = %d\n", string_length );

    for( i=0; i < string_length; i++)
    {
        string[i]=string[i]^key[i];
        string[i]+=1;
    }
}


void decrypt( char *key, char *string )
{
    int i, string_length = strlen(string);

    for( i=0; i < string_length; i++)
    {
    	string[i]-=1;
        string[i]=string[i]^key[i];
        
    }
}





