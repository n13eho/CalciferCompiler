# 0703
TARGET = ../bin/calcifer
# SOURCE = $(wildcard ./*.cpp)
# OBJECT = $(patsubst %.cpp, %.o, $(SOURCE))
OBJECT = main.o lex.yy.o sysy_node.o part.tab.o semanticAnalyze.o BuildIR.o

# $(TARGET): $(SOURCE)
# 	g++ -o $(TARGET) $(SOURCE)

# final target
$(TARGET): $(OBJECT)
	g++ -o $(TARGET) $(OBJECT)

# OBJ
main.o: main.cpp part.tab.hpp sysy_node.hpp semanticAnalyze.h ../include/Value.h ../include/BuildIR.h
	g++ -c main.cpp
lex.yy.o: lex.yy.cpp
	g++ -c lex.yy.cpp
sysy_node.o: sysy_node.cpp sysy_node.hpp
	g++ -c sysy_node.cpp
part.tab.o: part.tab.cpp
	g++ -c part.tab.cpp
semanticAnalyze.o: semanticAnalyze.cpp semanticAnalyze.h sysy_node.hpp
	g++ -c semanticAnalyze.cpp
BuildIR.o: BuildIR.cpp ../include/BuildIR.h semanticAnalyze.h
	g++ -c BuildIR.cpp



# origin
# TARGET = ../bin/calcifer
# manual  = $(wildcard ./*.cpp)
# objcpp = part.tab.cpp lex.yy.cpp $(manual)
# objdelete = part.tab.cpp lex.yy.cpp lex.yy.c

# $(TARGET): $(objcpp)
# 	g++ $(objcpp) -o $(TARGET)


# part.tab.cpp: part.ypp
# 	bison -d part.ypp

# lex.yy.cpp : lex.yy.c 
# 	mv ./lex.yy.c ./lex.yy.cpp

# lex.yy.c : scan_pro.l
# 	flex scan_pro.l


# 公共部分便捷测试
run:
	$(TARGET) ../test_set/test.c | tee ../doc/output.log

l1:
	../bin/scope_check.sh

clean:
	rm -rf $(OBJECT) $(TARGET)