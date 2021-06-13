TARGET = ../bin/calcifer
manual  = $(wildcard ./*.cpp)
objcpp = part.tab.cpp lex.yy.cpp $(manual)
objdelete = part.tab.cpp lex.yy.cpp lex.yy.c

scope_check_file = $(wildcard ../test_set/scope_check/*.c)

$(TARGET): $(objcpp)
	g++ $(objcpp) -o $(TARGET)


part.tab.cpp: part.ypp
	bison -d part.ypp

lex.yy.cpp : lex.yy.c 
	mv ./lex.yy.c ./lex.yy.cpp

lex.yy.c : scan_pro.l
	flex scan_pro.l

# 便捷测试
run:
	$(TARGET) ../test_set/test.sy

l1:
	../bin/scope_check.sh

clean:
	rm -rf $(objdelete) $(TARGET)
