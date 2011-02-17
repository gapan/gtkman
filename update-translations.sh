#!/bin/sh

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

cd po
for i in `ls *.po`; do
	msgmerge -U $i gtkman.pot
done
rm -f ./*~

