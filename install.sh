#!/bin/sh

install -D -m 755 src/gtkman $DESTDIR/usr/bin/gtkman
install -D -m 644 src/gtkman.glade $DESTDIR/usr/share/gtkman/gtkman.glade
install -D -m 644 gtkman.desktop $DESTDIR/usr/share/applications/gtkman.desktop

# Install manpage
if [ -f man/gtkman.man ]; then
	install -D -m 644 man/gtkman.man $DESTDIR/usr/share/man/man1/gtkman.1
fi

# Install icons
install -d -m 755 $DESTDIR/usr/share/icons/hicolor/scalable/apps/
install -m 644 icons/gtkman.svg $DESTDIR/usr/share/icons/hicolor/scalable/apps/

for i in 32 24 22 16; do
	install -d -m 755 \
	$DESTDIR/usr/share/icons/hicolor/${i}x${i}/apps/ \
	2> /dev/null
	install -m 644 icons/gtkman-$i.png \
	$DESTDIR/usr/share/icons/hicolor/${i}x${i}/apps/gtkman.png
done

# Install translations
for i in `ls po/*.po|sed "s/po\/\(.*\)\.po/\1/"`; do
	install -D -m 644 po/$i.mo $DESTDIR/usr/share/locale/$i/LC_MESSAGES/gtkman.mo
done
