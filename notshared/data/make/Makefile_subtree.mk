include Makefile_dirs.mk

ifeq ($(BASE_ARCH),$(EC_ARCH))
$(error FATAL ERROR, EC_ARCH is not fully defined)
endif

ifeq (,$(EC_ARCH))
$(error FATAL ERROR, EC_ARCH is not defined)
endif

TEMP=$(subst /$(SOURCE_DIR), ,$(CURDIR))
TOP=$(firstword $(TEMP))
TRELPATH=$(word 2,$(TEMP))

ifeq ($(TOP),$(TRELPATH))
TRELPATH=
endif

TEMP2=.$(TRELPATH)
RELPATH=$(subst ./,,$(TEMP2))

TOPMAKE=$(MAKE) --no-print-directory -C $(TOP)

.SUFFIXES :
#=============================================================
ifeq (,$(PASS2))

.DEFAULT:
	+@$(MAKE) --no-print-directory PASS2=PASS2 $(RELPATH)/$@

all: local_targets.mk local subdirs

locallib: local_targets.mk local lib

alllibs:
	$(TOPMAKE) alllibs

malib:
	$(TOPMAKE) malib

libs:
	@FLAG_FILE=$(TOP)/.$$$$. ; \
        gnu_find . -mindepth 1 -type d \
             \( ! -exec $(MAKE) --no-print-directory -C {} locallib \; \) \
             -exec touch $$FLAG_FILE \; -quit ; \
             if [[ -f $$FLAG_FILE ]] ; then rm $$FLAG_FILE ; exit 1 ; fi

subdirs:
	@FLAG_FILE=$(TOP)/.$$$$. ; \
        gnu_find . -mindepth 1 -type d \
             \( ! -exec $(MAKE) --no-print-directory -C {} local \; \) \
             -exec touch $$FLAG_FILE \; -quit ; \
             if [[ -f $$FLAG_FILE ]] ; then rm $$FLAG_FILE ; exit 1 ; fi

include local_targets.mk
include local_user_rules.mk

local_user_rules.mk:
	touch local_user_rules.mk

local_targets.mk: .
	@echo making local_targets.mk in $(CURDIR)
	@printf "local : \\\\\n" >local_targets.mk
	@for i in *.c *.f *.f90 *.F *.F90 *.ftn *.ftn90 *.cdk90 *.C *.cc *.ptn90 *.tmpl90 *.for *.FOR ; \
        do [[ -r $$i ]] && echo $${i%.*}.o ; \
        done | xargs -l3 printf "\t%-15s %-15s %-15s\\\\\n" >>local_targets.mk
	@printf "\n" >>local_targets.mk

clean: clean_libs clean_obj clean_modules

clean_libs:
	rm -f $(TOP)/$(BUILD_DIR)/$(EC_ARCH)/*.a

clean_obj:
	rm -f $(TOP)/$(BUILD_DIR)/$(EC_ARCH)/$(RELPATH)/*.o
	rm -f $(TOP)/$(BUILD_DIR)/$(EC_ARCH)/$(RELPATH)/*.f
	rm -f $(TOP)/$(BUILD_DIR)/$(EC_ARCH)/$(RELPATH)/*.f90
	rm -f $(TOP)/$(BUILD_DIR)/$(EC_ARCH)/$(RELPATH)/*.ftn90

clean_modules:
	rm -f $(TOP)/$(BUILD_DIR)/$(EC_ARCH)/*.mod

#=============================================================
else

.SUFFIXES:

MAKETARGET = $(TOPMAKE) RELPATH=$(RELPATH) -f Makefile $(MAKECMDGOALS) 

.PHONY: $(TOP) 
$(TOP):
	+@$(MAKETARGET)

Makefile : ;
%.mk :: ;

% :: $(TOP) ; :

.PHONY: clean

$(RELPATH)/malib:
	@$(TOPMAKE) malib

$(RELPATH)/lib:
	@$(TOPMAKE) RELPATH=$(RELPATH) lib

$(RELPATH)/libs:
	@$(TOPMAKE) libs

#=============================================================
endif
