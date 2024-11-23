.PHONY: all clean

# see documentation in gal.hs to run it

BINS = hello str

all: $(BINS)

%: %.hs
	ghc -o $@ -outputdir /tmp $^

clean:
	/bin/rm $(BINS)
	/bin/rm *.hi
	/bin/rm *.o
