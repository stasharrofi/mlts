.PHONY: all lib demo release release-mac release-win release-linux

export PYTHON?=python3

all: lib demo


sync:
	$(MAKE) -C lib core

lib:
	$(MAKE) -C lib

demo: 
	pandoc -f markdown -t html README.md -o docs/readme.html
	cp lib/_build/default/main.bc.js docs/js/mlts.js
	#cp lib/_build/default/main.bc.runtime.js docs/js/mlts.runtime.js

run: all
	(cd docs && $(PYTHON) -m http.server)

release: release-all
	(cd app/release-builds/ && zip -qr mlts-darwin-x64.zip mlts-darwin-x64 \
			&& zip -qr mlts-linux-x64.zip mlts-linux-x64 \
			&& zip -qr mlts-win32-ia32.zip mlts-win32-ia32)

release-all: release-mac release-win release-linux

release-mac: lib
	(cd app && npm run package-mac )


release-win: lib
	(cd app && npm run package-win)


release-linux: lib
	(cd app && npm run package-linux)
