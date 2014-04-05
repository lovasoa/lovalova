SOURCES=main.lua conf.lua PT\ Sans\ Caption.ttf

windows: lovalova.love
	cd windows && make

mac: lovalova.love
	cd mac && $(MAKE)

lovalova.love: $(SOURCES)
	zip -r lovalova.love $(SOURCES)

.PHONY: windows mac
