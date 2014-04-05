SOURCES=main.lua conf.lua PT\ Sans\ Caption.ttf

all: lovalova.love windows mac

windows: lovalova.love
	cd windows && $(MAKE)

mac: lovalova.love
	cd mac && $(MAKE)

lovalova.love: $(SOURCES)
	zip -r lovalova.love $(SOURCES)

clean:
	rm -rf lovalova.love
	cd windows && $(MAKE) clean
	cd mac && $(MAKE) clean

.PHONY: windows mac clean
