SOURCES=main.lua conf.lua PT\ Sans\ Caption.ttf

lovalova.love: $(SOURCES)
	zip -r lovalova.love $(SOURCES)
