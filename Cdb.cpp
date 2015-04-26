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

int insertCourses(char* coursename, char* description, char* tags, char* pretest) {
	char insertBuffer[2048];
	//char tags[50] = "0000;0000;0000;0000;0000;0000;0000;0000;0000;0000";
	sprintf(insertBuffer, SQL_INSERT_COURSE, coursename, description, tags, pretest);
	rc = sqlite3_exec(coursedb, insertBuffer, NULL, 0, &zErrMsg);
	if( rc != SQLITE_OK ){
   		fprintf(stderr, "SQL error: %s\n", zErrMsg);
      	sqlite3_free(zErrMsg);
      	return -1;
   	}
   	return 0;
}

/*
tags:0.Easy;1.Hard;2.Group;3.Solo;4.Tedious;5.Funny;6.Useful;7.Lab;8.Busy;9.Serious
*/

int main(int argc, char **argv) {
	initDatabases();
    //CS110:Easy,Useful,Lab
    insertCourses("CS110", "Computer applications and how they can be used for solving problems in everyday life. The Internet with an emphasis on obtaining information from the World Wide Web, use of a database with an emphasis on data storage and retrieval, spreadsheets, word processing, presentation software, integration of multiple software packages. May not be taken for credit by Computer Science majors. Typically offered Summer Fall Spring.", "0001;0000;0000;0000;0000;0000;0001;0001;0000;0000", "test");
    //CS158:Easy,Funny,Lab
    insertCourses("CS158", "Introduction to structured programming in C. Data types and expression evaluation. Programmer-defined functions including passing parameters by value and by address. Selection topics include if/else/else-if, conditional expressions, and switch. Repetition topics include while, do-while, for, and recursion. External file input and output. Arrays, analysis of searching and sorting algorithms, and strings. Pointers and dynamic memory allocation. Students are expected to complete assignments in a collaborative environment. CS 15800 may be used to satisfy College of Science requirement of participation in at least one team-building and collaboration experience.", "0001;0000;0000;0000;0000;0001;0000;0001;0000;0000", "test");
    //CS159:Easy,Funny,Lab
    insertCourses("CS159", "Fundamental principles, concepts, and methods of programming (C and MATLAB), with emphasis on applications in the physical sciences and engineering. Basic problem solving and programming techniques; fundamental algorithms and data structures; and use of programming logic in solving engineering problems. Students are expected to complete assignments in a collaborative learning environment. ", "0001;0000;0000;0000;0000;0001;0000;0001;0000;0000", "test");

    //CS177:Easy,Useful,Lab
    insertCourses("CS177", "Introduction to computers and programming: number representations, primitive data types and operations, basic control structures, programming applets and applications using graphical user interfaces, programming for detecting events and performing actions, processing multimedia objects such as images and sounds. Throughout the course, examples are drawn from a variety of fields in the natural sciences.", "0001;0000;0000;0000;0000;0000;0001;0001;0000;0000", "test");
    
    //CS180:Easy,Useful,Lab
    insertCourses("CS180", "Problem solving and algorithms, implementation of algorithms in a high level programming language, conditionals, the iterative approach and debugging, collections of data, searching and sorting, solving problems by decomposition, the object-oriented approach, subclasses of existing classes, handling exceptions that occur when the program is running, graphical user interfaces (GUIs), data stored in files, abstract data types, a glimpse at topics from other CS courses. Intended primarily for students majoring in computer sciences.", "0001;0000;0000;0000;0000;0000;0001;0001;0000;0000", "test");
    //CS182:Solo,Useful,Serious
    insertCourses("CS182", "Logic and proofs; sets, functions, relations, sequences and summations; number representations; counting; fundamentals of the analysis of algorithms; graphs and trees; proof techniques; recursion; Boolean logic; finite state machines; pushdown automata; computability and undecidability.", "0000;0000;000;0001;0000;0000;0001;0000;0000;0001", "test");
    //CS183:Solo,Useful,Serious
    insertCourses("CS183", "Permission of instructor required.", "0000;0000;0000;0001;0000;0000;0001;0000;0000;0001", "test");
    //CS184:Solo,Useful,Serious
    insertCourses("CS184", "Permission of instructor required.", "0000;0000;0000;0001;0000;0000;0001;0000;0000;0001", "test");
    //CS190:Solo,Useful,Serious
    insertCourses("CS190", "Permission of instructor required.", "0000;0000;0000;0001;0000;0000;0001;0000;0000;0001", "test");
    //CS191:Solo,Useful,Serious
    insertCourses("CS191", "Permission of instructor required.", "0000;0000;0000;0001;0000;0000;0001;0000;0000;0001", "test");
    //CS240:Hard,Solo,Lab
    insertCourses("CS240", "The UNIX environment, C development cycle, data representation, operators, program structure, recursion, macros, C preprocessor, pointers and addresses, dynamic memory allocation, structures, unions, typedef, bit-fields, pointer/structure applications, UNIX file abstraction, file access, low-level I/O, concurrency.", "0000;0001;0000;0001;0000;0000;0000;0001;0000;0000", "test");
    //CS250:Hard,Lab,Busy
    insertCourses("CS250", "Digital logic: transistors, gates, and combinatorial circuits; clocks; registers and register banks; arithmetic-logic units; data representation: big-endian and little-endian integers; ones and twos complement arithmetic; signed and unsigned values; Von-Neumann architecture and bottleneck; instruction sets; RISC and CISC designs; instruction pipelines and stalls; rearranging code; memory and address spaces; physical and virtual memory; interleaving; page tables; memory caches; bus architecture; polling and interrupts; DMA; device programming; assembly language; optimizations; parallelism; data pipelining.", "0000;0001;0000;0000;0000;0000;0000;0001;0001;0000", "test");
    //CS251:Solo,Lab,Busy
    insertCourses("CS251", "Running time analysis of algorithms and their implementations, one-dimensional data structures, trees, heaps, additional sorting algorithms, binary search trees, hash tables, graphs, directed graphs, weighted graph algorithms, additional topics.", "0000;0000;0000;0001;0000;0000;0000;0001;0001;0000", "test");
    //CS252:Hard,Lab,Busy
	insertCourses("CS252", "Low-level programming; review of addresses, pointers, memory layout, and data representation; text, data, and bss segments; debugging and hex dumps; concurrent execution with threads and processes; address spaces;file names; descriptors and file pointers; inheritance; system calls and libraryfunctions; standard I/O and string libraries; simplified socket programming; building tools to help programmers; make and make files; shell scripts and quoting; unix tools including sed, echo, test, and find; scripting languagessuch as awk; version control; object and executable files (.o and a.out);symbol tables; pointers to functions; hierarchical directories; and DNS hierarchy; programming embedded systems. ", "0000;0001;0000;0000;0000;0000;0000;0001;0001;0000", "test");
    //CS284:Solo,Useful,Serious
    insertCourses("CS284", "Permission of instructor required.", "0000;0000;0000;0001;0000;0000;0001;0000;0000;0001", "test");
    //CS290:Solo,Useful,Serious
    insertCourses("CS290", "Permission of instructor required.", "0000;0000;0000;0001;0000;0000;0001;0000;0000;0001", "test");
    //CS291:Group,Funny,Useful
    insertCourses("CS291", "Presentations by corporate partners about careers in computer science. Presentations by faculty about careers in academia and research. Students learn about upper-division courses, tour research laboratories, and attend job fairs.", "0000;0000;0001;0000;0000;0001;0001;0000;0000;0000", "test");
    //CS307:Group,Funny,Useful
	insertCourses("CS307", "Iterative methods for solving nonlinear equations; direct and iterative methods for solving linear systems; approximations of functions, derivatives, and integrals; error analysis.\nProfessior Homepage:\nhttps://www.cs.purdue.edu/people/faculty/bxd/ ", "0000;0000;0001;0000;0000;0001;0001;0000;0000;0000", "test");
    //CS314:Solo,Useful,Serious
    insertCourses("CS314", "(a) Introduce fundamental principles, techniques, and tools used in the design of modern industrial-strength software systems, (b) provide an opportunity to work in small teams, and (c) assist in sharpening of documentation and presentation skills. ", "0000;0000;0000;0001;0000;0000;0001;0000;0000;0001", "test");
    //CS334:Solo,Useful,Serious
    insertCourses("CS334", "Fundamental principles and techniques of computer graphics. The course covers the basics of going from a scene representation to a raster image using OpenGL. Specific topics include coordinate manipulations, perspective, basics of illumination and shading, color models, texture maps, clipping and basic raster algorithms, fundamentals of scene constructions. C S 314 is recommended. ", "0000;0000;0000;0001;0000;0000;0001;0000;0000;0001", "test");
    //CS348:Solo,Lab,Busy
    insertCourses("CS348", "File organization and index structures; object-oriented database languages; the relational database model with introductions to SQL and DBMS; hierarchical models and network models with introductions to HDDL, HDML, and DBTG Codasyl; data mining; data warehousing; database connectivity; distributed databases; the client/server paradigm; middleware, including ODBC, JDBC, CORBA, and MOM. ", "0000;0000;0000;0001;0000;0000;0000;0001;0001;0000", "test");
    //CS352:Hard,Solo,Useful
    insertCourses("CS352", "Should not be taken concurrently with CS 354. The theory and practice of programming language translation, compilation, and run-time systems, organized around a significant programming project to build a compiler for a simple but nontrivial programming language. Modules, interfaces, tools. Data structures for tree languages. Lexical analysis, syntax analysis, abstract syntax. Symbol tables, semantic analysis. Translation, intermediate code, basic blocks, traces. Instruction selection, CISC and RISC machines. Liveness analysis, graph coloring register allocation. Supplemental material drawn from garbage collection, object-oriented languages, higher-order languages, dataflow analysis, optimization, polymorphism, scheduling and pipelining, memory hierarchies. ", "0000;0001;0000;0001;0000;0000;0001;0000;0000;0000", "test");
    //CS354:Hard,Solo,Useful
	insertCourses("CS354", "Should not be taken concurrently with CS 35200. Introduction to operating systems. Computer system and operating system architectures, processes, inter-process communication, inter-process synchronization, mutual exclusion, deadlocks, memory hierarchy, virtual memory, CPU scheduling, file systems, I/O device management, security.", "0000;0001;0000;0001;0000;0000;0001;0000;0000;0000", "test");
    //CS355:Hard,Solo,Useful
    insertCourses("CS355", "An introduction to cryptography basics: Classic historical ciphers including Caesar, Vigenere and Vernam ciphers; modern ciphers including DES, AES, Pohlig-Hellman, and RSA; signatures and digests; key exchange; simple protocols; block and stream ciphers; network-centric protocols.", "0000;0001;0000;0001;0000;0000;0001;0000;0000;0000", "test");
    //CS381:Hard,Solo,Userful
	insertCourses("CS381", "The course gives a broad introduction to the designand analysis of algorithms.  The course strives to strengthen a student’s ability to solve problems computationally by effectively utilizing anunderstanding of algorithm design techniques, algorithms analysis, and datastructures. Topics to be covered include: growth of functions; asymptotic analysis;  recurrences; sorting and order statistics; common algorithm designtechniques including divide-and-conquer, dynamic programming, and greedy;streaming and on-line algorithms; design of advanced data structures; graphalgorithms; parallel algorithms; lower bound techniques and problem reductions; NP-completeness, approximation algorithms.", "0000;0001;0000;0001;0000;0000;0001;0000;0000;0000", "test");
	//CS448:Hard,Lab,Serious
	insertCourses("CS448", " An in-depth examination of relational database systemsincluding theory and concepts as well as practical issues in relational databases. Modern database technologies such as object-relational and Web-based access to relational databases. Conceptual design and entity relationship modeling, relationalalgebra and calculus, data definition and manipulation languages using SQL, schemaand view management, query processing and optimization, transaction management, security, privacy, integrity management.", "0000;0001;0000;0000;0000;0000;0000;0001;0000;0001", "test");
}





