CFLAGS=-I/opt/homebrew/opt/llvm/include -std=c++17 -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -gdwarf-4 -Wall -Wno-c++17-extensions
LDFLAGS=-L/opt/homebrew/opt/llvm/lib -lLLVM

all : lljit.exe

lljit.exe : JITD.h JITD.cpp main.cpp
	${CXX} ${CFLAGS} JITD.cpp main.cpp -o lljit.exe ${LDFLAGS}

clean :
	-rm lljit.exe cscope.out TAGS

tags :
	ctags -eR
	cscope -bR
