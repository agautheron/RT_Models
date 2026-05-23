SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = ./old
BUILDDIR      = _build

KATEX := https://github.com/KaTeX/KaTeX/releases/download
KATEX_VERSION := v0.16.9

.PHONY: all html clean

all: html

_static/katex/katex.min.js:
	[ ! -d _static/katex ] & mkdir -p _static/katex
	curl -L $(KATEX)/$(KATEX_VERSION)/katex.tar.gz | tar -x -z -C _static/

#-------------------------------------------------------------------------------

BLOCH_IMAGES = old/bloch/saturation_recovery.png

$(BLOCH_IMAGES): old/bloch/saturation_recovery.py simulator.py style.py
	PYTHONPATH="$(PWD)":$(PYTHONPATH) python3 $<

#-------------------------------------------------------------------------------

SPECTRO_IMAGES = $(addprefix old/spectroscopy/, \
	Cr_no_dwell_time.png Cr.png Cr3.png ppm.png apodization.png \
	frequency_shift.png rephase.png)

$(SPECTRO_IMAGES) &: old/spectroscopy/spectroscopy.py old/spectroscopy/utils.py \
			old/spectroscopy/Cr.RAW old/spectroscopy/Cr3.RAW old/spectroscopy/Lac.RAW
	cd old/spectroscopy; python3 spectroscopy.py

#-------------------------------------------------------------------------------

SPATIAL_ENCODING_1D_IMAGES = $(addprefix old/spatial_encoding/,\
	object_1d.png signal_1d.png image_1d.png image_1d_T2.png \
	image_1d_aliased.png signal_1d_long_dwell_time.png \
	image_1d_long_dwell_time.png)

$(SPATIAL_ENCODING_1D_IMAGES) \
		&: old/spatial_encoding/spatial_encoding_1d.py simulator.py style.py
	PYTHONPATH="$(PWD)":$(PYTHONPATH) python3 $<

#-------------------------------------------------------------------------------

SPATIAL_ENCODING_2D_IMAGES = $(addprefix old/spatial_encoding/,\
	object_2d.png trajectory_zig_zag.png signal_zig_zag.png image_zig_zag.png \
	signal_zig_zag_long_dwell_time.png image_zig_zag_long_dwell_time.png)
$(SPATIAL_ENCODING_2D_IMAGES) \
		&: old/spatial_encoding/spatial_encoding_zig_zag.py simulator.py style.py
	PYTHONPATH="$(PWD)":$(PYTHONPATH) python3 $<

#-------------------------------------------------------------------------------

QUANTIFICATION_IMAGES = $(addprefix old/quantification/,\
	quantification_T1_BM.png quantification_T1_BM_noisy.png \
	quantification_T1_fit.png quantification_T1_monte_carlo.png)

$(QUANTIFICATION_IMAGES) &: old/quantification/quantification_T1.py style.py
	PYTHONPATH="$(PWD)":$(PYTHONPATH) python3 $<

#-------------------------------------------------------------------------------

IMAGES = \
	$(BLOCH_IMAGES) \
	$(SPECTRO_IMAGES) \
	$(SPATIAL_ENCODING_1D_IMAGES) \
	$(SPATIAL_ENCODING_2D_IMAGES) \
	$(QUANTIFICATION_IMAGES)

html: Makefile _static/katex/katex.min.js $(IMAGES)
	@$(SPHINXBUILD) -b $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	cp simulator.py Simulator.m "$(BUILDDIR)"
	mkdir -p "$(BUILDDIR)"/bloch
	cp old/bloch/saturation_recovery.py old/bloch/saturation_recovery.m \
		"$(BUILDDIR)"/bloch
	mkdir -p "$(BUILDDIR)"/spatial_encoding
	cp \
		old/spatial_encoding/spatial_encoding_1d.py \
		old/spatial_encoding/spatial_encoding_1d.m \
		old/spatial_encoding/spatial_encoding_zig_zag.py \
		old/spatial_encoding/spatial_encoding_zig_zag.m \
		"$(BUILDDIR)"/spatial_encoding
	mkdir -p "$(BUILDDIR)"/spectroscopy
	cp old/spectroscopy/utils.py old/spectroscopy/read_LCMRAW.m \
		old/spectroscopy/spectroscopy.py old/spectroscopy/spectroscopy.m \
		old/spectroscopy/Cr.RAW \
		old/spectroscopy/Cr3.RAW old/spectroscopy/Lac.RAW "$(BUILDDIR)"/spectroscopy
	mkdir -p "$(BUILDDIR)"/quantification
	cp old/quantification/quantification_T1.py "$(BUILDDIR)"/quantification

clean: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
