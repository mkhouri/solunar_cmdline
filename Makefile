.SUFFIXES: .o .c


all: solunar

VERSION=0.1.3a

CFLAGS=-Wall -DVERSION=\"$(VERSION)\" -g 

GCC=gcc

OBJS=main.o city.o pointerlist.o error.o latlong.o datetime.o suntimes.o roundutil.o trigutil.o timeutil.o moontimes.o mathutil.o holidays.o astrodays.o nameddays.o solunar.o

solunar: $(OBJS)
	$(GCC)  -s -o solunar $(OBJS) -lm

.c.o:
	$(GCC) $(CFLAGS) -o $*.o -c $*.c

clean:
	rm -f *.o solunar

cityinfo.h: /usr/share/zoneinfo/zone.tab parse_zoneinfo.pl
	./parse_zoneinfo.pl

install:
	cp -p solunar /usr/bin

web: clean
	(cd ..; tar cvfz /home/kevin/docs/kzone5/target/solunar-${VERSION}.tar.gz solunar-0.1)
	cp README_solunar.html /home/kevin/docs/kzone5/source/
	(cd /home/kevin/docs/kzone5; ./make.pl solunar)
		

include dependencies.mak

