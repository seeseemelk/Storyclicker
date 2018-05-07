WINDIR=release/win/

all: windows

windows:
	rm -R ${WINDIR} -f
	mkdir -p ${WINDIR}
	mkdir -p ${WINDIR}/lovers/
	mkdir -p ${WINDIR}/script_lua
	cp main.lua ${WINDIR}
	cp -R script_lua/*.* ${WINDIR}/script_lua/
	rsync lovers/*.* ${WINDIR}/lovers/ --exclude *.mp3
	cd ${WINDIR}; \
	love-release -t SUPERLOVERFUN -W .
