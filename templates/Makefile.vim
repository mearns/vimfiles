##############################################################################
# Primary configuration
##############################################################################

#The name of the project. The name of the toplevel output file derive from
# this.
NAME=myproject

#Location to install to
DESTDIR=/usr/local/

#List of files to be excluded from the list of source file, which is the
# list of files for which object files will be compiled, which is auto
# generated below. 
SRC_EXCLUDE=

#Additioal files to include in the list of source files, that won't be
# picked up by the SRCS macro
SRC_ADD=

#List of directories to search for include files when compiling
CC_INCLUDE_DIRS=

#List of directories to search for libraries when linking
LD_LIB_DIRS=

#List of library files to include when linking
LD_LIBS=


#The compiler command
CC=gcc
#Flags for the C compiler. -I parameters are generated from
# CC_INCLUDE_DIRS, no need to duplicate them here.
CCFLAGS=

#The linker command
LD=gcc
#Flags to pass to the linked. -L and -l (library search dir and
# libraries to link) are auto generated from LD_LIB_DIRS and LD_LIBS,
# no need to duplicate them here. 
LDFLAGS=


#Command to print status
LOG=echo
LOGLN=echo


#Command to remove files
RM=rm
RMFLAGS=-f

#Command to touch files and directories
TOUCH=touch
TOUCHFLAGS=

#Command to print stuff
PRINT=echo
PRINTFLAGS=



##############################################################################
# Secondary configuration
##############################################################################

#Top level output file
OUTFILE=$(NAME)

#Auto generated list of sources. Will be filtered and added to.
AUTO_SRCS=$(wildcard *.c)

#The final list of sources
SRCS=$(sort $(filter-out $(SRC_EXCLUDE),$(AUTO_SRCS)) $(SRC_ADD)) 

#Object files that need to be created
OBJS=$(addsuffix .o,$(basename $(SRCS)))

#Compile a list of -i parameters for the compiler to specifiy directories to
# search for include files.
CC_INCLUDE_PATH=$(foreach idir,$(CC_INCLUDE_DIRS),-I$(idir))

#Compile a list of -L parameters for the linker to specify the search directories
# for libraries/
LD_LIB_DIRS_PATH=$(foreach ldir,$(LD_LIB_DIRS),-L$(ldir))

#Compile a list of -l parameters for the linker to specify the libraries to link
LD_LIB_LIST=$(foreach lib,$(LD_LIBS),-l$(lib))



.PHONY:top all
top all:$(OUTFILE)
	

##############################################################################
# Build stuff
##############################################################################

#Build object files from C sources with header files.
# if there is a corresponding header file, then make sure
# it's a dependency to we rebuild when it changes.
%.o: %.c %.h
	@$(LOG) [$*]
	@$(LOG) Compiling $@ from $*.c \(with header file $*.h\)
	@$(LOG) \(because of $?\)
	$(CC) -c -o$@ $(CC_INCLUDE_PATH) $(CCFLAGS) $*.c
	@$(LOGLN)


#Same rule, but if there's no header file. 
%.o: %.c
	@$(LOG) [$*]
	@$(LOG) Compiling $@ from $*.c \(no header file\)
	@$(LOG) \(because of $?\)
	$(CC) -c -o$@ $(CC_INCLUDE_PATH) $(CCFLAGS) $*.c
	@$(LOGLN)

$(OUTFILE): $(OBJS)
	@$(LOG) [$(OUTFILE)]
	@$(LOG) Building top level output file $@
	@$(LOG) \(because of $?\)
	$(LD) -o$@ $(OBJS) $(LD_LIB_DIRS_PATH) $(LD_LIB_LIST) $(LDFLAGS) 
	@$(LOGLN)


.PHONY:install
install: $(OUTFILE)
	@$(LOG) [Install]
	install $(OUTFILE) $(DESTDIR)/bin/
	@$(LOGLN)

##############################################################################
# Clean stuff
##############################################################################

#Remove the object files and the top level output file.
.PHONY:clean
clean: clean-objs clean-exe
	

#Remove all the object files
.PHONY:clean-objs
clean-objs:
	$(RM) $(RMFLAGS) $(OBJS)


#Remove the top level output file
.PHONY:tissue clean-exe
clean-exe tissue:
	$(RM) $(RMFLAGS) $(OUTFILE)



##############################################################################
# Touch stuff
##############################################################################

#Touch all the source files, making everything that depends on them out of date.
.PHONY:touch-src
touch-src:
	$(TOUCH) $(TOUCHFLAGS) $(SRCS)

#Touch all the object files, forcing them to be up to date, and making
# everything that depends on them out of date.
.PHONY:touch-objs
touch-objs:
	$(TOUCH) $(TOUCHFLAGS) $(OBJS)

#Touch the top level output file, forcing it to be up to date. 
.PHONY:touch-exe
touch-exe:
	$(TOUCH) $(TOUCHFLAGS) $(OUTFILE)


##############################################################################
# Print stuff
##############################################################################

print-name:
	$(PRINT) $(PRINTFLAGS) $(NAME)

print-src-exclude:
	$(PRINT) $(PRINTFLAGS) $(SRC_EXCLUDE)

print-src-add:
	$(PRINT) $(PRINTFLAGS) $(SRC_ADD)

print-auto-srcs print-src-auto:
	$(PRINT) $(PRINTFLAGS) $(AUTO_SRCS)

print-srcs:
	$(PRINT) $(PRINTFLAGS) $(SRCS)

print-lib-dirs:
	$(PRINT) $(PRINTFLAGS) $(LD_LIB_DIRS)

print-libs:
	$(PRINT) $(PRINTFLAGS) $(LD_LIBS)

print-cc:
	$(PRINT) $(PRINTFLAGS) $(CC)

print-ccflags:
	$(PRINT) $(PRINTFLAGS) $(CCFLAGS)

print-ld:
	$(PRINT) $(PRINTFLAGS) $(SRC_EXCLUDE)

print-ldflags:
	$(PRINT) $(PRINTFLAGS) $(LDFLAGS)

print-outfile:
	$(PRINT) $(PRINTFLAGS) $(OUTFILE)

print-objs:
	$(PRINT) $(PRINTFLAGS) $(OBJS)

print-cc-include-dirs print-include-path:
	$(PRINT) $(PRINTFLAGS) $(CC_INCLUDE_PATH)

print-lib-dirs-path print-lib-path:
	$(PRINT) $(PRINTFLAGS) $(LD_LIB_DIRS_PATH)

print-lib-list:
	$(PRINT) $(PRINTFLAGS) $(LD_LIB_LIS)






















