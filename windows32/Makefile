lovalova.zip: lovalova.exe
	cp dlls.zip lovalova.zip
	zip -r lovalova.zip lovalova.exe

lovalova.exe: ../lovalova.love
	cat love.exe ../lovalova.love > lovalova.exe

../lovalova.love:
	cd .. && $(MAKE) lovalova.love

clean:
	rm -rf lovalova.exe lovalova.zip
