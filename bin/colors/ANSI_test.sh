#!/bin/bash
#
# Copyright (C) 2011 by Yu-Jie Lin
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


fmt="%3d \e[%dmSGR \e[31mSGR \e[44mSGR\e[49m \e[39m\e[44mSGR\e[0m"
echo
echo "SGR ($fmt)"
echo
for i in {1..25} ; do
	a=()
	for j in {0..75..25}; do
		a=("${a[@]}" "$((i+j))" "$((i+j))")
	done
	printf "$fmt $fmt $fmt $fmt\n" "${a[@]}"
done
echo
for i in {100..110..4} ; do
	a=()
	for j in {0..3}; do
		a=("${a[@]}" "$((i+j))" "$((i+j))")
	done
	printf "$fmt $fmt $fmt $fmt\n" "${a[@]}"
done

fmt="\e[48;5;%dm   \e[0m"
echo
echo "256 Colors ($fmt)"
echo
for i in {0..7} ; do printf "%3d " "$i" ; done
for i in {232..243} ; do printf "%3d " "$i" ; done ; echo
for i in {0..7} ; do printf "$fmt " "$i" ; done
for i in {232..243} ; do printf "$fmt " "$i" ; done ; echo

for i in {8..15} ; do printf  "%3d " "$i" ; done ;
for i in {244..255} ; do printf "%3d " "$i" ; done ; echo
for i in {8..15} ; do printf "$fmt " "$i" ; done ;
for i in {244..255} ; do printf "$fmt " "$i" ; done ; echo
echo

fmt="%3d \e[38;5;0m\e[48;5;%dm___\e[0m"
for i in {16..51} ; do
	a=()
	for j in {0..196..36}; do
		a=("${a[@]}" "$((i+j))" "$((i+j))")
	done
	printf "$fmt $fmt $fmt $fmt $fmt $fmt\n" "${a[@]}"
done
