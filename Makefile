PREFIX = /usr/local

e2t: e2t.sh
	cp e2t.sh temp
	grep "\S" temp > e2t
	rm temp
	chmod +x e2t

test: e2t.sh
	shellcheck -s sh e2t.sh

clean:
	rm -f e2t

install: e2t
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f e2t $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/e2t

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/e2t
