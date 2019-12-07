include ../os.mk

ARTIFACTNAME = Example
PLATFORM = ARMv7M
CONFIGURATION = release

OBJOUT = $(PLATFORM)/$(CONFIGURATION)/
BINOUT = $(OBJOUT)

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
-L$(BINOUT)

LIBS = \
-lFibonacci

CROSS_BIN_PATH = $(ROOT)../tools/gcc-arm-none-eabi-8-2018-q4/
CXX = $(CROSS_BIN_PATH)bin/arm-none-eabi-g++
CC = $(CROSS_BIN_PATH)bin/arm-none-eabi-gcc
LN = $(CROSS_BIN_PATH)bin/arm-none-eabi-gcc
AR = $(CROSS_BIN_PATH)bin/arm-none-eabi-ar

CXXFLAGS = -pipe -x c++ -std=c++11 -fno-exceptions -fno-rtti -mcpu=cortex-m3 -mthumb -c -fsingle-precision-constant -ffunction-sections -fdata-sections            -Wno-format -Wno-unused-variable -Wno-unused-but-set-variable
CCFLAGS  = -pipe -x c              -fno-exceptions           -mcpu=cortex-m3 -mthumb -c -fsingle-precision-constant -ffunction-sections -fdata-sections -Wimplicit -Wno-format -Wno-unused-variable -Wno-unused-but-set-variable
LNFLAGS = -nostartfiles -nodefaultlibs -nostdlib
ARFLAGS = -r

ifneq ($(filter debug Debug,$(CONFIGURATION)),)
CXXFLAGS += -g3 -O0
DEFINES += -D_DEBUG
else
CXXFLAGS += -O3
endif

include ../cpp.mk
