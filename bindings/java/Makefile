include ../../helpers.mk

ifeq ($(CUR_OS),win32)
default:
	@echo TODO
test: default
clean: default
else
ifeq ($(CUR_OS),linux)
	JAVAINCLUDE=-I /usr/lib/jvm/java-8-openjdk-amd64/include -I /usr/lib/jvm/java-8-openjdk-amd64/include/linux
	LIBS=-lutil -ldl -Lrt -lpthread -lgcc_s -lc -lm
	TARGET=src/bc/libbattlecode-java-linux.so
endif
ifeq ($(CUR_OS),darwin)
	JAVAINCLUDE=-I /System/Library/Frameworks/JavaVM.framework/Versions/Current/Headers/
	LIBS=-lSystem -lresolv -lc -lm
	TARGET=src/bc/libbattlecode-java-darwin.so
endif

build:
	$(call build_command,cd src/bc && swig -java -package bc -outcurrentdir ../../../c/include/bc.i)
	$(call build_command,javac src/bc/*.java)
	$(call build_command,gcc -c -O3 -fPIC src/bc/bc_wrap.c $(JAVAINCLUDE) -I../c/include/ -o src/bc/bc_wrap.o)
	$(call build_command,gcc -shared -O3 -fPIC src/bc/bc_wrap.o ../../target/debug/deps/libbattlecode.a $(LIBS) -o $(TARGET))

test: build
	javac tests/*.java -classpath ./tests:./src
	java -classpath ./tests:./src Test

release:
	$(call build_command,cd src/bc && swig -java -package bc -outcurrentdir ../../../c/include/bc.i)
	$(call build_command,javac src/bc/*.java)
	$(call build_command,gcc -c -O3 -fPIC src/bc/bc_wrap.c $(JAVAINCLUDE) -I../c/include/ -o src/bc/bc_wrap.o)

clean:
	-rm -rf src/bc/*
	
.PHONY: build test clean
endif
