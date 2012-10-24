#!/bin/sh

install -D -m 755 src/gtkman $DESTDIR/usr/bin/gtkman
install -D -m 644 src/gtkman.glade $DESTDIR/usr/share/gtkman/gtkman.glade
install -D -m 644 gtkman.desktop $DESTDIR/usr/share/applications/gtkman.desktop

if [ -f man/gtkman.man ]; then
	install -D -m 644 man/gtkman.man $DESTDIR/usr/share/man/man1/gtkman.1
fi

for i in `ls po/*.po|sed "s/po\/\(.*\)\.po/\1/"`; do
	install -D -m 644 po/$i.mo $DESTDIR/usr/share/locale/$i/LC_MESSAGES/gtkman.mo
done
