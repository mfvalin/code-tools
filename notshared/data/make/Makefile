#===================================================================
ifeq (,$(filter %/$(EC_ARCH),$(CURDIR)))

include Makefile_dirs.mk

ifeq ($(BASE_ARCH),$(EC_ARCH))
   $(error FATAL ERROR, EC_ARCH is not fully defined)
endif

ifeq (,$(EC_ARCH))
   $(error FATAL ERROR, EC_ARCH is not defined)
endif

.SUFFIXES:

OBJDIR := $(CURDIR)/$(BUILD_DIR)/$(EC_ARCH)
#ARCHDIR := $(CURDIR)/$(BUILD_DIR)/$(BASE_ARCH)

ifeq (,$(MAKECMDGOALS))
   MAKETARGET = $(MAKE) --no-print-directory all
else
   MAKETARGET = $(MAKE) --no-print-directory -C $(OBJDIR) -f $(CURDIR)/Makefile \
	RELPATH=$(RELPATH) VPATH=$(CURDIR)/$(SOURCE_DIR) $(MAKECMDGOALS) $(EXTRAS)
endif

.PHONY: $(OBJDIR) 
$(OBJDIR):
	+@[ -d $(OBJDIR) ] && mkdir -p $@/$(RELPATH)
	+@$(MAKETARGET)

Makefile : ;
%.mk :: ;

% :: $(OBJDIR) ; :

.PHONY: clean sanitize malib libs alllibs lib makefiles all tags dependencies

endif
#===================================================================

ifeq (,$(VPATH))
   VPATH=$(CURDIR)/$(SOURCE_DIR)
endif

include $(VPATH)/../Makefile_dirs.mk
include $(VPATH)/../otomatic.mk
include $(VPATH)/../rules.mk

all: makefiles objects tags
	echo ALL done

malib: all
	@(cd $(VPATH)/../$(BUILD_DIR)/$(EC_ARCH) ; \
        gnu_find . -name '*.o' \
      | xargs -l20 ar rv $(VPATH)/../$(BUILD_DIR)/$(EC_ARCH)/libmalib.a \
        )

objects:
	FLAG_FILE=$(VPATH)/../.$$$$. ; \
        gnu_find $(VPATH) -type d \
             \( ! -exec $(MAKE) --no-print-directory -C {} local \; \) \
             -exec touch $$FLAG_FILE \; -quit ; \
        if [[ -f $$FLAG_FILE ]] ; then rm $$FLAG_FILE ; exit 1 ; fi

libs:
	gnu_find $(VPATH) -type d \
             \( ! -exec $(MAKE) --no-print-directory -C {} locallib \; \) \
             -exec touch $$FLAG_FILE \; -quit ; \
        if [[ -f $$FLAG_FILE ]] ; then rm $$FLAG_FILE ; exit 1 ; fi

alllibs: libs
#	@gnu_find $(VPATH) -type d \
# #             \( ! -exec $(MAKE) --no-print-directory -C {} locallib \; \) \
#             -quit

lib:
	@(cd $(VPATH)/$(RELPATH) ; \
        TOP=$(CURDIR) ; \
        CUR=`pwd` ; \
        LIB_NAME=malib ;\
        while [[ $$TOP != $$CUR ]] ; \
        do \
          [[ -r $$CUR/.LIBNAME ]] \
          && LIB_NAME=`cat $$CUR/.LIBNAME` && break ; \
          CUR=$${CUR%/*} ; \
        done ;\
        cd $(VPATH)/../$(BUILD_DIR)/$(EC_ARCH)/$(RELPATH) ;\
        ls *.o 2>/dev/null \
        && echo ar rv $(VPATH)/../$(BUILD_DIR)/$(EC_ARCH)/lib$${LIB_NAME}.a *.o \
        && ar rv $(VPATH)/../$(BUILD_DIR)/$(EC_ARCH)/lib$${LIB_NAME}.a *.o ;\
        true )

sanitize: makefiles clean
	gnu_find $(VPATH) -type d \
                -exec rm -f {}/Makefile {}/Makefile_dirs.mk {}/local_targets.mk \;
	rm -f $(VPATH)/tags $(VPATH)/TAGS

clean:
	gnu_find $(VPATH) -type d -exec $(MAKE) --no-print-directory -C {} clean \;

$(VPATH)/../$(BUILD_DIR)/$(EC_ARCH)/.directory_marker:
	@touch $(VPATH)/../$(BUILD_DIR)/$(EC_ARCH)/.directory_marker

$(VPATH)/.directory_marker:
	@touch $(VPATH)/.directory_marker

$(VPATH)/../global_user_rules.mk:
	touch $(VPATH)/../global_user_rules.mk

dependencies:
	@(cd $(VPATH) ; gnu_find . -type f | s.dependencies.pl > ../otomatic.mk ) 

makefiles: dependencies $(VPATH)/.directory_marker $(VPATH)/../$(BUILD_DIR)/$(EC_ARCH)/.directory_marker
	@touch otomatic.mk
	@rm  $(VPATH)/.directory_marker
	@rm  $(VPATH)/../$(BUILD_DIR)/$(EC_ARCH)/.directory_marker
	@gnu_find $(VPATH)  -type d  \
            -exec rm -f {}/Makefile \; \
            -exec ln -s ../Makefile {}/Makefile \;
	@gnu_find $(VPATH)  -type d  \
            -exec rm -f {}/Makefile_dirs.mk \; \
            -exec ln -s ../Makefile_dirs.mk {}/Makefile_dirs.mk \;
	@rm  $(VPATH)/Makefile
	@ln -s ../Makefile_subtree.mk $(VPATH)/Makefile
	@(cd $(VPATH) ; gnu_find . -type d \
            -exec mkdir -p ../$(BUILD_DIR)/$(EC_ARCH)/{} \; )
	@gnu_find $(VPATH) -type d \
            -exec $(MAKE) --no-print-directory -C {} local_targets.mk \;

tags:
	( [[ `uname -s` != Linux ]] && exit 0 ; cd $(VPATH) ; rm -f tags TAGS ;\
	gnu_find . -type f -name '*.ftn*' \
             -exec etags --language=fortran --defines --append {} \; \
             -exec ctags --language=fortran --defines --append {} \; ;\
	gnu_find . -type f -name '*.cdk*' \
             -exec etags --language=fortran --defines --append {} \; \
             -exec ctags --language=fortran --defines --append {} \; ;\
	gnu_find . -type f -name '*.hf' \
             -exec etags --language=fortran --defines --append {} \; \
             -exec ctags --language=fortran --defines --append {} \; ;\
	gnu_find . -type f -name '*.inc*' \
             -exec etags --language=fortran --defines --append {} \; \
             -exec ctags --language=fortran --defines --append {} \; ;\
	gnu_find . -type f -name '*.h' \
             -exec etags  --defines --append {} \; \
             -exec ctags  --defines --append {} \; ;\
	gnu_find . -type f -name '*.c' \
             -exec etags  --defines --append {} \; \
             -exec ctags  --defines --append {} \;)

global_user_rules.mk:
	touch global_user_rules.mk

include $(VPATH)/../global_user_rules.mk
