CC = g++
EXENAME = calcifer
OBJ = main.o scan.o parser.o

all:${OBJ}
	${CC} -o ${EXENAME} ${OBJ}

main.o: main.cpp scan.h global.h
	${CC} -c -g main.cpp

scan.o: scan.cpp scan.h global.h
	${CC} -c -g scan.cpp

parser.o: parser.cpp scan.h parser.h
	${CC} -c -g parser.cpp

clean:
	rm -rf ${EXENAME} ${OBJ}