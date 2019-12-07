#Make sure that current dir is the one that is containing this makefile
#Invoke example: <pathToMake> -C <pathToThisMakefileDir> [other] [options]
PLATFORM = bin64
#bin<bits> native bits build
CONFIGURATION = release

all:
	@echo "****** Top level all make start ******"
	@echo "Using $(MAKE)"
	@echo "MAKEFLAGS: $(MAKEFLAGS)"	 
	@$(MAKE) -C LibFibonacci all PLATFORM=$(PLATFORM) CONFIGURATION=$(CONFIGURATION) BINOUT=../$(PLATFORM)/$(CONFIGURATION)/
	@$(MAKE) -C ProjTest     all PLATFORM=$(PLATFORM) CONFIGURATION=$(CONFIGURATION) BINOUT=../$(PLATFORM)/$(CONFIGURATION)/

clean:
	@$(MAKE) -C LibFibonacci clean PLATFORM=$(PLATFORM) CONFIGURATION=$(CONFIGURATION) BINOUT=../$(PLATFORM)/$(CONFIGURATION)/
	@$(MAKE) -C ProjTest     clean PLATFORM=$(PLATFORM) CONFIGURATION=$(CONFIGURATION) BINOUT=../$(PLATFORM)/$(CONFIGURATION)/

.PHONY: all clean
