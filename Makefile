DESTDIR ?= /
PREFIX ?= /usr/local
PACKAGE_LOCALE_DIR ?= /usr/share/locale

.PHONY: all
all: man mo

.PHONY: man
man:
	@txt2tags -o man/gtkman.man man/gtkman.t2t || \
	echo "WARNING: txt2tags is not installed. The gtkman manpage will not be created."

.PHONY: mo
mo:
	for i in `ls po/*.po`; do \
		msgfmt $$i -o `echo $$i | sed "s/\.po//"`.mo; \
	done
	intltool-merge po/ -d -u gtkman.desktop.in gtkman.desktop

.PHONY: updatepo
updatepo:
	for i in `ls po/*.po`; do \
		msgmerge -UNs $$i po/gtkman.pot; \
	done

.PHONY: pot
pot:
	xgettext --from-code=utf-8 \
		-L Glade \
		-o po/gtkman.pot \
		src/gtkman.glade
	xgettext --from-code=utf-8 \
		-j \
		-L Python \
		-o po/gtkman.pot \
		src/gtkman
	intltool-extract --type="gettext/ini" gtkman.desktop.in
	xgettext --from-code=utf-8 -j -L C -kN_ -o po/gtkman.pot gtkman.desktop.in.h
	rm gtkman.desktop.in.h

.PHONY: clean
clean:
	rm -f gtkman.desktop
	rm -f po/*.mo
	rm -f po/*.po~
	rm -f man/gtkman.man

.PHONY: install
install:
	install -D -m 755 src/gtkman $(DESTDIR)/$(PREFIX)/bin/gtkman
	sed -i "s|^prefix = '_not_set_'|prefix = '$(PREFIX)'|" $(DESTDIR)/$(PREFIX)/bin/gtkman
	sed -i "s|^package_locale_dir = '_not_set_'|package_locale_dir = '$(PACKAGE_LOCALE_DIR)'|" $(DESTDIR)/$(PREFIX)/bin/gtkman
	install -D -m 644 src/gtkman.glade $(DESTDIR)/$(PREFIX)/share/gtkman/gtkman.glade
	install -D -m 644 gtkman.desktop $(DESTDIR)/$(PREFIX)/share/applications/gtkman.desktop
	[ -f man/gtkman.man ] && \
		install -D -m 644 man/gtkman.man $(DESTDIR)/$(PREFIX)/share/man/man1/gtkman.1
	install -d -m 755 $(DESTDIR)/$(PREFIX)/share/icons/hicolor/scalable/apps/
	install -m 644 icons/gtkman.svg $(DESTDIR)/$(PREFIX)/share/icons/hicolor/scalable/apps/
	for i in 32 24 22 16; do \
		install -d -m 755 \
		$(DESTDIR)/$(PREFIX)/share/icons/hicolor/$${i}x$${i}/apps/ \
		2> /dev/null; \
		install -m 644 icons/gtkman-$$i.png \
		$(DESTDIR)/$(PREFIX)/share/icons/hicolor/$${i}x$${i}/apps/gtkman.png; \
	done
	for i in `ls po/*.po|sed "s/po\/\(.*\)\.po/\1/"`; do \
		install -D -m 644 po/$$i.mo $(DESTDIR)/$(PACKAGE_LOCALE_DIR)/$$i/LC_MESSAGES/gtkman.mo; \
	done

.PHONY: transifex
transifex:
	tx pull -a

