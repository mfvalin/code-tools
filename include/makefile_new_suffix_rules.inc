.c.o:
	s.compile $(OPTIMIZ) -defines "=$(DEFINE)" -optc "=$(CFLAGS)" $(SUPP_OPT) $(C_SUPP_OPT) -src $<

.c.a:
	s.compile -O $(OPTIMIZ) -defines "=$(DEFINE)" -optc "=$(CFLAGS)" $(SUPP_OPT) $(C_SUPP_OPT) -src $<
	ar rv $@ $*.o
	rm -f $*.o

.f.o:
	s.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(F_SUPP_OPT) -src $<

.f.a:
	s.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(F_SUPP_OPT) -src $<
	ar rv $@ $*.o
	rm -f $*.o

.s.o:
	s.compile $(OPTIMIZ) -opt "=$(FFLAGS)" -src $<

.s.a:
	s.compile $(OPTIMIZ) -opt "=$(FFLAGS)" -src $<
	ar rv $@ $*.o
	rm -f $*.o

.ftn.f: 
	s.compile -O $(OPTIMIZ) -defines "=$(DEFINE)" -P -src $<

.ftn.o:
	s.compile -O $(OPTIMIZ) -defines "=$(DEFINE)" -optf "=$(FFLAGS)" $(SUPP_OPT) $(FTN_SUPP_OPT) -src $<

.ftn.a:
	s.compile -O $(OPTIMIZ) -defines "=$(DEFINE)" -optf "=$(FFLAGS)" $(SUPP_OPT) $(FTN_SUPP_OPT) -src $<
	ar rv $@ $*.o
	rm -f $*.o

.f90.o:
	s.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(F90_SUPP_OPT) -src $<

.f90.a:
	s.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(F90_SUPP_OPT) -src $<
	ar rv $@ $*.o
	rm -f $*.o

.ftn90.o:
	s.compile -O $(OPTIMIZ) -defines "=$(DEFINE)" -optf "=$(FFLAGS)" $(SUPP_OPT) $(FTN90_SUPP_OPT) -src $<

.ftn90.a:
	s.compile -O $(OPTIMIZ) -defines "=$(DEFINE)" -optf "=$(FFLAGS)" $(SUPP_OPT) $(FTN90_SUPP_OPT) -src $<
	ar rv $@ $*.o
	rm -f $*.o

.cdk90.o:
	s.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(FTN90_SUPP_OPT) -src $<

.cdk90.a:
	s.compile -O $(OPTIMIZ) -optf "=$(FFLAGS)" $(SUPP_OPT) $(FTN90_SUPP_OPT) -src $<
	ar rv $@ $*.o
	rm -f $*.o
