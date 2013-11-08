#!/bin/bash

for i in `ls dic`; do
  name=${i/.dsl/""}
  echo processing $name
  iconv -f utf16 -t utf8 dic/$i | sed -r s/\\[s\].+\.wav\\[\\/s\]// > dic/$i.utf8
  iconv -f utf8 -t utf16 dic/$i.utf8 > dic/$i
  rm -f dic/$i.utf8
  makedict -i dsl -o stardict dic/$i
  dictzip dic/stardict-$name-2.4.2/$name.dict
  gzip dic/stardict-$name-2.4.2/$name.idx
  rm -f dic/$i
done
