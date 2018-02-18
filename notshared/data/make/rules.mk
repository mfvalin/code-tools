
.SUFFIXES :

.SUFFIXES : .c .o .f90 .f .ftn .ftn90 .cdk90 .tmpl90 .F .FOR .F90 .for

# add directory containing source to include path

#VPATH_INCLUDES=-I$(VPATH)/../$(BUILD_DIR)/$(EC_ARCH) -I$(VPATH)/$(RELPATH) -I$(VPATH)
VPATH_INCLUDES=-I$(VPATH)/../$(BUILD_DIR)/$(EC_ARCH) -I$(VPATH)

%.o: %.c
	s.cc -c -o $@ -src $< $(VPATH_INCLUDES) $(COMPILE_FLAGS) $(CFLAGS) 

%.o : %.ftn
	s.ftn -c -o $@ -src $< $(VPATH_INCLUDES) $(COMPILE_FLAGS) $(FFLAGS)

%.o : %.f
	s.f77 -c -o $@ -src $< $(VPATH_INCLUDES) $(COMPILE_FLAGS) $(FFLAGS)

%.o : %.for
	s.f77 -c -o $@ -src $< $(VPATH_INCLUDES) $(COMPILE_FLAGS) $(FFLAGS)

%.o : %.F
	s.f77 -c -o $@ -src $< $(VPATH_INCLUDES) $(COMPILE_FLAGS) $(FFLAGS)

%.o : %.FOR
	s.f77 -c -o $@ -src $< $(VPATH_INCLUDES) $(COMPILE_FLAGS) $(FFLAGS)

%.o : %.ftn90
	s.ftn90 -c -o $@ -src $< $(VPATH_INCLUDES) $(COMPILE_FLAGS) $(FFLAGS)

%.o : %.cdk90
	s.ftn90 -c -o $@ -src $< $(VPATH_INCLUDES) $(COMPILE_FLAGS) $(FFLAGS)

%.o : %.f90
	s.f90 -c -o $@ -src $< $(VPATH_INCLUDES) $(COMPILE_FLAGS) $(FFLAGS)

%.o : %.F90
	s.f90 -c -o $@ -src $< $(VPATH_INCLUDES) $(COMPILE_FLAGS) $(FFLAGS)

%.ftn90 : %.tmpl90
	s.tmpl90.ftn90 < $<  > $@

#%_interface.cdk90 : %.tmpl90
#	FileName=$@ ; cat $< | r.tmpl90.ftn90 - $${FileName%.ftn90}
