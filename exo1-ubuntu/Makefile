SRCS=$(wildcard *.cpp)
OBJS=$(subst .cpp,.o,$(SRCS))
all : out

out: $(OBJS)
	g++ -o out $(OBJS) lib.a

exo1.o: exo1.h exo1.cpp 
	g++ -c exo1.cpp

clean:
	-rm -f $(OBJS) out
