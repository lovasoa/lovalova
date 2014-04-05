lovalova.zip: ../lovalova.love
	mkdir -p lovalova.app/Contents/Resources/
	cp ../lovalova.love lovalova.app/Contents/Resources/
	cp template.zip lovalova.zip
	zip -r lovalova.zip lovalova.app/Contents/Resources/lovalova.love

../lovalova.love:
	cd .. && $(MAKE) lovalova.love

clean:
	rm -rf lovalova.zip lovalova.app
