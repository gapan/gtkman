#!/bin/sh

install -d -m 755 $DESTDIR/usr/bin
install -d -m 755 $DESTDIR/usr/share/applications
install -d -m 755 $DESTDIR/usr/share/gtkman
install -d -m 755 $DESTDIR/usr/man/man1
install -m 755 src/gtkman $DESTDIR/usr/bin/
install -m 644 src/gtkman.glade $DESTDIR/usr/share/gtkman/
install -m 644 gtkman.desktop $DESTDIR/usr/share/applications/
install -m 644 man/gtkman.man $DESTDIR/usr/man/man1/gtkman.1

for i in `ls po/*.po|sed "s/po\/\(.*\)\.po/\1/"`; do
	install -d -m 755 $DESTDIR/usr/share/locale/$i/LC_MESSAGES
	install -m 644 po/$i.mo $DESTDIR/usr/share/locale/$i/LC_MESSAGES/gtkman.mo
done
