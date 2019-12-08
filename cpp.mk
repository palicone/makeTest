ifneq ($(MAKECMDGOALS),clean)
ifneq ($(wildcard $(OBJOUT)*.d),)
-include $(OBJOUT)*.d
endif
endif

COBJECTS := $(addprefix $(OBJOUT),$(addsuffix .o,$(basename $(notdir $(filter %.c, $(SOURCES))))))
CPPOBJECTS := $(addprefix $(OBJOUT),$(addsuffix .o,$(basename $(notdir $(filter %.cpp %.cc, $(SOURCES))))))
ARTIFACT := $(BINOUT)$(ARTIFACTNAME)$(ARTIFACTEXT)

info:
	@echo "MAKEFLAGS: $(MAKEFLAGS)"
	@echo "CONFIGURATION: $(CONFIGURATION)"
	@echo "PLATFORM: $(PLATFORM)"
	@echo "ROOT: $(ROOT)"
	@echo "OBJOUT: $(OBJOUT)"
	@echo "BINOUT: $(BINOUT)"
	@echo "CURDIR: $(CURDIR)"
	@echo "ARTIFACT: $(ARTIFACT)"
	@echo "----"

all: info $(OBJOUT) $(BINOUT) $(ARTIFACT)
	@echo "----"

$(OBJOUT):
ifneq "$(wildcard $(OBJOUT) )" ""
	@echo "$@ already exists"
else
	$(MD) "$@"
endif

$(BINOUT):
ifneq "$(wildcard $(BINOUT) )" ""
	@echo "$@ already exists"
else
	$(MD) "$@"
endif

$(ARTIFACT): $(COBJECTS) $(CPPOBJECTS)
ifeq ($(suffix $(ARTIFACT)), .a)
	@echo "******* Started archiving *******"
	"$(AR)" $(ARFLAGS) "$@" $(COBJECTS) $(CPPOBJECTS)
	@echo "Finished archiving: $@"
else
	@echo "******* Started linking *******"
	"$(LN)" $(LNFLAGS) -o "$@" $(LIB_INCLUDES) $(COBJECTS) $(CPPOBJECTS) $(LIBS)
	@echo "Finished building target: $@"
endif
	@echo "----"

$(COBJECTS):
	$(eval OBJ_NAME_NOEXT := $(basename $(notdir $@)))
	$(eval OBJ_OUT := $(OBJOUT)$(OBJ_NAME_NOEXT).o)
	$(eval OBJ_DEP := $(OBJOUT)$(OBJ_NAME_NOEXT).d)
	$(eval FILTERS := %/$(OBJ_NAME_NOEXT).c)
	$(eval SRC := $(filter $(FILTERS),$(SOURCES)))
	@echo "C compile: $(SRC)"
	"$(CC)" $(CCFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -MF"$(OBJ_DEP)" -MT"$(OBJ_OUT)" -o "$(OBJ_OUT)" "$(SRC)"
	@echo "Compiled to: $@"
	@echo "----"

$(CPPOBJECTS):
	$(eval OBJ_NAME_NOEXT := $(basename $(notdir $@)))
	$(eval OBJ_OUT := $(OBJOUT)$(OBJ_NAME_NOEXT).o)
	$(eval OBJ_DEP := $(OBJOUT)$(OBJ_NAME_NOEXT).d)
	$(eval FILTERS := %/$(OBJ_NAME_NOEXT).cpp %/$(OBJ_NAME_NOEXT).cc)
	$(eval SRC := $(filter $(FILTERS),$(SOURCES)))
	@echo "C++ compile: $(SRC)"
	"$(CXX)" $(CXXFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -MF"$(OBJ_DEP)" -MT"$(OBJ_OUT)" -o "$(OBJ_OUT)" "$(SRC)"
	@echo "Compiled to: $@"
	@echo "----"


clean:
	cd "$(OBJOUT)" && $(RM) *

.PHONY: all clean
