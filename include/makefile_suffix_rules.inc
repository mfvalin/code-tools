.c.o:
	r.compile -O $(OPTIMIZ) -defines "=$(DEFINE)" -optc "=$(CFLAGS)" $(SUPP_OPT) $(C_SUPP_OPT) -src $<

.c.a:
	r.compile -O $(OPTIMIZ) -defines "=$(DEFINE)" -optc "=$(CFLAGS)" $(SUPP_OPT) $(C_SUPP_OPT) -src $<
	ar rv $@ $*.o
	rm -f $*.o

.F.o:
	s.f90 -O $(OPTIMIZ) $(FFLAGS) $(SUPP_OPT) $(F_SUPP_OPT) -c $<

.f.o:
	r.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(F_SUPP_OPT) -src $<

.F.a:
	s.f90 -O $(OPTIMIZ) $(FFLAGS) $(SUPP_OPT) $(F_SUPP_OPT) -c $<
#	r.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(F_SUPP_OPT) -src $<
	ar rv $@ $*.o
	rm -f $*.o

.f.a:
	r.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(F_SUPP_OPT) -src $<
	ar rv $@ $*.o
	rm -f $*.o

.s.o:
	r.compile  $(OPTIMIZ) -opt "=$(FFLAGS)" -src $<

.s.a:
	r.compile  $(OPTIMIZ) -opt "=$(FFLAGS)" -src $<
	ar rv $@ $*.o
	rm -f $*.o

.ftn.f: 
	r.compile -O $(OPTIMIZ) -defines "=$(DEFINE)" -P -src $<

.ftn.o:
	r.compile -O $(OPTIMIZ) -defines "=$(DEFINE)" -optf "=$(FFLAGS)" $(SUPP_OPT) $(FTN_SUPP_OPT) -src $<

.ftn.a:
	r.compile -O $(OPTIMIZ) -defines "=$(DEFINE)" -optf "=$(FFLAGS)" $(SUPP_OPT) $(FTN_SUPP_OPT) -src $<
	ar rv $@ $*.o
	rm -f $*.o

.F90.o:
	s.f90 -O $(OPTIMIZ) $(FFLAGS) $(SUPP_OPT) $(F_SUPP_OPT) -c $<
#	r.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(F90_SUPP_OPT) -src $<

.F90.a:
	s.f90 -O $(OPTIMIZ) $(FFLAGS) $(SUPP_OPT) $(F90_SUPP_OPT) -c $<
#	r.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(F90_SUPP_OPT) -src $<
	ar rv $@ $*.o
	rm -f $*.o

.f90.o:
	r.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(F90_SUPP_OPT) -src $<

.f90.a:
	r.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(F90_SUPP_OPT) -src $<
	ar rv $@ $*.o
	rm -f $*.o

.ftn90.o:
	r.compile -O $(OPTIMIZ) -defines "=$(DEFINE)" -optf "=$(FFLAGS)" $(SUPP_OPT) $(FTN90_SUPP_OPT) -src $<

.ftn90.a:
	r.compile -O $(OPTIMIZ) -defines "=$(DEFINE)" -optf "=$(FFLAGS)" $(SUPP_OPT) $(FTN90_SUPP_OPT) -src $<
	ar rv $@ $*.o
	rm -f $*.o

.cdk90.o:
	r.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(FTN90_SUPP_OPT) -src $<

.cdk90.a:
	r.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(FTN90_SUPP_OPT) -src $<
	ar rv $@ $*.o
	rm -f $*.o
