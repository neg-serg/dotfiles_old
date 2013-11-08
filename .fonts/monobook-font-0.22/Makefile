bdf2pcf := bdftopcf
perl := perl
bdf2psf := $(perl) ./bdftopsf.pl +u
bdf2raw := $(perl) ./bdftopsf.pl -h
ucs2vga := $(perl) ./ucstoany.pl +f
ucs2x11 := $(perl) ./ucstoany.pl
gzip := gzip -9

# magic lines {{{
r_88591	:= ISO8859 1
r_88592	:= ISO8859 2
r_88595	:= ISO8859 5
r_88597	:= ISO8859 7
r_88599	:= ISO8859 9
r_w1251	:= Microsoft CP1251
r_8859d	:= ISO8859 13
r_8859f	:= ISO8859 15
r_8859g	:= ISO8859 16
r_pcibm	:= Microsoft CP437
r_koi8r	:= KOI8 R
r_koi8u	:= KOI8 U
r_bgmik	:= Bulgarian MIK
r_pt154	:= Paratype PT154
r_pt254	:= Paratype PT254
r_xos42	:= XOS4 2
r_10646	:= ISO10646 1

d_88591	:= dup/vgagr.dup
d_88592	:= dup/vgagr.dup
d_88597	:= dup/vgagr.dup
d_88599	:= dup/vgagr.dup
d_w1251	:= dup/vgagr.dup
d_8859d	:= dup/vgagr.dup
d_8859g	:= dup/vgagr.dup
d_pcibm	:= dup/cntrl.dup dup/ibm-437.dup
d_koi8r	:= dup/cntrl.dup
d_koi8u	:= dup/cntrl.dup
d_bgmik	:= dup/cntrl.dup dup/ibm-437.dup
d_pt154	:= dup/vgagr.dup
d_xos42	:= dup/cntrl.dup dup/ibm-437.dup dup/xos4-2.dup

v_88591	:= uni/vgagr.uni uni/ascii-h.uni uni/win-1252.uni
v_88592	:= uni/vgagr.uni uni/ascii-h.uni uni/vga-1250.uni uni/8859-2.uni
v_88597	:= uni/vgagr.uni uni/ascii-h.uni uni/vga-1253.uni uni/8859-7.uni
v_88599	:= uni/vgagr.uni uni/ascii-h.uni uni/win-1254.uni
v_w1251	:= uni/vgagr.uni uni/ascii-h.uni uni/vga-1251.uni uni/win-1251.uni
v_8859d	:= uni/vgagr.uni uni/ascii-h.uni uni/vga-1257.uni uni/8859-13.uni
v_8859g	:= uni/vgagr.uni uni/ascii-h.uni uni/nls-1250.uni uni/8859-16.uni
v_pcibm	:= uni/cntrl.uni uni/ascii-h.uni uni/ibm-437.uni
v_koi8r	:= uni/cntrl.uni uni/ascii-h.uni uni/koibm8-r.uni
f_koi8r	:= uni/cntrl.uni uni/ascii-h.uni uni/koi8-r.uni
v_koi8u	:= uni/cntrl.uni uni/ascii-h.uni uni/koibm8-u.uni
f_koi8u	:= uni/cntrl.uni uni/ascii-h.uni uni/koi8-u.uni
v_bgmik	:= uni/cntrl.uni uni/ascii-h.uni uni/bg-mik.uni
v_pt154	:= uni/vgagr.uni uni/ascii-h.uni uni/pt-154.uni
v_xos42	:= uni/cntrl.uni uni/ascii-h.uni uni/xos4-2.uni

x_88591	:= uni/x11gr.uni uni/ascii-h.uni uni/win-1252.uni
x_88592	:= uni/x11gr.uni uni/ascii-h.uni uni/empty.uni uni/8859-2.uni
x_88595	:= uni/x11gr.uni uni/ascii-h.uni uni/empty.uni uni/8859-5.uni
x_88597	:= uni/x11gr.uni uni/ascii-h.uni uni/empty.uni uni/8859-7.uni
x_88599	:= uni/x11gr.uni uni/ascii-h.uni uni/win-1254.uni
x_w1251	:= uni/x11gr.uni uni/ascii-h.uni uni/x11-1251.uni uni/win-1251.uni
x_8859d	:= uni/x11gr.uni uni/ascii-h.uni uni/x11-1257.uni uni/8859-13.uni
x_8859f	:= uni/x11gr.uni uni/ascii-h.uni uni/empty.uni uni/8859-15.uni
x_8859g	:= uni/x11gr.uni uni/ascii-h.uni uni/empty.uni uni/8859-16.uni
x_koi8r	:= uni/x11gr.uni uni/ascii-h.uni uni/koi8-r.uni
x_koi8u	:= uni/x11gr.uni uni/ascii-h.uni uni/koi8-u.uni
x_pt154	:= uni/x11gr.uni uni/ascii-h.uni uni/pt-154.uni
x_10646	:= uni/x11gr.uni uni/10646-1.uni

b_88591	:= uni/cntrl.uni uni/ascii-h.uni uni/win-1252.uni
b_88592	:= uni/cntrl.uni uni/ascii-h.uni uni/empty.uni uni/8859-2.uni
b_88595	:= uni/cntrl.uni uni/ascii-h.uni uni/empty.uni uni/8859-5.uni
b_88597	:= uni/cntrl.uni uni/ascii-h.uni uni/empty.uni uni/8859-7.uni
b_88599	:= uni/cntrl.uni uni/ascii-h.uni uni/win-1254.uni
b_w1251	:= uni/cntrl.uni uni/ascii-h.uni uni/x11-1251.uni uni/win-1251.uni
b_8859d	:= uni/cntrl.uni uni/ascii-h.uni uni/x11-1257.uni uni/8859-13.uni
b_8859f	:= uni/cntrl.uni uni/ascii-h.uni uni/empty.uni uni/8859-15.uni
b_8859g	:= uni/cntrl.uni uni/ascii-h.uni uni/empty.uni uni/8859-16.uni
b_pcibm	:= uni/cntrl.uni uni/ascii-h.uni uni/ibm-437.uni
b_koi8r	:= uni/cntrl.uni uni/ascii-h.uni uni/koi8-r.uni
b_koi8u	:= uni/cntrl.uni uni/ascii-h.uni uni/koi8-u.uni
b_pt154	:= uni/cntrl.uni uni/ascii-h.uni uni/pt-154.uni
# }}}

bdffiles := $(wildcard *.bdf)
pcffiles_gz := $(bdffiles:.bdf=.pcf.gz)
psffiles_gz := $(bdffiles:.bdf=.psf.gz)
rawfiles := $(patsubst %.bdf, %.raw, $(wildcard *1[46]*.bdf))
pcfdir := pcf
psfdir := psf
rawdir := raw
VPATH := . $(pcfdir) $(psfdir)


%.pcf.gz: %.bdf
# By default it will build font in iso10646-1. If you want other,
# just comment out this line and uncomment any you want.
	$(ucs2x11) $< $(r_10646) $(x_10646) | $(bdf2pcf) | $(gzip) > $(pcfdir)/$@
#	$(ucs2x11) $< $(r_88591) $(x_88591) | $(bdf2pcf) | $(gzip) > $(pcfdir)/$@
#	$(ucs2x11) $< $(r_88592) $(x_88592) | $(bdf2pcf) | $(gzip) > $(pcfdir)/$@
#	$(ucs2x11) $< $(r_88595) $(x_88595) | $(bdf2pcf) | $(gzip) > $(pcfdir)/$@
#	$(ucs2x11) $< $(r_88597) $(x_88597) | $(bdf2pcf) | $(gzip) > $(pcfdir)/$@
#	$(ucs2x11) $< $(r_88599) $(x_88599) | $(bdf2pcf) | $(gzip) > $(pcfdir)/$@
#	$(ucs2x11) $< $(r_w1251) $(x_w1251) | $(bdf2pcf) | $(gzip) > $(pcfdir)/$@
#	$(ucs2x11) $< $(r_8859d) $(x_8859d) | $(bdf2pcf) | $(gzip) > $(pcfdir)/$@
#	$(ucs2x11) $< $(r_8859f) $(x_8859f) | $(bdf2pcf) | $(gzip) > $(pcfdir)/$@
#	$(ucs2x11) $< $(r_8859g) $(x_8859g) | $(bdf2pcf) | $(gzip) > $(pcfdir)/$@
#	$(ucs2x11) $< $(r_koi8r) $(x_koi8r) | $(bdf2pcf) | $(gzip) > $(pcfdir)/$@
#	$(ucs2x11) $< $(r_koi8u) $(x_koi8u) | $(bdf2pcf) | $(gzip) > $(pcfdir)/$@
#	$(ucs2x11) $< $(r_pt154) $(x_pt154) | $(bdf2pcf) | $(gzip) > $(pcfdir)/$@

%.psf.gz: %.bdf
# By default it will build font in koi8-r. If you want other,
# just comment out this line and uncomment any you want.
	$(ucs2vga) $< $(r_koi8r) $(f_koi8r) | $(bdf2psf) - $(d_koi8r) | $(gzip) > $(psfdir)/$@
#	$(ucs2vga) $< $(r_88591) $(v_88591) | $(bdf2psf) - $(d_88591) | $(gzip) > $(psfdir)/$@
#	$(ucs2vga) $< $(r_88592) $(v_88592) | $(bdf2psf) - $(d_88592) | $(gzip) > $(psfdir)/$@
#	$(ucs2vga) $< $(r_88597) $(v_88597) | $(bdf2psf) - $(d_88597) | $(gzip) > $(psfdir)/$@
#	$(ucs2vga) $< $(r_88599) $(v_88599) | $(bdf2psf) - $(d_88599) | $(gzip) > $(psfdir)/$@
#	$(ucs2vga) $< $(r_w1251) $(v_w1251) | $(bdf2psf) - $(d_w1251) | $(gzip) > $(psfdir)/$@
#	$(ucs2vga) $< $(r_8859d) $(v_8859d) | $(bdf2psf) - $(d_8859d) | $(gzip) > $(psfdir)/$@
#	$(ucs2vga) $< $(r_8859g) $(v_8859g) | $(bdf2psf) - $(d_8859g) | $(gzip) > $(psfdir)/$@
#	$(ucs2vga) $< $(r_pcibm) $(v_pcibm) | $(bdf2psf) - $(d_pcibm) | $(gzip) > $(psfdir)/$@
#	$(ucs2vga) $< $(r_bgmik) $(v_bgmik) | $(bdf2psf) - $(d_bgmik) | $(gzip) > $(psfdir)/$@
#	$(ucs2vga) $< $(r_pt154) $(v_pt154) | $(bdf2psf) - $(d_pt154) | $(gzip) > $(psfdir)/$@
#	$(ucs2vga) $< $(r_koi8u) $(f_koi8u) | $(bdf2psf) - $(d_koi8u) | $(gzip) > $(psfdir)/$@
#	$(ucs2vga) $< $(r_xos42) $(v_xos42) | $(bdf2psf) - $(d_xos42) | $(gzip) > $(psfdir)/$@
#	$(ucs2vga) $< $(r_8859g) $(v_8859g) | $(bdf2psf) - $(d_8859g) | $(gzip) > $(psfdir)/$@

%.raw: %.bdf
	$(ucs2vga) $< $(r_koi8r) $(b_koi8r) | $(bdf2raw) > $(rawdir)/$@

all: pcf psf raw

pcf: pcfdir $(pcffiles_gz)

psf: psfdir $(psffiles_gz)

raw: rawdir $(rawfiles)

pcfdir:
	mkdir -p $(pcfdir)

psfdir:
	mkdir -p $(psfdir)

rawdir:
	mkdir -p $(rawdir)

clean:
	if [ -d $(pcfdir) ]; then rm -f $(addprefix $(pcfdir)/, $(pcffiles_gz)) && rmdir $(pcfdir); fi
	if [ -d $(psfdir) ]; then rm -f $(addprefix $(psfdir)/, $(psffiles_gz)) && rmdir $(psfdir); fi
	if [ -d $(rawdir) ]; then rm -f $(addprefix $(rawdir)/, $(rawfiles)) && rmdir $(rawdir); fi

echo:
	@echo bdffiles = $(bdffiles)
	@echo pcffiles_gz = $(pcffiles_gz)
	@echo psffiles_gz = $(psffiles_gz)
	@echo rawfiles = $(rawfiles)
