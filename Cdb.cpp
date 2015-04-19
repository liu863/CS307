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
	insertCourses("CS180", "Problem solving and algorithms, implementation of algorithms in a high level programming language, conditionals, the iterative approach and debugging, collections of data, searching and sorting, solving problems by decomposition, the object-oriented approach, subclasses of existing classes, handling exceptions that occur when the program is running, graphical user interfaces (GUIs), data stored in files, abstract data types, a glimpse at topics from other CS courses. Intended primarily for students majoring in computer sciences. ", "test");
	insertCourses("CS252", " Low-level programming; review of addresses, pointers, memory layout, and data representation; text, data, and bss segments; debugging and hex dumps; concurrent execution with threads and processes; address spaces;file names; descriptors and file pointers; inheritance; system calls and libraryfunctions; standard I/O and string libraries; simplified socket programming; building tools to help programmers; make and make files; shell scripts and quoting; unix tools including sed, echo, test, and find; scripting languagessuch as awk; version control; object and executable files (.o and a.out);symbol tables; pointers to functions; hierarchical directories; and DNS hierarchy; programming embedded systems. ", "test");
	insertCourses("CS307", "(a) Introduce fundamental principles, techniques, and tools used in the design of modern industrial-strength software systems, (b) provide an opportunity to work in small teams, and (c) assist in sharpening of documentation and presentation skills. ", "test");
	insertCourses("CS354", "Should not be taken concurrently with CS 35200. Introduction to operating systems. Computer system and operating system architectures, processes, inter-process communication, inter-process synchronization, mutual exclusion, deadlocks, memory hierarchy, virtual memory, CPU scheduling, file systems, I/O device management, security.", "test");
	insertCourses("CS381", "The course gives a broad introduction to the designand analysis of algorithms.  The course strives to strengthen a student’s ability to solve problems computationally by effectively utilizing anunderstanding of algorithm design techniques, algorithms analysis, and datastructures. Topics to be covered include: growth of functions; asymptotic analysis;  recurrences; sorting and order statistics; common algorithm designtechniques including divide-and-conquer, dynamic programming, and greedy;streaming and on-line algorithms; design of advanced data structures; graphalgorithms; parallel algorithms; lower bound techniques and problem reductions; NP-completeness, approximation algorithms.", "test");
	insertCourses("CS448", " An in-depth examination of relational database systemsincluding theory and concepts as well as practical issues in relational databases. Modern database technologies such as object-relational and Web-based access to relational databases. Conceptual design and entity relationship modeling, relationalalgebra and calculus, data definition and manipulation languages using SQL, schemaand view management, query processing and optimization, transaction management, security, privacy, integrity management.", "test");
}





