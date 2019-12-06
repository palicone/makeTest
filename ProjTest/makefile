ARTIFACTNAME = Example
CONFIGURATION = release
PLATFORM = ARMv7M

ROOT = ../
PROJECT_LOC = $(ROOT)ProjTest/
PARENT-1-PROJECT_LOC = $(PROJECT_LOC)../

DEFINES = \
-D_DEBUG \

INCLUDES = \
-I$(PROJECT_LOC) \

# must have at least one slash to later filter/search files
SOURCES = \
./startup.cpp \
./main.cpp \

LIB_INCLUDES = \

LIBS = \
-lFibonacci

CROSS_BIN_PATH = $(ROOT)../tools/gcc-arm-none-eabi-8-2019-q3/
CXX = $(CROSS_BIN_PATH)bin/arm-none-eabi-g++
CC = $(CROSS_BIN_PATH)bin/arm-none-eabi-gcc

CXXABS = $(abspath $(CXX))

CXXFLAGS = -pipe -x c++ -std=c++11 -fno-exceptions -fno-rtti -mcpu=cortex-m3 -mthumb -c -fsingle-precision-constant -ffunction-sections -fdata-sections            -Wno-format -Wno-unused-variable -Wno-unused-but-set-variable
CCFLAGS  = -pipe -x c              -fno-exceptions           -mcpu=cortex-m3 -mthumb -c -fsingle-precision-constant -ffunction-sections -fdata-sections -Wimplicit -Wno-format -Wno-unused-variable -Wno-unused-but-set-variable

OBJOUT = $(PLATFORM)/$(CONFIGURATION)/
BINOUT = $(OBJOUT)

ifneq ($(filter debug Debug,$(CONFIGURATION)),)
CXXFLAGS += -D_DEBUG -g3 -O0
else
CXXFLAGS += -O3
endif

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(wildcard $(OBJOUT)*.d),)
-include $(OBJOUT)*.d
endif
endif

COBJECTS := $(addprefix $(OBJOUT),$(addsuffix .o,$(basename $(notdir $(filter %.c, $(SOURCES))))))
CPPOBJECTS := $(addprefix $(OBJOUT),$(addsuffix .o,$(basename $(notdir $(filter %.cpp %.cc, $(SOURCES))))))

ARTIFACT := $(BINOUT)$(ARTIFACTNAME)

info:
	@cls
	@echo "MAKEFLAGS: $(MAKEFLAGS)"
	@echo "CONFIGURATION: $(CONFIGURATION)"
	@echo "PLATFORM: $(PLATFORM)"
	@echo "ROOT: $(ROOT)"
	@echo "OBJOUT: $(OBJOUT)"
	@echo "BINOUT: $(BINOUT)"
	@echo "CURDIR: $(CURDIR)"
	@echo " "

all: info $(ARTIFACT)
	@echo " "

$(ARTIFACT): $(COBJECTS) $(CPPOBJECTS)
	$(eval GENERATED_BINARY := $(BINOUT)$(ARTIFACT))
	@echo "Building target: $(GENERATED_BINARY)"
	@echo "Finished building target: $(GENERATED_BINARY)"
	@echo " "

$(COBJECTS):
	$(eval OBJ_NAME_NOEXT := $(basename $(notdir $@)))
	$(eval OBJ_OUT := $(OBJOUT)$(OBJ_NAME_NOEXT).o)
	$(eval OBJ_DEP := $(OBJOUT)$(OBJ_NAME_NOEXT).d)
	$(eval FILTERS := %/$(OBJ_NAME_NOEXT).c)
	$(eval SRC := $(filter $(FILTERS),$(SOURCES)))
	@echo "C compile: $(SRC)"
	$(CC) $(CCFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -MF"$(OBJ_DEP)" -MT"$(OBJ_OUT)" -o "$(OBJ_OUT)" "$(SRC)"
	@echo "Compiled to: $@"
	@echo " "

$(CPPOBJECTS):
	$(eval OBJ_NAME_NOEXT := $(basename $(notdir $@)))
	$(eval OBJ_OUT := $(OBJOUT)$(OBJ_NAME_NOEXT).o)
	$(eval OBJ_DEP := $(OBJOUT)$(OBJ_NAME_NOEXT).d)
	$(eval FILTERS := %/$(OBJ_NAME_NOEXT).cpp %/$(OBJ_NAME_NOEXT).cc)
	$(eval SRC := $(filter $(FILTERS),$(SOURCES)))
	@echo "C++ compile: $(SRC)"
	$(CXXABS) $(CXXFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -MF"$(OBJ_DEP)" -MT"$(OBJ_OUT)" -o "$(OBJ_OUT)" "$(SRC)"
	@echo "Compiled to: $@"
	@echo " "


clean:
	$(RM) $(OBJOUT)*

.PHONY: all clean
