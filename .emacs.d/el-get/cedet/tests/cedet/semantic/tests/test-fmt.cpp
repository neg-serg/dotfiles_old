/** test-fmt.cpp --- Signatures, and format answers for testing
 *
 * Copyright (C) 2012 Eric M. Ludlam
 *
 * Author: Eric M. Ludlam <eric@siege-engine.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2, or (at
 * your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

/*
 * About semantic-fmt-utest : 
 *
 * These tests validate two features:
 * 1) The C++ parser can parse the different signatures
 * 2) The semantic-tag-format-* functions can recreate them.
 *
 */

void basic_fcn() { }
/*
 * ## name "basic_fcn"
 * ## abbreviate "basic_fcn()"
 * ## prototype "void basic_fcn ()"
 * ## uml-prototype "basic_fcn () : void"
 */

int twoargs_fcn(int a, char b) { }
/*
 * ## name "twoargs_fcn"
 * ## abbreviate "twoargs_fcn()"
 * ## prototype "int twoargs_fcn (int a,char b)"
 * ## uml-prototype "twoargs_fcn (a : int,b : char) : int"
 */

struct moose {
  int field1;
  char field2;
};
/*
 * ## name "moose"
 * ## abbreviate "moose{}"
 * ## prototype "struct moose {}"
 * ## uml-prototype "moose{} : struct"
 */

struct moose strct_fcn ( struct moose in, char *out);
/*
 * ## name "strct_fcn"
 * ## abbreviate "strct_fcn()"
 * ## prototype "struct moose strct_fcn (struct moose in,char* out)"
 * ## uml-prototype "strct_fcn (in : struct moose,out : char*) : struct moose"
 */

struct moose *var_one = NULL;
/*
 * ## name "var_one"
 * ## summarize "Variables: struct moose* var_one[=NULL]"
 * ## prototype "struct moose* var_one[=NULL]"
 * ## uml-prototype "var_one : struct moose*"
 */

const int var_two = 1;
/*
 * ## name "var_two"
 * ## summarize "Variables: const int var_two[=1]"
 * ## prototype "const int var_two[=1]"
 * ## uml-prototype "var_two : int"
 */

//int const var_three = 1;
/*
 * # # name "var_three"
 * # # summarize "Variables: int const var_three"  <-- this fails
 * # # prototype "int const var_three"        <-- this fails
 * # # uml-prototype "var_three : int"
 */

