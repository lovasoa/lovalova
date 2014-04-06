SOURCES=main.lua conf.lua PT\ Sans\ Caption.ttf icon.png

all: lovalova.love windows64 windows32 mac

windows64: lovalova.love
	cd windows64 && $(MAKE)

windows32: lovalova.love
	cd windows32 && $(MAKE)

mac: lovalova.love
	cd mac && $(MAKE)

lovalova.love: $(SOURCES)
	zip -r lovalova.love $(SOURCES)

clean:
	rm -rf lovalova.love
	cd windows64 && $(MAKE) clean
	cd windows32 && $(MAKE) clean
	cd mac && $(MAKE) clean

.PHONY: windows64 windows32 mac clean
