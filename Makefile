CXX = g++ -fPIC
NETLIBS= -lnsl

all: Server

Server : Server.o database.o
	$(CXX) -o $@ $@.o database.cpp $(NETLIBS) -lpthread -l sqlite3

%.o: %.cpp
	@echo 'Building $@ from $<'
	$(CXX) -o $@ -c -I. $<

clean:
	rm -f *.o Server
