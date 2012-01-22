#!/bin/sh

cd po

for i in `ls *.po|sed "s/\.po//"`; do
	echo "Compiling $i..."
	msgfmt $i.po -o $i.mo
done

cd ..

intltool-merge po/ -d -u gtkman.desktop.in gtkman.desktop

if [ -x $( which txt2tags ) ]; then
	cd man
	txt2tags gtkman.t2t
	cd ..
else
	echo "WARNING: txt2tags is not installed. The gtkman manpage will not be created."
fi

