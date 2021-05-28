EXENAME = calcifer
srcscan = scan_pro.l 
srcpart = par.ypp
manual  = $(wildcard ./*.cpp)
objcpp = part.tab.cpp lex.yy.cpp $(manual)
objdelete = part.tab.cpp lex.yy.cpp lex.yy.c 
objo = $(patsubst %.cpp, %.o, $(objcpp))

$(EXENAME): $(objcpp)
	g++ $(objcpp) -o $(EXENAME)

$(objo) : $(objcpp)
	g++ $< -c -o  $@

clean:
	rm -rf $(objdelete) $(objo) $(EXENAME)

part.tab.cpp: part.ypp
	bison -d part.ypp

lex.yy.cpp : lex.yy.c 
	mv ./lex.yy.c ./lex.yy.cpp

lex.yy.c : scan_pro.l
	flex scan_pro.l 

