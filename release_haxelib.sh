#!/bin/sh
rm -f Mandolin.zip
zip -r Mandolin.zip src *.hxml *.json *.md run.n
haxelib submit Mandolin.zip $HAXELIB_PWD --always