######
#
# A simple Makefile
#
######
#
# HX-2018-01-05:
# PATSHOME is environmental
#
######

NPM=npm

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib

######

all:: ReadFromSTDIN3_dats

######

testall:: npm-install
testall:: all regress cleanall

######

%_dats: %.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -latslib

######

regress:: ReadFromSTDIN3_dats; echo 1000000 | ./$<

######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.o
clean:: ; rm -f *_?ats.c

cleanall:: clean
cleanall:: ; rm -f ReadFromSTDIN3_dats
cleanall:: ; rm -f ./node_modules -r
cleanall:: ; rm -f ./package-lock.json

######

npm-update:: ; $(NPM) update
npm-install:: ; $(NPM) install

######

export \
PATSHOMELOCS = \
./node_modules:./../node_modules:./../../node_modules:./../../../node_modules

###### end of [Makefile] ######
