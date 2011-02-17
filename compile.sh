#!/bin/sh

cd po

for i in `ls *.po|sed "s/\.po//"`; do
	echo "Compiling $i..."
	msgfmt $i.po -o $i.mo
done

cd ..

intltool-merge po/ -d -u gtkman.desktop.in gtkman.desktop

cd man
txt2tags gtkman.t2t
cd ..

