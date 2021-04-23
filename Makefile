CC = g++
EXENAME = calcifer
OBJ = main.o scan.o

all:${OBJ}
	${CC} -o ${EXENAME} ${OBJ}

main.o: main.cpp scan.h global.h
	${CC} -c -g main.cpp

scan.o: scan.cpp scan.h global.h
	${CC} -c -g scan.cpp
	

clean:
	rm -rf ${EXENAME} ${OBJ}