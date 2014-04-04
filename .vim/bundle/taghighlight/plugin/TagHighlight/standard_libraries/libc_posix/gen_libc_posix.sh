#!/bin/bash
# Script for generating libc standard library highlighter.  Written by Kévin Brodsky
# with (very minor) amendments by A. Budden
# Copyright (C) 2013 Kévin Brodsky
TAGS=libc_posix_tags
TYPES=libc_posix.taghl
HEADERS=c_posix_headers.txt
declare -A bits_headers

# Use GCC to find search path - this may only work on English language builds!
cat > TAGHL_GCC_TEST.c <<EOF
#include <time.h>
int main(void)
{
	return 0;
}
EOF
SEARCH_PATH=$(LANG=C gcc -o a.out -v TAGHL_GCC_TEST.c 2>&1 \
	| grep -A 10000 "^#include.*search starts here:" \
	| grep -B 10000 "^End of search list." \
	| grep "^ " \
	| sed 's/^ //')
rm a.out TAGHL_GCC_TEST.c
echo Search path set to:
echo ${SEARCH_PATH}

rm -f $TAGS
echo Generating $TAGS file
while read header
do
	echo Parsing $header
	if $(gcc -E $header > tmp.h)
	then
		ctags -f $TAGS --append=yes --excmd=number \
			--c-kinds=+px  --fields=+S --language-force=c --line-directives=yes tmp.h
		ctags -f $TAGS --append=yes --excmd=number --c-kinds=d \
			--language-force=c $header
		for h in $(gcc -M $header | grep -oE '\S*bits\S*')
		do 
			bits_headers[$h]=1
		done
	else
		echo Header not found, trying gcc headers
		for path in ${SEARCH_PATH}
		do
			echo "Trying ${path}"
			if [ -e ${path}/$(basename $header) ]
			then
				ctags -f $TAGS --append=yes --excmd=number --c-kinds=d --fields=+S \
					--language-force=c ${path}/`basename $header` \
					&& echo gcc header found
				break
			fi
		done
	fi
	rm tmp.h
done < $HEADERS

echo
echo "Parsing bits for additional macros (${#bits_headers[@]} headers)"
for h in ${!bits_headers[@]}
do
	echo Parsing $h
	ctags -f $TAGS --append=yes --excmd=number --c-kinds=d \
		--language-force=c $h
done

echo
echo Deleting _identifiers
vim -c 'g/^_/d' -c 'wq' $TAGS

echo Generating $TYPES
vim -c "let g:TagHighlightSettings['TypesFileNameForce']='$TYPES'" \
	-c "let g:TagHighlightSettings['Languages']=['c']" \
	-c "let g:TagHighlightSettings['IgnoreFileScope']='True'" \
	-c "let g:TagHighlightSettings['TagFileName']='$TAGS'" \
	-c "UpdateTypesFileOnly" \
	-c "q"

echo Done

# vim: fenc=utf-8
