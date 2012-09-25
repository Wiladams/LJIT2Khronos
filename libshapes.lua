--
-- libshapes: high-level OpenVG API
-- Anthony Starks (ajstarks@gmail.com)
--
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <jpeglib.h>
#include "VG/openvg.h"
#include "VG/vgu.h"
#include "EGL/egl.h"
#include "GLES/gl.h"
#include "DejaVuSans.inc"	-- font data
#include "DejaVuSerif.inc"
#include "DejaVuSansMono.inc"
#include "eglstate.h"		-- data structures for graphics state
#include "fontinfo.h"		-- font data structure
static STATE_T _state, *state = &_state;	-- global graphics state
static const int MAXFONTPATH = 256;

--
-- Font functions
--

-- loadfont loads font path data
-- derived from http:--web.archive.org/web/20070808195131/http:--developer.hybrid.fi/font2openvg/renderFont.cpp.txt
Fontinfo loadfont(const int *Points,
		  const int *PointIndices,
		  const unsigned char *Instructions,
		  const int *InstructionIndices, const int *InstructionCounts, const int *adv, const short *cmap, int ng) {

	Fontinfo f;
	int i;

	memset(f.Glyphs, 0, MAXFONTPATH * sizeof(VGPath));
	if (ng > MAXFONTPATH) {
		return f;
	}
	for (i = 0; i < ng; i++) {
		const int *p = &Points[PointIndices[i] * 2];
		const unsigned char *instructions = &Instructions[InstructionIndices[i]];
		int ic = InstructionCounts[i];
		VGPath path = vgCreatePath(VG_PATH_FORMAT_STANDARD, VG_PATH_DATATYPE_S_32,
					   1.0f / 65536.0f, 0.0f, 0, 0,
					   VG_PATH_CAPABILITY_ALL);
		f.Glyphs[i] = path;
		if (ic) {
			vgAppendPathData(path, ic, instructions, p);
		}
	}
	f.CharacterMap = cmap;
	f.GlyphAdvances = adv;
	f.Count = ng;
	return f;
}

-- unloadfont frees font path data
function unloadfont(VGPath * glyphs, int n) 

	local i;
	for (i = 0; i < n; i++) 
	{
		vgDestroyPath(glyphs[i]);
	}
end

-- createImageFromJpeg decompresses a JPEG image to the standard image format
-- source: https:--github.com/ileben/ShivaVG/blob/master/examples/test_image.c
VGImage createImageFromJpeg(const char *filename) {
	FILE *infile;
	struct jpeg_decompress_struct jdc;
	struct jpeg_error_mgr jerr;
	JSAMPARRAY buffer;
	unsigned int bstride;
	unsigned int bbpp;

	VGImage img;
	VGubyte *data;
	unsigned int width;
	unsigned int height;
	unsigned int dstride;
	unsigned int dbpp;

	VGubyte *brow;
	VGubyte *drow;
	unsigned int x;
	unsigned int lilEndianTest = 1;
	VGImageFormat rgbaFormat;

	-- Check for endianness
	if (((unsigned char *)&lilEndianTest)[0] == 1)
		rgbaFormat = VG_sABGR_8888;
	else
		rgbaFormat = VG_sRGBA_8888;

	-- Try to open image file
	infile = fopen(filename, "rb");
	if (infile == NULL) {
		printf("Failed opening '%s' for reading!\n", filename);
		return VG_INVALID_HANDLE;
	}
	-- Setup default error handling
	jdc.err = jpeg_std_error(&jerr);
	jpeg_create_decompress(&jdc);

	-- Set input file
	jpeg_stdio_src(&jdc, infile);

	-- Read header and start
	jpeg_read_header(&jdc, TRUE);
	jpeg_start_decompress(&jdc);
	width = jdc.output_width;
	height = jdc.output_height;

	-- Allocate buffer using jpeg allocator
	bbpp = jdc.output_components;
	bstride = width * bbpp;
	buffer = (*jdc.mem->alloc_sarray)
	    ((j_common_ptr) & jdc, JPOOL_IMAGE, bstride, 1);

	-- Allocate image data buffer
	dbpp = 4;
	dstride = width * dbpp;
	data = (VGubyte *) malloc(dstride * height);

	-- Iterate until all scanlines processed
	while (jdc.output_scanline < height) {

		-- Read scanline into buffer
		jpeg_read_scanlines(&jdc, buffer, 1);
		drow = data + (height - jdc.output_scanline) * dstride;
		brow = buffer[0];
		-- Expand to RGBA
		for (x = 0; x < width; ++x, drow += dbpp, brow += bbpp) {
			switch (bbpp) {
			case 4:
				drow[0] = brow[0];
				drow[1] = brow[1];
				drow[2] = brow[2];
				drow[3] = brow[3];
				break;
			case 3:
				drow[0] = brow[0];
				drow[1] = brow[1];
				drow[2] = brow[2];
				drow[3] = 255;
				break;
			}
		}
	}

	-- Create VG image
	img = vgCreateImage(rgbaFormat, width, height, VG_IMAGE_QUALITY_BETTER);
	vgImageSubData(img, data, dstride, rgbaFormat, 0, 0, width, height);

	-- Cleanup
	jpeg_destroy_decompress(&jdc);
	fclose(infile);
	free(data);

	return img;
}

-- Image places an image at the specifed location
void Image(VGfloat x, VGfloat y, int w, int h, char *filename) {
	VGImage img = createImageFromJpeg(filename);
	vgSetPixels(x, y, img, 0, 0, w, h);
	vgDestroyImage(img);
}

-- dumpscreen writes the raster to the standard output file
void dumpscreen(int w, int h, FILE * fp) {
	void *ScreenBuffer = malloc(w * h * 4);
	vgReadPixels(ScreenBuffer, (w * 4), VG_sABGR_8888, 0, 0, w, h);
	fwrite(ScreenBuffer, 1, w * h * 4, fp);
	free(ScreenBuffer);
}

-- init sets the system to its initial state
void init(int *w, int *h) {
	bcm_host_init();
	memset(state, 0, sizeof(*state));
	oglinit(state);
	SansTypeface = loadfont(DejaVuSans_glyphPoints,
				DejaVuSans_glyphPointIndices,
				DejaVuSans_glyphInstructions,
				DejaVuSans_glyphInstructionIndices,
				DejaVuSans_glyphInstructionCounts,
				DejaVuSans_glyphAdvances, DejaVuSans_characterMap, DejaVuSans_glyphCount);

	SerifTypeface = loadfont(DejaVuSerif_glyphPoints,
				 DejaVuSerif_glyphPointIndices,
				 DejaVuSerif_glyphInstructions,
				 DejaVuSerif_glyphInstructionIndices,
				 DejaVuSerif_glyphInstructionCounts,
				 DejaVuSerif_glyphAdvances, DejaVuSerif_characterMap, DejaVuSerif_glyphCount);

	MonoTypeface = loadfont(DejaVuSansMono_glyphPoints,
				DejaVuSansMono_glyphPointIndices,
				DejaVuSansMono_glyphInstructions,
				DejaVuSansMono_glyphInstructionIndices,
				DejaVuSansMono_glyphInstructionCounts,
				DejaVuSansMono_glyphAdvances, DejaVuSansMono_characterMap, DejaVuSansMono_glyphCount);

	*w = state->screen_width;
	*h = state->screen_height;
}

-- finish cleans up
void finish() {
	unloadfont(SansTypeface.Glyphs, SansTypeface.Count);
	unloadfont(SerifTypeface.Glyphs, SerifTypeface.Count);
	glClear(GL_COLOR_BUFFER_BIT);
	eglSwapBuffers(state->display, state->surface);
	eglMakeCurrent(state->display, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
	eglDestroySurface(state->display, state->surface);
	eglDestroyContext(state->display, state->context);
	eglTerminate(state->display);
}

--
-- Transformations
--

-- Translate the coordinate system to x,y
function Translate(VGfloat x, VGfloat y) 
{
	vgTranslate(x, y);
}

-- Rotate around angle r
function Rotate(VGfloat r) 
{
	vgRotate(r);
}

-- Shear shears the x coordinate by x degrees, the y coordinate by y degrees
function Shear(VGfloat x, VGfloat y) 
{
	vgShear(x, y);
}

-- Scale scales by  x, y
function Scale(VGfloat x, VGfloat y) 
{
	vgScale(x, y);
}

--
-- Style functions
--

-- setfill sets the fill color
function setfill(VGfloat color[4]) {
	VGPaint fillPaint = vgCreatePaint();
	vgSetParameteri(fillPaint, VG_PAINT_TYPE, VG_PAINT_TYPE_COLOR);
	vgSetParameterfv(fillPaint, VG_PAINT_COLOR, 4, color);
	vgSetPaint(fillPaint, VG_FILL_PATH);
	vgDestroyPaint(fillPaint);
}

-- setstroke sets the stroke color
function setstroke(VGfloat color[4]) {
	VGPaint strokePaint = vgCreatePaint();
	vgSetParameteri(strokePaint, VG_PAINT_TYPE, VG_PAINT_TYPE_COLOR);
	vgSetParameterfv(strokePaint, VG_PAINT_COLOR, 4, color);
	vgSetPaint(strokePaint, VG_STROKE_PATH);
	vgDestroyPaint(strokePaint);
}

-- StrokeWidth sets the stroke width
function StrokeWidth(VGfloat width) {
	vgSetf(VG_STROKE_LINE_WIDTH, width);
	vgSeti(VG_STROKE_CAP_STYLE, VG_CAP_BUTT);
	vgSeti(VG_STROKE_JOIN_STYLE, VG_JOIN_MITER);
}

--
-- Color functions
--
--

-- RGBA fills a color vectors from a RGBA quad.
function RGBA(unsigned int r, unsigned int g, unsigned int b, VGfloat a, VGfloat color[4]) {
	if (r > 255) {
		r = 0;
	}
	if (g > 255) {
		g = 0;
	}
	if (b > 255) {
		b = 0;
	}
	if (a < 0.0 || a > 1.0) {
		a = 1.0;
	}
	color[0] = (VGfloat) r / 255.0f;
	color[1] = (VGfloat) g / 255.0f;
	color[2] = (VGfloat) b / 255.0f;
	color[3] = a;
}

-- RGB returns a solid color from a RGB triple
void RGB(unsigned int r, unsigned int g, unsigned int b, VGfloat color[4]) {
	RGBA(r, g, b, 1.0f, color);
}

-- Stroke sets the stroke color, defined as a RGB triple.
void Stroke(unsigned int r, unsigned int g, unsigned int b, VGfloat a) {
	VGfloat color[4];
	RGBA(r, g, b, a, color);
	setstroke(color);
}

-- Fill sets the fillcolor, defined as a RGBA quad.
void Fill(unsigned int r, unsigned int g, unsigned int b, VGfloat a) {
	VGfloat color[4];
	RGBA(r, g, b, a, color);
	setfill(color);
}

-- Text renders a string of text at a specified location, size, using the specified font glyphs
-- derived from http:--web.archive.org/web/20070808195131/http:--developer.hybrid.fi/font2openvg/renderFont.cpp.txt
void Text(VGfloat x, VGfloat y, char *s, Fontinfo f, int pointsize) {
	VGfloat size = (VGfloat) pointsize, xx = x, mm[9];
	int i;

	vgGetMatrix(mm);
	for (i = 0; i < (int)strlen(s); i++) {
		unsigned int character = (unsigned int)s[i];
		int glyph = f.CharacterMap[character];
		if (glyph == -1) {
			continue;	--glyph is undefined
		}
		VGfloat mat[9] = {
			size, 0.0f, 0.0f,
			0.0f, size, 0.0f,
			xx, y, 1.0f
		};
		vgLoadMatrix(mm);
		vgMultMatrix(mat);
		vgDrawPath(f.Glyphs[glyph], VG_FILL_PATH | VG_STROKE_PATH);
		xx += size * f.GlyphAdvances[glyph] / 65536.0f;
	}
	vgLoadMatrix(mm);
}

-- textwidth returns the width of a text string at the specified font and size.
VGfloat textwidth(char *s, Fontinfo f, VGfloat size) {
	int i;
	VGfloat tw = 0.0;
	for (i = 0; i < (int)strlen(s); i++) {
		unsigned int character = (unsigned int)s[i];
		int glyph = f.CharacterMap[character];
		if (glyph == -1) {
			continue;	--glyph is undefined
		}
		tw += size * f.GlyphAdvances[glyph] / 65536.0f;
	}
	return tw;
}

-- TextMid draws text, centered on (x,y)
void TextMid(VGfloat x, VGfloat y, char *s, Fontinfo f, int pointsize) {
	VGfloat tw = textwidth(s, f, pointsize);
	Text(x - (tw / 2.0), y, s, f, pointsize);
}

-- TextEnd draws text, with its end aligned to (x,y)
void TextEnd(VGfloat x, VGfloat y, char *s, Fontinfo f, int pointsize) {
	VGfloat tw = textwidth(s, f, pointsize);
	Text(x - tw, y, s, f, pointsize);
}

--
-- Shape functions
--

-- newpath creates path data
VGPath newpath() {
	return vgCreatePath(VG_PATH_FORMAT_STANDARD, VG_PATH_DATATYPE_F, 1.0f, 0.0f, 0, 0, VG_PATH_CAPABILITY_ALL);
}

-- makecurve makes path data using specified segments and coordinates
function makecurve(VGubyte * segments, VGfloat * coords) {
	VGPath path = newpath();
	vgAppendPathData(path, 2, segments, coords);
	vgDrawPath(path, VG_FILL_PATH | VG_STROKE_PATH);
	vgDestroyPath(path);
}

-- CBezier makes a quadratic bezier curve
function Cbezier(VGfloat sx, VGfloat sy, VGfloat cx, VGfloat cy, VGfloat px, VGfloat py, VGfloat ex, VGfloat ey) {
	VGubyte segments[] = { VG_MOVE_TO_ABS, VG_CUBIC_TO };
	VGfloat coords[] = { sx, sy, cx, cy, px, py, ex, ey };
	makecurve(segments, coords);
}

-- QBezier makes a quadratic bezier curve
function Qbezier(VGfloat sx, VGfloat sy, VGfloat cx, VGfloat cy, VGfloat ex, VGfloat ey) {
	VGubyte segments[] = { VG_MOVE_TO_ABS, VG_QUAD_TO };
	VGfloat coords[] = { sx, sy, cx, cy, ex, ey };
	makecurve(segments, coords);
}

-- interleave interleaves arrays of x, y into a single array
function interleave(VGfloat * x, VGfloat * y, int n, VGfloat * points) {
	while (n--) {
		*points++ = *x++;
		*points++ = *y++;
	}
}

-- poly makes either a polygon or polyline
function poly(VGfloat * x, VGfloat * y, VGint n, VGbitfield flag) {
	VGfloat points[n * 2];
	VGPath path = newpath();
	interleave(x, y, n, points);
	vguPolygon(path, points, n, VG_FALSE);
	vgDrawPath(path, flag);
	vgDestroyPath(path);
}

-- Polygon makes a filled polygon with vertices in x, y arrays
function Polygon(VGfloat * x, VGfloat * y, VGint n) {
	poly(x, y, n, VG_FILL_PATH);
}

-- Polyline makes a polyline with vertices at x, y arrays
function Polyline(VGfloat * x, VGfloat * y, VGint n) {
	poly(x, y, n, VG_STROKE_PATH);
}

-- Rect makes a rectangle at the specified location and dimensions
function Rect(VGfloat x, VGfloat y, VGfloat w, VGfloat h) {
	VGPath path = newpath();
	vguRect(path, x, y, w, h);
	vgDrawPath(path, VG_FILL_PATH | VG_STROKE_PATH);
	vgDestroyPath(path);
}

-- Line makes a line from (x1,y1) to (x2,y2)
function Line(VGfloat x1, VGfloat y1, VGfloat x2, VGfloat y2) {
	VGPath path = newpath();
	vguLine(path, x1, y1, x2, y2);
	vgDrawPath(path, VG_STROKE_PATH);
	vgDestroyPath(path);
}

-- Roundrect makes an rounded rectangle at the specified location and dimensions
function Roundrect(VGfloat x, VGfloat y, VGfloat w, VGfloat h, VGfloat rw, VGfloat rh) {
	VGPath path = newpath();
	vguRoundRect(path, x, y, w, h, rw, rh);
	vgDrawPath(path, VG_FILL_PATH | VG_STROKE_PATH);
	vgDestroyPath(path);
}

-- Ellipse makes an ellipse at the specified location and dimensions
function Ellipse(VGfloat x, VGfloat y, VGfloat w, VGfloat h) {
	VGPath path = newpath();
	vguEllipse(path, x, y, w, h);
	vgDrawPath(path, VG_FILL_PATH | VG_STROKE_PATH);
	vgDestroyPath(path);
}

-- Circle makes a circle at the specified location and dimensions
function Circle(VGfloat x, VGfloat y, VGfloat r) {
	Ellipse(x, y, r, r);
}

-- Arc makes an elliptical arc at the specified location and dimensions
function Arc(VGfloat x, VGfloat y, VGfloat w, VGfloat h, VGfloat sa, VGfloat aext) {
	VGPath path = newpath();
	vguArc(path, x, y, w, h, sa, aext, VGU_ARC_OPEN);
	vgDrawPath(path, VG_FILL_PATH | VG_STROKE_PATH);
	vgDestroyPath(path);
}

-- Start begins the picture, clearing a rectangular region with a specified color
function Start(int width, int height) {
	VGfloat color[4] = { 255, 255, 255, 1 };
	vgSetfv(VG_CLEAR_COLOR, 4, color);
	vgClear(0, 0, width, height);
	color[0] = 0, color[1] = 0, color[2] = 0;
	setfill(color);
	setstroke(color);
	StrokeWidth(0);
	vgLoadIdentity();
}

-- End checks for errors, and renders to the display
function End() {
	assert(vgGetError() == VG_NO_ERROR);
	eglSwapBuffers(state->display, state->surface);
	assert(eglGetError() == EGL_SUCCESS);
}

-- SaveEnd dumps the raster before rendering to the display 
function SaveEnd(char *filename) {
	FILE *fp;
	assert(vgGetError() == VG_NO_ERROR);
	if (strlen(filename) == 0) {
		dumpscreen(state->screen_width, state->screen_height, stdout);
	} else {
		fp = fopen(filename, "wb");
		if (fp != NULL) {
			dumpscreen(state->screen_width, state->screen_height, fp);
			fclose(fp);
		}
	}
	eglSwapBuffers(state->display, state->surface);
	assert(eglGetError() == EGL_SUCCESS);
}

-- clear the screen to a background color
function Background(unsigned int r, unsigned int g, unsigned int b) {
	Fill(r, g, b, 1);
	Rect(0, 0, state->screen_width, state->screen_height);
}
