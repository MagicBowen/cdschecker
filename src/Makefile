BASE := ..

include $(BASE)/common.mk

CPPFLAGS += -I$(BASE)/include/cds_checker -I.
LDFLAGS := -ldl -lrt -rdynamic
SHARED := -shared

# Mac OSX options
ifeq ($(UNAME), Darwin)
LDFLAGS := -ldl
SHARED := -Wl,-undefined,dynamic_lookup -dynamiclib
endif

OBJECTS := libthreads.o schedule.o model.o threads.o librace.o action.o \
	   nodestack.o clockvector.o main.o snapshot-interface.o cyclegraph.o \
	   datarace.o impatomic.o cmodelint.o \
	   snapshot.o malloc.o mymemory.o common.o mutex.o promise.o conditionvariable.o \
	   context.o scanalysis.o execution.o plugins.o

all: $(LIB_SO)

$(LIB_SO): $(OBJECTS)
	$(CXX) $(SHARED) -o $(LIB_SO) $+ $(LDFLAGS)

malloc.o: malloc.c
	$(CC) -fPIC -c malloc.c -DMSPACES -DONLY_MSPACES -DHAVE_MMAP=0 $(CPPFLAGS) -Wno-unused-variable

%.o: %.cc
	$(CXX) -MMD -MF .$@.d -fPIC -c $< $(CPPFLAGS)

-include $(OBJECTS:%=.%.d)

clean::
	rm -f *.o *.so .*.d