BASE := ..

OBJECTS := $(patsubst %.c, %.o, $(wildcard *.c))
OBJECTS += $(patsubst %.cc, %.o, $(wildcard *.cc))

include $(BASE)/common.mk

DIR := litmus
include $(DIR)/Makefile

DEPS := $(join $(addsuffix ., $(dir $(OBJECTS))), $(addsuffix .d, $(notdir $(OBJECTS))))

CPPFLAGS += -I$(BASE)/src -I$(BASE)/include/cdschecker

all: $(OBJECTS)

-include $(DEPS)

%.o: %.c
	$(CC) -MMD -MF $(@D)/.$(@F).d -o $@ $< $(CPPFLAGS) -L$(BASE)/src -l$(LIB_NAME)

%.o: %.cc
	$(CXX) -MMD -MF $(@D)/.$(@F).d -o $@ $< $(CPPFLAGS) -L$(BASE)/src -l$(LIB_NAME)

clean::
	rm -f $(OBJECTS) $(DEPS)
