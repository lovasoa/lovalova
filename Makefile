SOURCES=main.lua conf.lua PT\ Sans\ Caption.ttf

windows:
	cd windows && make

lovalova.love: $(SOURCES)
	zip -r lovalova.love $(SOURCES)

.PHONY: windows
