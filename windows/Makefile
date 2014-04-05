lovalova.zip: lovalova.exe
	cp dlls.zip lovalova.zip
	zip -r lovalova.zip lovalova.exe

lovalova.exe:
	cd .. && $(MAKE) lovalova.love
	cat love.exe ../lovalova.love > lovalova.exe

clean:
	rm -rf lovalova.exe lovalova.zip
