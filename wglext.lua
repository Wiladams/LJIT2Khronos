
--[[
/*
** Copyright (c) 2007-2012 The Khronos Group Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and/or associated documentation files (the
** "Materials"), to deal in the Materials without restriction, including
** without limitation the rights to use, copy, modify, merge, publish,
** distribute, sublicense, and/or sell copies of the Materials, and to
** permit persons to whom the Materials are furnished to do so, subject to
** the following conditions:
**
** The above copyright notice and this permission notice shall be included
** in all copies or substantial portions of the Materials.
**
** THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
** MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
** IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
** CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
** TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
** MATERIALS OR THE USE OR OTHER DEALINGS IN THE MATERIALS.
*/
--]]

--[[
/* Header file version number */
/* wglext.h last updated 2012/01/04 */
/* Current version at http://www.opengl.org/registry/ */
--]]

--[[
	This file should be included from OglMan, and not directly
--]]


local ffi = require "ffi"

WGL_WGLEXT_VERSION = 24

-- WGL_ARB_buffer_region
WGL_FRONT_COLOR_BUFFER_BIT_ARB = 0x00000001
WGL_BACK_COLOR_BUFFER_BIT_ARB  = 0x00000002
WGL_DEPTH_BUFFER_BIT_ARB       = 0x00000004
WGL_STENCIL_BUFFER_BIT_ARB     = 0x00000008


-- WGL_ARB_multisample
WGL_SAMPLE_BUFFERS_ARB         = 0x2041
WGL_SAMPLES_ARB                = 0x2042


-- WGL_ARB_extensions_string


-- WGL_ARB_pixel_format
WGL_NUMBER_PIXEL_FORMATS_ARB   = 0x2000
WGL_DRAW_TO_WINDOW_ARB         = 0x2001
WGL_DRAW_TO_BITMAP_ARB         = 0x2002
WGL_ACCELERATION_ARB           = 0x2003
WGL_NEED_PALETTE_ARB           = 0x2004
WGL_NEED_SYSTEM_PALETTE_ARB    = 0x2005
WGL_SWAP_LAYER_BUFFERS_ARB     = 0x2006
WGL_SWAP_METHOD_ARB            = 0x2007
WGL_NUMBER_OVERLAYS_ARB        = 0x2008
WGL_NUMBER_UNDERLAYS_ARB       = 0x2009
WGL_TRANSPARENT_ARB            = 0x200A
WGL_TRANSPARENT_RED_VALUE_ARB  = 0x2037
WGL_TRANSPARENT_GREEN_VALUE_ARB = 0x2038
WGL_TRANSPARENT_BLUE_VALUE_ARB = 0x2039
WGL_TRANSPARENT_ALPHA_VALUE_ARB = 0x203A
WGL_TRANSPARENT_INDEX_VALUE_ARB = 0x203B
WGL_SHARE_DEPTH_ARB            = 0x200C
WGL_SHARE_STENCIL_ARB          = 0x200D
WGL_SHARE_ACCUM_ARB            = 0x200E
WGL_SUPPORT_GDI_ARB            = 0x200F
WGL_SUPPORT_OPENGL_ARB         = 0x2010
WGL_DOUBLE_BUFFER_ARB          = 0x2011
WGL_STEREO_ARB                 = 0x2012
WGL_PIXEL_TYPE_ARB             = 0x2013
WGL_COLOR_BITS_ARB             = 0x2014
WGL_RED_BITS_ARB               = 0x2015
WGL_RED_SHIFT_ARB              = 0x2016
WGL_GREEN_BITS_ARB             = 0x2017
WGL_GREEN_SHIFT_ARB            = 0x2018
WGL_BLUE_BITS_ARB              = 0x2019
WGL_BLUE_SHIFT_ARB             = 0x201A
WGL_ALPHA_BITS_ARB             = 0x201B
WGL_ALPHA_SHIFT_ARB            = 0x201C
WGL_ACCUM_BITS_ARB             = 0x201D
WGL_ACCUM_RED_BITS_ARB         = 0x201E
WGL_ACCUM_GREEN_BITS_ARB       = 0x201F
WGL_ACCUM_BLUE_BITS_ARB        = 0x2020
WGL_ACCUM_ALPHA_BITS_ARB       = 0x2021
WGL_DEPTH_BITS_ARB             = 0x2022
WGL_STENCIL_BITS_ARB           = 0x2023
WGL_AUX_BUFFERS_ARB            = 0x2024
WGL_NO_ACCELERATION_ARB        = 0x2025
WGL_GENERIC_ACCELERATION_ARB   = 0x2026
WGL_FULL_ACCELERATION_ARB      = 0x2027
WGL_SWAP_EXCHANGE_ARB          = 0x2028
WGL_SWAP_COPY_ARB              = 0x2029
WGL_SWAP_UNDEFINED_ARB         = 0x202A
WGL_TYPE_RGBA_ARB              = 0x202B
WGL_TYPE_COLORINDEX_ARB        = 0x202C


-- WGL_ARB_make_current_read
ERROR_INVALID_PIXEL_TYPE_ARB   = 0x2043
ERROR_INCOMPATIBLE_DEVICE_CONTEXTS_ARB = 0x2054


-- WGL_ARB_pbuffer
WGL_DRAW_TO_PBUFFER_ARB        = 0x202D
WGL_MAX_PBUFFER_PIXELS_ARB     = 0x202E
WGL_MAX_PBUFFER_WIDTH_ARB      = 0x202F
WGL_MAX_PBUFFER_HEIGHT_ARB     = 0x2030
WGL_PBUFFER_LARGEST_ARB        = 0x2033
WGL_PBUFFER_WIDTH_ARB          = 0x2034
WGL_PBUFFER_HEIGHT_ARB         = 0x2035
WGL_PBUFFER_LOST_ARB           = 0x2036


-- WGL_ARB_render_texture
WGL_BIND_TO_TEXTURE_RGB_ARB    = 0x2070
WGL_BIND_TO_TEXTURE_RGBA_ARB   = 0x2071
WGL_TEXTURE_FORMAT_ARB         = 0x2072
WGL_TEXTURE_TARGET_ARB         = 0x2073
WGL_MIPMAP_TEXTURE_ARB         = 0x2074
WGL_TEXTURE_RGB_ARB            = 0x2075
WGL_TEXTURE_RGBA_ARB           = 0x2076
WGL_NO_TEXTURE_ARB             = 0x2077
WGL_TEXTURE_CUBE_MAP_ARB       = 0x2078
WGL_TEXTURE_1D_ARB             = 0x2079
WGL_TEXTURE_2D_ARB             = 0x207A
WGL_MIPMAP_LEVEL_ARB           = 0x207B
WGL_CUBE_MAP_FACE_ARB          = 0x207C
WGL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB = 0x207D
WGL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB = 0x207E
WGL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB = 0x207F
WGL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB = 0x2080
WGL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB = 0x2081
WGL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB = 0x2082
WGL_FRONT_LEFT_ARB             = 0x2083
WGL_FRONT_RIGHT_ARB            = 0x2084
WGL_BACK_LEFT_ARB              = 0x2085
WGL_BACK_RIGHT_ARB             = 0x2086
WGL_AUX0_ARB                   = 0x2087
WGL_AUX1_ARB                   = 0x2088
WGL_AUX2_ARB                   = 0x2089
WGL_AUX3_ARB                   = 0x208A
WGL_AUX4_ARB                   = 0x208B
WGL_AUX5_ARB                   = 0x208C
WGL_AUX6_ARB                   = 0x208D
WGL_AUX7_ARB                   = 0x208E
WGL_AUX8_ARB                   = 0x208F
WGL_AUX9_ARB                   = 0x2090


-- WGL_ARB_pixel_format_float
WGL_TYPE_RGBA_FLOAT_ARB        = 0x21A0


-- WGL_ARB_framebuffer_sRGB
WGL_FRAMEBUFFER_SRGB_CAPABLE_ARB = 0x20A9


-- WGL_ARB_create_context
WGL_CONTEXT_DEBUG_BIT_ARB      = 0x00000001
WGL_CONTEXT_FORWARD_COMPATIBLE_BIT_ARB = 0x00000002
WGL_CONTEXT_MAJOR_VERSION_ARB  = 0x2091
WGL_CONTEXT_MINOR_VERSION_ARB  = 0x2092
WGL_CONTEXT_LAYER_PLANE_ARB    = 0x2093
WGL_CONTEXT_FLAGS_ARB          = 0x2094
ERROR_INVALID_VERSION_ARB      = 0x2095


-- WGL_ARB_create_context_profile
WGL_CONTEXT_PROFILE_MASK_ARB   = 0x9126
WGL_CONTEXT_CORE_PROFILE_BIT_ARB = 0x00000001
WGL_CONTEXT_COMPATIBILITY_PROFILE_BIT_ARB = 0x00000002
ERROR_INVALID_PROFILE_ARB      = 0x2096


-- WGL_ARB_create_context_robustness
WGL_CONTEXT_ROBUST_ACCESS_BIT_ARB = 0x00000004
WGL_LOSE_CONTEXT_ON_RESET_ARB  = 0x8252
WGL_CONTEXT_RESET_NOTIFICATION_STRATEGY_ARB = 0x8256
WGL_NO_RESET_NOTIFICATION_ARB  = 0x8261


-- WGL_EXT_make_current_read
ERROR_INVALID_PIXEL_TYPE_EXT   = 0x2043


-- WGL_EXT_pixel_format
WGL_NUMBER_PIXEL_FORMATS_EXT   = 0x2000
WGL_DRAW_TO_WINDOW_EXT         = 0x2001
WGL_DRAW_TO_BITMAP_EXT         = 0x2002
WGL_ACCELERATION_EXT           = 0x2003
WGL_NEED_PALETTE_EXT           = 0x2004
WGL_NEED_SYSTEM_PALETTE_EXT    = 0x2005
WGL_SWAP_LAYER_BUFFERS_EXT     = 0x2006
WGL_SWAP_METHOD_EXT            = 0x2007
WGL_NUMBER_OVERLAYS_EXT        = 0x2008
WGL_NUMBER_UNDERLAYS_EXT       = 0x2009
WGL_TRANSPARENT_EXT            = 0x200A
WGL_TRANSPARENT_VALUE_EXT      = 0x200B
WGL_SHARE_DEPTH_EXT            = 0x200C
WGL_SHARE_STENCIL_EXT          = 0x200D
WGL_SHARE_ACCUM_EXT            = 0x200E
WGL_SUPPORT_GDI_EXT            = 0x200F
WGL_SUPPORT_OPENGL_EXT         = 0x2010
WGL_DOUBLE_BUFFER_EXT          = 0x2011
WGL_STEREO_EXT                 = 0x2012
WGL_PIXEL_TYPE_EXT             = 0x2013
WGL_COLOR_BITS_EXT             = 0x2014
WGL_RED_BITS_EXT               = 0x2015
WGL_RED_SHIFT_EXT              = 0x2016
WGL_GREEN_BITS_EXT             = 0x2017
WGL_GREEN_SHIFT_EXT            = 0x2018
WGL_BLUE_BITS_EXT              = 0x2019
WGL_BLUE_SHIFT_EXT             = 0x201A
WGL_ALPHA_BITS_EXT             = 0x201B
WGL_ALPHA_SHIFT_EXT            = 0x201C
WGL_ACCUM_BITS_EXT             = 0x201D
WGL_ACCUM_RED_BITS_EXT         = 0x201E
WGL_ACCUM_GREEN_BITS_EXT       = 0x201F
WGL_ACCUM_BLUE_BITS_EXT        = 0x2020
WGL_ACCUM_ALPHA_BITS_EXT       = 0x2021
WGL_DEPTH_BITS_EXT             = 0x2022
WGL_STENCIL_BITS_EXT           = 0x2023
WGL_AUX_BUFFERS_EXT            = 0x2024
WGL_NO_ACCELERATION_EXT        = 0x2025
WGL_GENERIC_ACCELERATION_EXT   = 0x2026
WGL_FULL_ACCELERATION_EXT      = 0x2027
WGL_SWAP_EXCHANGE_EXT          = 0x2028
WGL_SWAP_COPY_EXT              = 0x2029
WGL_SWAP_UNDEFINED_EXT         = 0x202A
WGL_TYPE_RGBA_EXT              = 0x202B
WGL_TYPE_COLORINDEX_EXT        = 0x202C


-- WGL_EXT_pbuffer
WGL_DRAW_TO_PBUFFER_EXT        = 0x202D
WGL_MAX_PBUFFER_PIXELS_EXT     = 0x202E
WGL_MAX_PBUFFER_WIDTH_EXT      = 0x202F
WGL_MAX_PBUFFER_HEIGHT_EXT     = 0x2030
WGL_OPTIMAL_PBUFFER_WIDTH_EXT  = 0x2031
WGL_OPTIMAL_PBUFFER_HEIGHT_EXT = 0x2032
WGL_PBUFFER_LARGEST_EXT        = 0x2033
WGL_PBUFFER_WIDTH_EXT          = 0x2034
WGL_PBUFFER_HEIGHT_EXT         = 0x2035


-- WGL_EXT_depth_float
WGL_DEPTH_FLOAT_EXT            = 0x2040


-- WGL_3DFX_multisample
WGL_SAMPLE_BUFFERS_3DFX        = 0x2060
WGL_SAMPLES_3DFX               = 0x2061


-- WGL_EXT_multisample
WGL_SAMPLE_BUFFERS_EXT         = 0x2041
WGL_SAMPLES_EXT                = 0x2042


-- WGL_I3D_digital_video_control
WGL_DIGITAL_VIDEO_CURSOR_ALPHA_FRAMEBUFFER_I3D = 0x2050
WGL_DIGITAL_VIDEO_CURSOR_ALPHA_VALUE_I3D = 0x2051
WGL_DIGITAL_VIDEO_CURSOR_INCLUDED_I3D = 0x2052
WGL_DIGITAL_VIDEO_GAMMA_CORRECTED_I3D = 0x2053


-- WGL_I3D_gamma
WGL_GAMMA_TABLE_SIZE_I3D       = 0x204E
WGL_GAMMA_EXCLUDE_DESKTOP_I3D  = 0x204F


-- WGL_I3D_genlock
WGL_GENLOCK_SOURCE_MULTIVIEW_I3D = 0x2044
WGL_GENLOCK_SOURCE_EXTENAL_SYNC_I3D = 0x2045
WGL_GENLOCK_SOURCE_EXTENAL_FIELD_I3D = 0x2046
WGL_GENLOCK_SOURCE_EXTENAL_TTL_I3D = 0x2047
WGL_GENLOCK_SOURCE_DIGITAL_SYNC_I3D = 0x2048
WGL_GENLOCK_SOURCE_DIGITAL_FIELD_I3D = 0x2049
WGL_GENLOCK_SOURCE_EDGE_FALLING_I3D = 0x204A
WGL_GENLOCK_SOURCE_EDGE_RISING_I3D = 0x204B
WGL_GENLOCK_SOURCE_EDGE_BOTH_I3D = 0x204C


-- WGL_I3D_image_buffer
WGL_IMAGE_BUFFER_MIN_ACCESS_I3D = 0x00000001
WGL_IMAGE_BUFFER_LOCK_I3D      = 0x00000002


-- WGL_I3D_swap_frame_lock


-- WGL_NV_render_depth_texture
WGL_BIND_TO_TEXTURE_DEPTH_NV   = 0x20A3
WGL_BIND_TO_TEXTURE_RECTANGLE_DEPTH_NV = 0x20A4
WGL_DEPTH_TEXTURE_FORMAT_NV    = 0x20A5
WGL_TEXTURE_DEPTH_COMPONENT_NV = 0x20A6
WGL_DEPTH_COMPONENT_NV         = 0x20A7


-- WGL_NV_render_texture_rectangle
WGL_BIND_TO_TEXTURE_RECTANGLE_RGB_NV = 0x20A0
WGL_BIND_TO_TEXTURE_RECTANGLE_RGBA_NV = 0x20A1
WGL_TEXTURE_RECTANGLE_NV       = 0x20A2


-- WGL_ATI_pixel_format_float
WGL_TYPE_RGBA_FLOAT_ATI        = 0x21A0


-- WGL_NV_float_buffer
WGL_FLOAT_COMPONENTS_NV        = 0x20B0
WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_R_NV = 0x20B1
WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RG_NV = 0x20B2
WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RGB_NV = 0x20B3
WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RGBA_NV = 0x20B4
WGL_TEXTURE_FLOAT_R_NV         = 0x20B5
WGL_TEXTURE_FLOAT_RG_NV        = 0x20B6
WGL_TEXTURE_FLOAT_RGB_NV       = 0x20B7
WGL_TEXTURE_FLOAT_RGBA_NV      = 0x20B8


-- WGL_3DL_stereo_control
WGL_STEREO_EMITTER_ENABLE_3DL  = 0x2055
WGL_STEREO_EMITTER_DISABLE_3DL = 0x2056
WGL_STEREO_POLARITY_NORMAL_3DL = 0x2057
WGL_STEREO_POLARITY_INVERT_3DL = 0x2058


-- WGL_EXT_pixel_format_packed_float
WGL_TYPE_RGBA_UNSIGNED_FLOAT_EXT = 0x20A8


-- WGL_EXT_framebuffer_sRGB
WGL_FRAMEBUFFER_SRGB_CAPABLE_EXT = 0x20A9


-- WGL_NV_present_video
WGL_NUM_VIDEO_SLOTS_NV         = 0x20F0


-- WGL_NV_video_out
WGL_BIND_TO_VIDEO_RGB_NV       = 0x20C0
WGL_BIND_TO_VIDEO_RGBA_NV      = 0x20C1
WGL_BIND_TO_VIDEO_RGB_AND_DEPTH_NV = 0x20C2
WGL_VIDEO_OUT_COLOR_NV         = 0x20C3
WGL_VIDEO_OUT_ALPHA_NV         = 0x20C4
WGL_VIDEO_OUT_DEPTH_NV         = 0x20C5
WGL_VIDEO_OUT_COLOR_AND_ALPHA_NV = 0x20C6
WGL_VIDEO_OUT_COLOR_AND_DEPTH_NV = 0x20C7
WGL_VIDEO_OUT_FRAME            = 0x20C8
WGL_VIDEO_OUT_FIELD_1          = 0x20C9
WGL_VIDEO_OUT_FIELD_2          = 0x20CA
WGL_VIDEO_OUT_STACKED_FIELDS_1_2 = 0x20CB
WGL_VIDEO_OUT_STACKED_FIELDS_2_1 = 0x20CC


-- WGL_NV_swap_group


-- WGL_NV_gpu_affinity
WGL_ERROR_INCOMPATIBLE_AFFINITY_MASKS_NV = 0x20D0
WGL_ERROR_MISSING_AFFINITY_MASK_NV = 0x20D1


-- WGL_AMD_gpu_association
WGL_GPU_VENDOR_AMD             = 0x1F00
WGL_GPU_RENDERER_STRING_AMD    = 0x1F01
WGL_GPU_OPENGL_VERSION_STRING_AMD = 0x1F02
WGL_GPU_FASTEST_TARGET_GPUS_AMD = 0x21A2
WGL_GPU_RAM_AMD                = 0x21A3
WGL_GPU_CLOCK_AMD              = 0x21A4
WGL_GPU_NUM_PIPES_AMD          = 0x21A5
WGL_GPU_NUM_SIMD_AMD           = 0x21A6
WGL_GPU_NUM_RB_AMD             = 0x21A7
WGL_GPU_NUM_SPI_AMD            = 0x21A8


-- WGL_NV_video_capture
WGL_UNIQUE_ID_NV               = 0x20CE
WGL_NUM_VIDEO_CAPTURE_SLOTS_NV = 0x20CF


-- WGL_NV_copy_image


-- WGL_NV_multisample_coverage
WGL_COVERAGE_SAMPLES_NV        = 0x2042
WGL_COLOR_SAMPLES_NV           = 0x20B9


-- WGL_EXT_create_context_es2_profile
WGL_CONTEXT_ES2_PROFILE_BIT_EXT = 0x00000004


-- WGL_NV_DX_interop
WGL_ACCESS_READ_ONLY_NV        = 0x00000000
WGL_ACCESS_READ_WRITE_NV       = 0x00000001
WGL_ACCESS_WRITE_DISCARD_NV    = 0x00000002


-- WGL_NV_DX_interop2


-- WGL_EXT_swap_control_tear


function DECLARE_HANDLE(name)
	local decl = string.format([[
		struct %s__ {
			int unused;
		};
		typedef struct %s__* %s;
		]],
		name, name, name);
	ffi.cdef(decl);
end

DECLARE_HANDLE("HPBUFFERARB");
DECLARE_HANDLE("HPBUFFEREXT");
DECLARE_HANDLE("HVIDEOOUTPUTDEVICENV");
DECLARE_HANDLE("HPVIDEODEV");
DECLARE_HANDLE("HPGPUNV");
DECLARE_HANDLE("HGPUNV");
DECLARE_HANDLE("HVIDEOINPUTDEVICENV");

ffi.cdef[[
typedef struct _GPU_DEVICE {
    DWORD  cb;
    CHAR   DeviceName[32];
    CHAR   DeviceString[128];
    DWORD  Flags;
    RECT   rcVirtualScreen;
} GPU_DEVICE, *PGPU_DEVICE;
]]


ffi.cdef[[
 HANDLE  wglCreateBufferRegionARB (HDC hDC, int iLayerPlane, UINT uType);
 void  wglDeleteBufferRegionARB (HANDLE hRegion);
 BOOL  wglSaveBufferRegionARB (HANDLE hRegion, int x, int y, int width, int height);
 BOOL  wglRestoreBufferRegionARB (HANDLE hRegion, int x, int y, int width, int height, int xSrc, int ySrc);

typedef HANDLE (* PFNWGLCREATEBUFFERREGIONARBPROC) (HDC hDC, int iLayerPlane, UINT uType);
typedef void (* PFNWGLDELETEBUFFERREGIONARBPROC) (HANDLE hRegion);
typedef BOOL (* PFNWGLSAVEBUFFERREGIONARBPROC) (HANDLE hRegion, int x, int y, int width, int height);
typedef BOOL (* PFNWGLRESTOREBUFFERREGIONARBPROC) (HANDLE hRegion, int x, int y, int width, int height, int xSrc, int ySrc);


// WGL_ARB_extensions_string 1
 const char *  wglGetExtensionsStringARB (HDC hdc);
typedef const char * (* PFNWGLGETEXTENSIONSSTRINGARBPROC) (HDC hdc);

//WGL_ARB_pixel_format 1
 BOOL  wglGetPixelFormatAttribivARB (HDC hdc, int iPixelFormat, int iLayerPlane, UINT nAttributes, const int *piAttributes, int *piValues);
 BOOL  wglGetPixelFormatAttribfvARB (HDC hdc, int iPixelFormat, int iLayerPlane, UINT nAttributes, const int *piAttributes, FLOAT *pfValues);
 BOOL  wglChoosePixelFormatARB (HDC hdc, const int *piAttribIList, const FLOAT *pfAttribFList, UINT nMaxFormats, int *piFormats, UINT *nNumFormats);
typedef BOOL (* PFNWGLGETPIXELFORMATATTRIBIVARBPROC) (HDC hdc, int iPixelFormat, int iLayerPlane, UINT nAttributes, const int *piAttributes, int *piValues);
typedef BOOL (* PFNWGLGETPIXELFORMATATTRIBFVARBPROC) (HDC hdc, int iPixelFormat, int iLayerPlane, UINT nAttributes, const int *piAttributes, FLOAT *pfValues);
typedef BOOL (* PFNWGLCHOOSEPIXELFORMATARBPROC) (HDC hdc, const int *piAttribIList, const FLOAT *pfAttribFList, UINT nMaxFormats, int *piFormats, UINT *nNumFormats);

// WGL_ARB_make_current_read 1
 BOOL  wglMakeContextCurrentARB (HDC hDrawDC, HDC hReadDC, HGLRC hglrc);
 HDC  wglGetCurrentReadDCARB (void);
typedef BOOL (* PFNWGLMAKECONTEXTCURRENTARBPROC) (HDC hDrawDC, HDC hReadDC, HGLRC hglrc);
typedef HDC (* PFNWGLGETCURRENTREADDCARBPROC) (void);

// WGL_ARB_pbuffer 1
 HPBUFFERARB  wglCreatePbufferARB (HDC hDC, int iPixelFormat, int iWidth, int iHeight, const int *piAttribList);
 HDC  wglGetPbufferDCARB (HPBUFFERARB hPbuffer);
 int  wglReleasePbufferDCARB (HPBUFFERARB hPbuffer, HDC hDC);
 BOOL  wglDestroyPbufferARB (HPBUFFERARB hPbuffer);
 BOOL  wglQueryPbufferARB (HPBUFFERARB hPbuffer, int iAttribute, int *piValue);
typedef HPBUFFERARB (* PFNWGLCREATEPBUFFERARBPROC) (HDC hDC, int iPixelFormat, int iWidth, int iHeight, const int *piAttribList);
typedef HDC (* PFNWGLGETPBUFFERDCARBPROC) (HPBUFFERARB hPbuffer);
typedef int (* PFNWGLRELEASEPBUFFERDCARBPROC) (HPBUFFERARB hPbuffer, HDC hDC);
typedef BOOL (* PFNWGLDESTROYPBUFFERARBPROC) (HPBUFFERARB hPbuffer);
typedef BOOL (* PFNWGLQUERYPBUFFERARBPROC) (HPBUFFERARB hPbuffer, int iAttribute, int *piValue);

// WGL_ARB_render_texture 1
 BOOL  wglBindTexImageARB (HPBUFFERARB hPbuffer, int iBuffer);
 BOOL  wglReleaseTexImageARB (HPBUFFERARB hPbuffer, int iBuffer);
 BOOL  wglSetPbufferAttribARB (HPBUFFERARB hPbuffer, const int *piAttribList);
typedef BOOL (* PFNWGLBINDTEXIMAGEARBPROC) (HPBUFFERARB hPbuffer, int iBuffer);
typedef BOOL (* PFNWGLRELEASETEXIMAGEARBPROC) (HPBUFFERARB hPbuffer, int iBuffer);
typedef BOOL (* PFNWGLSETPBUFFERATTRIBARBPROC) (HPBUFFERARB hPbuffer, const int *piAttribList);



// WGL_ARB_create_context 1
 HGLRC  wglCreateContextAttribsARB (HDC hDC, HGLRC hShareContext, const int *attribList);
typedef HGLRC (* PFNWGLCREATECONTEXTATTRIBSARBPROC) (HDC hDC, HGLRC hShareContext, const int *attribList);

// WGL_EXT_display_color_table 1
 GLboolean  wglCreateDisplayColorTableEXT (GLushort id);
 GLboolean  wglLoadDisplayColorTableEXT (const GLushort *table, GLuint length);
 GLboolean  wglBindDisplayColorTableEXT (GLushort id);
 void  wglDestroyDisplayColorTableEXT (GLushort id);
typedef GLboolean (* PFNWGLCREATEDISPLAYCOLORTABLEEXTPROC) (GLushort id);
typedef GLboolean (* PFNWGLLOADDISPLAYCOLORTABLEEXTPROC) (const GLushort *table, GLuint length);
typedef GLboolean (* PFNWGLBINDDISPLAYCOLORTABLEEXTPROC) (GLushort id);
typedef void (* PFNWGLDESTROYDISPLAYCOLORTABLEEXTPROC) (GLushort id);

// WGL_EXT_extensions_string 1
 const char *  wglGetExtensionsStringEXT (void);
typedef const char * (* PFNWGLGETEXTENSIONSSTRINGEXTPROC) (void);

// WGL_EXT_make_current_read 1
 BOOL  wglMakeContextCurrentEXT (HDC hDrawDC, HDC hReadDC, HGLRC hglrc);
 HDC  wglGetCurrentReadDCEXT (void);
typedef BOOL (* PFNWGLMAKECONTEXTCURRENTEXTPROC) (HDC hDrawDC, HDC hReadDC, HGLRC hglrc);
typedef HDC (* PFNWGLGETCURRENTREADDCEXTPROC) (void);

// WGL_EXT_pbuffer 1
 HPBUFFEREXT  wglCreatePbufferEXT (HDC hDC, int iPixelFormat, int iWidth, int iHeight, const int *piAttribList);
 HDC  wglGetPbufferDCEXT (HPBUFFEREXT hPbuffer);
 int  wglReleasePbufferDCEXT (HPBUFFEREXT hPbuffer, HDC hDC);
 BOOL  wglDestroyPbufferEXT (HPBUFFEREXT hPbuffer);
 BOOL  wglQueryPbufferEXT (HPBUFFEREXT hPbuffer, int iAttribute, int *piValue);
typedef HPBUFFEREXT (* PFNWGLCREATEPBUFFEREXTPROC) (HDC hDC, int iPixelFormat, int iWidth, int iHeight, const int *piAttribList);
typedef HDC (* PFNWGLGETPBUFFERDCEXTPROC) (HPBUFFEREXT hPbuffer);
typedef int (* PFNWGLRELEASEPBUFFERDCEXTPROC) (HPBUFFEREXT hPbuffer, HDC hDC);
typedef BOOL (* PFNWGLDESTROYPBUFFEREXTPROC) (HPBUFFEREXT hPbuffer);
typedef BOOL (* PFNWGLQUERYPBUFFEREXTPROC) (HPBUFFEREXT hPbuffer, int iAttribute, int *piValue);

// WGL_EXT_pixel_format 1
 BOOL  wglGetPixelFormatAttribivEXT (HDC hdc, int iPixelFormat, int iLayerPlane, UINT nAttributes, int *piAttributes, int *piValues);
 BOOL  wglGetPixelFormatAttribfvEXT (HDC hdc, int iPixelFormat, int iLayerPlane, UINT nAttributes, int *piAttributes, FLOAT *pfValues);
 BOOL  wglChoosePixelFormatEXT (HDC hdc, const int *piAttribIList, const FLOAT *pfAttribFList, UINT nMaxFormats, int *piFormats, UINT *nNumFormats);
typedef BOOL (* PFNWGLGETPIXELFORMATATTRIBIVEXTPROC) (HDC hdc, int iPixelFormat, int iLayerPlane, UINT nAttributes, int *piAttributes, int *piValues);
typedef BOOL (* PFNWGLGETPIXELFORMATATTRIBFVEXTPROC) (HDC hdc, int iPixelFormat, int iLayerPlane, UINT nAttributes, int *piAttributes, FLOAT *pfValues);
typedef BOOL (* PFNWGLCHOOSEPIXELFORMATEXTPROC) (HDC hdc, const int *piAttribIList, const FLOAT *pfAttribFList, UINT nMaxFormats, int *piFormats, UINT *nNumFormats);

// WGL_EXT_swap_control 1
 BOOL  wglSwapIntervalEXT (int interval);
 int  wglGetSwapIntervalEXT (void);
typedef BOOL (* PFNWGLSWAPINTERVALEXTPROC) (int interval);
typedef int (* PFNWGLGETSWAPINTERVALEXTPROC) (void);


// WGL_NV_vertex_array_range 1
 void*  wglAllocateMemoryNV (GLsizei size, GLfloat readfreq, GLfloat writefreq, GLfloat priority);
 void  wglFreeMemoryNV (void *pointer);
typedef void* (* PFNWGLALLOCATEMEMORYNVPROC) (GLsizei size, GLfloat readfreq, GLfloat writefreq, GLfloat priority);
typedef void (* PFNWGLFREEMEMORYNVPROC) (void *pointer);


// WGL_OML_sync_control 1
 BOOL  wglGetSyncValuesOML (HDC hdc, INT64 *ust, INT64 *msc, INT64 *sbc);
 BOOL  wglGetMscRateOML (HDC hdc, INT32 *numerator, INT32 *denominator);
 INT64  wglSwapBuffersMscOML (HDC hdc, INT64 target_msc, INT64 divisor, INT64 remainder);
 INT64  wglSwapLayerBuffersMscOML (HDC hdc, int fuPlanes, INT64 target_msc, INT64 divisor, INT64 remainder);
 BOOL  wglWaitForMscOML (HDC hdc, INT64 target_msc, INT64 divisor, INT64 remainder, INT64 *ust, INT64 *msc, INT64 *sbc);
 BOOL  wglWaitForSbcOML (HDC hdc, INT64 target_sbc, INT64 *ust, INT64 *msc, INT64 *sbc);
typedef BOOL (* PFNWGLGETSYNCVALUESOMLPROC) (HDC hdc, INT64 *ust, INT64 *msc, INT64 *sbc);
typedef BOOL (* PFNWGLGETMSCRATEOMLPROC) (HDC hdc, INT32 *numerator, INT32 *denominator);
typedef INT64 (* PFNWGLSWAPBUFFERSMSCOMLPROC) (HDC hdc, INT64 target_msc, INT64 divisor, INT64 remainder);
typedef INT64 (* PFNWGLSWAPLAYERBUFFERSMSCOMLPROC) (HDC hdc, int fuPlanes, INT64 target_msc, INT64 divisor, INT64 remainder);
typedef BOOL (* PFNWGLWAITFORMSCOMLPROC) (HDC hdc, INT64 target_msc, INT64 divisor, INT64 remainder, INT64 *ust, INT64 *msc, INT64 *sbc);
typedef BOOL (* PFNWGLWAITFORSBCOMLPROC) (HDC hdc, INT64 target_sbc, INT64 *ust, INT64 *msc, INT64 *sbc);

// WGL_I3D_digital_video_control 1
 BOOL  wglGetDigitalVideoParametersI3D (HDC hDC, int iAttribute, int *piValue);
 BOOL  wglSetDigitalVideoParametersI3D (HDC hDC, int iAttribute, const int *piValue);
typedef BOOL (* PFNWGLGETDIGITALVIDEOPARAMETERSI3DPROC) (HDC hDC, int iAttribute, int *piValue);
typedef BOOL (* PFNWGLSETDIGITALVIDEOPARAMETERSI3DPROC) (HDC hDC, int iAttribute, const int *piValue);

// WGL_I3D_gamma 1
 BOOL  wglGetGammaTableParametersI3D (HDC hDC, int iAttribute, int *piValue);
 BOOL  wglSetGammaTableParametersI3D (HDC hDC, int iAttribute, const int *piValue);
 BOOL  wglGetGammaTableI3D (HDC hDC, int iEntries, USHORT *puRed, USHORT *puGreen, USHORT *puBlue);
 BOOL  wglSetGammaTableI3D (HDC hDC, int iEntries, const USHORT *puRed, const USHORT *puGreen, const USHORT *puBlue);
typedef BOOL (* PFNWGLGETGAMMATABLEPARAMETERSI3DPROC) (HDC hDC, int iAttribute, int *piValue);
typedef BOOL (* PFNWGLSETGAMMATABLEPARAMETERSI3DPROC) (HDC hDC, int iAttribute, const int *piValue);
typedef BOOL (* PFNWGLGETGAMMATABLEI3DPROC) (HDC hDC, int iEntries, USHORT *puRed, USHORT *puGreen, USHORT *puBlue);
typedef BOOL (* PFNWGLSETGAMMATABLEI3DPROC) (HDC hDC, int iEntries, const USHORT *puRed, const USHORT *puGreen, const USHORT *puBlue);

// WGL_I3D_genlock 1
 BOOL  wglEnableGenlockI3D (HDC hDC);
 BOOL  wglDisableGenlockI3D (HDC hDC);
 BOOL  wglIsEnabledGenlockI3D (HDC hDC, BOOL *pFlag);
 BOOL  wglGenlockSourceI3D (HDC hDC, UINT uSource);
 BOOL  wglGetGenlockSourceI3D (HDC hDC, UINT *uSource);
 BOOL  wglGenlockSourceEdgeI3D (HDC hDC, UINT uEdge);
 BOOL  wglGetGenlockSourceEdgeI3D (HDC hDC, UINT *uEdge);
 BOOL  wglGenlockSampleRateI3D (HDC hDC, UINT uRate);
 BOOL  wglGetGenlockSampleRateI3D (HDC hDC, UINT *uRate);
 BOOL  wglGenlockSourceDelayI3D (HDC hDC, UINT uDelay);
 BOOL  wglGetGenlockSourceDelayI3D (HDC hDC, UINT *uDelay);
 BOOL  wglQueryGenlockMaxSourceDelayI3D (HDC hDC, UINT *uMaxLineDelay, UINT *uMaxPixelDelay);
typedef BOOL (* PFNWGLENABLEGENLOCKI3DPROC) (HDC hDC);
typedef BOOL (* PFNWGLDISABLEGENLOCKI3DPROC) (HDC hDC);
typedef BOOL (* PFNWGLISENABLEDGENLOCKI3DPROC) (HDC hDC, BOOL *pFlag);
typedef BOOL (* PFNWGLGENLOCKSOURCEI3DPROC) (HDC hDC, UINT uSource);
typedef BOOL (* PFNWGLGETGENLOCKSOURCEI3DPROC) (HDC hDC, UINT *uSource);
typedef BOOL (* PFNWGLGENLOCKSOURCEEDGEI3DPROC) (HDC hDC, UINT uEdge);
typedef BOOL (* PFNWGLGETGENLOCKSOURCEEDGEI3DPROC) (HDC hDC, UINT *uEdge);
typedef BOOL (* PFNWGLGENLOCKSAMPLERATEI3DPROC) (HDC hDC, UINT uRate);
typedef BOOL (* PFNWGLGETGENLOCKSAMPLERATEI3DPROC) (HDC hDC, UINT *uRate);
typedef BOOL (* PFNWGLGENLOCKSOURCEDELAYI3DPROC) (HDC hDC, UINT uDelay);
typedef BOOL (* PFNWGLGETGENLOCKSOURCEDELAYI3DPROC) (HDC hDC, UINT *uDelay);
typedef BOOL (* PFNWGLQUERYGENLOCKMAXSOURCEDELAYI3DPROC) (HDC hDC, UINT *uMaxLineDelay, UINT *uMaxPixelDelay);

// WGL_I3D_image_buffer 1
 LPVOID  wglCreateImageBufferI3D (HDC hDC, DWORD dwSize, UINT uFlags);
 BOOL  wglDestroyImageBufferI3D (HDC hDC, LPVOID pAddress);
 BOOL  wglAssociateImageBufferEventsI3D (HDC hDC, const HANDLE *pEvent, const LPVOID *pAddress, const DWORD *pSize, UINT count);
 BOOL  wglReleaseImageBufferEventsI3D (HDC hDC, const LPVOID *pAddress, UINT count);
typedef LPVOID (* PFNWGLCREATEIMAGEBUFFERI3DPROC) (HDC hDC, DWORD dwSize, UINT uFlags);
typedef BOOL (* PFNWGLDESTROYIMAGEBUFFERI3DPROC) (HDC hDC, LPVOID pAddress);
typedef BOOL (* PFNWGLASSOCIATEIMAGEBUFFEREVENTSI3DPROC) (HDC hDC, const HANDLE *pEvent, const LPVOID *pAddress, const DWORD *pSize, UINT count);
typedef BOOL (* PFNWGLRELEASEIMAGEBUFFEREVENTSI3DPROC) (HDC hDC, const LPVOID *pAddress, UINT count);

// WGL_I3D_swap_frame_lock 1
 BOOL  wglEnableFrameLockI3D (void);
 BOOL  wglDisableFrameLockI3D (void);
 BOOL  wglIsEnabledFrameLockI3D (BOOL *pFlag);
 BOOL  wglQueryFrameLockMasterI3D (BOOL *pFlag);
typedef BOOL (* PFNWGLENABLEFRAMELOCKI3DPROC) (void);
typedef BOOL (* PFNWGLDISABLEFRAMELOCKI3DPROC) (void);
typedef BOOL (* PFNWGLISENABLEDFRAMELOCKI3DPROC) (BOOL *pFlag);
typedef BOOL (* PFNWGLQUERYFRAMELOCKMASTERI3DPROC) (BOOL *pFlag);

// WGL_I3D_swap_frame_usage 1
 BOOL  wglGetFrameUsageI3D (float *pUsage);
 BOOL  wglBeginFrameTrackingI3D (void);
 BOOL  wglEndFrameTrackingI3D (void);
 BOOL  wglQueryFrameTrackingI3D (DWORD *pFrameCount, DWORD *pMissedFrames, float *pLastMissedUsage);
typedef BOOL (* PFNWGLGETFRAMEUSAGEI3DPROC) (float *pUsage);
typedef BOOL (* PFNWGLBEGINFRAMETRACKINGI3DPROC) (void);
typedef BOOL (* PFNWGLENDFRAMETRACKINGI3DPROC) (void);
typedef BOOL (* PFNWGLQUERYFRAMETRACKINGI3DPROC) (DWORD *pFrameCount, DWORD *pMissedFrames, float *pLastMissedUsage);


// WGL_3DL_stereo_control 1
 BOOL  wglSetStereoEmitterState3DL (HDC hDC, UINT uState);
typedef BOOL (* PFNWGLSETSTEREOEMITTERSTATE3DLPROC) (HDC hDC, UINT uState);



// WGL_NV_present_video 1
 int  wglEnumerateVideoDevicesNV (HDC hDC, HVIDEOOUTPUTDEVICENV *phDeviceList);
 BOOL  wglBindVideoDeviceNV (HDC hDC, unsigned int uVideoSlot, HVIDEOOUTPUTDEVICENV hVideoDevice, const int *piAttribList);
 BOOL  wglQueryCurrentContextNV (int iAttribute, int *piValue);
typedef int (* PFNWGLENUMERATEVIDEODEVICESNVPROC) (HDC hDC, HVIDEOOUTPUTDEVICENV *phDeviceList);
typedef BOOL (* PFNWGLBINDVIDEODEVICENVPROC) (HDC hDC, unsigned int uVideoSlot, HVIDEOOUTPUTDEVICENV hVideoDevice, const int *piAttribList);
typedef BOOL (* PFNWGLQUERYCURRENTCONTEXTNVPROC) (int iAttribute, int *piValue);

// WGL_NV_video_output 1
 BOOL  wglGetVideoDeviceNV (HDC hDC, int numDevices, HPVIDEODEV *hVideoDevice);
 BOOL  wglReleaseVideoDeviceNV (HPVIDEODEV hVideoDevice);
 BOOL  wglBindVideoImageNV (HPVIDEODEV hVideoDevice, HPBUFFERARB hPbuffer, int iVideoBuffer);
 BOOL  wglReleaseVideoImageNV (HPBUFFERARB hPbuffer, int iVideoBuffer);
 BOOL  wglSendPbufferToVideoNV (HPBUFFERARB hPbuffer, int iBufferType, unsigned long *pulCounterPbuffer, BOOL bBlock);
 BOOL  wglGetVideoInfoNV (HPVIDEODEV hpVideoDevice, unsigned long *pulCounterOutputPbuffer, unsigned long *pulCounterOutputVideo);
typedef BOOL (* PFNWGLGETVIDEODEVICENVPROC) (HDC hDC, int numDevices, HPVIDEODEV *hVideoDevice);
typedef BOOL (* PFNWGLRELEASEVIDEODEVICENVPROC) (HPVIDEODEV hVideoDevice);
typedef BOOL (* PFNWGLBINDVIDEOIMAGENVPROC) (HPVIDEODEV hVideoDevice, HPBUFFERARB hPbuffer, int iVideoBuffer);
typedef BOOL (* PFNWGLRELEASEVIDEOIMAGENVPROC) (HPBUFFERARB hPbuffer, int iVideoBuffer);
typedef BOOL (* PFNWGLSENDPBUFFERTOVIDEONVPROC) (HPBUFFERARB hPbuffer, int iBufferType, unsigned long *pulCounterPbuffer, BOOL bBlock);
typedef BOOL (* PFNWGLGETVIDEOINFONVPROC) (HPVIDEODEV hpVideoDevice, unsigned long *pulCounterOutputPbuffer, unsigned long *pulCounterOutputVideo);

// WGL_NV_swap_group 1
 BOOL  wglJoinSwapGroupNV (HDC hDC, GLuint group);
 BOOL  wglBindSwapBarrierNV (GLuint group, GLuint barrier);
 BOOL  wglQuerySwapGroupNV (HDC hDC, GLuint *group, GLuint *barrier);
 BOOL  wglQueryMaxSwapGroupsNV (HDC hDC, GLuint *maxGroups, GLuint *maxBarriers);
 BOOL  wglQueryFrameCountNV (HDC hDC, GLuint *count);
 BOOL  wglResetFrameCountNV (HDC hDC);
typedef BOOL (* PFNWGLJOINSWAPGROUPNVPROC) (HDC hDC, GLuint group);
typedef BOOL (* PFNWGLBINDSWAPBARRIERNVPROC) (GLuint group, GLuint barrier);
typedef BOOL (* PFNWGLQUERYSWAPGROUPNVPROC) (HDC hDC, GLuint *group, GLuint *barrier);
typedef BOOL (* PFNWGLQUERYMAXSWAPGROUPSNVPROC) (HDC hDC, GLuint *maxGroups, GLuint *maxBarriers);
typedef BOOL (* PFNWGLQUERYFRAMECOUNTNVPROC) (HDC hDC, GLuint *count);
typedef BOOL (* PFNWGLRESETFRAMECOUNTNVPROC) (HDC hDC);

// WGL_NV_gpu_affinity 1
 BOOL  wglEnumGpusNV (UINT iGpuIndex, HGPUNV *phGpu);
 BOOL  wglEnumGpuDevicesNV (HGPUNV hGpu, UINT iDeviceIndex, PGPU_DEVICE lpGpuDevice);
 HDC  wglCreateAffinityDCNV (const HGPUNV *phGpuList);
 BOOL  wglEnumGpusFromAffinityDCNV (HDC hAffinityDC, UINT iGpuIndex, HGPUNV *hGpu);
 BOOL  wglDeleteDCNV (HDC hdc);
typedef BOOL (* PFNWGLENUMGPUSNVPROC) (UINT iGpuIndex, HGPUNV *phGpu);
typedef BOOL (* PFNWGLENUMGPUDEVICESNVPROC) (HGPUNV hGpu, UINT iDeviceIndex, PGPU_DEVICE lpGpuDevice);
typedef HDC (* PFNWGLCREATEAFFINITYDCNVPROC) (const HGPUNV *phGpuList);
typedef BOOL (* PFNWGLENUMGPUSFROMAFFINITYDCNVPROC) (HDC hAffinityDC, UINT iGpuIndex, HGPUNV *hGpu);
typedef BOOL (* PFNWGLDELETEDCNVPROC) (HDC hdc);

// WGL_AMD_gpu_association 1
 UINT  wglGetGPUIDsAMD (UINT maxCount, UINT *ids);
 INT  wglGetGPUInfoAMD (UINT id, int property, GLenum dataType, UINT size, void *data);
 UINT  wglGetContextGPUIDAMD (HGLRC hglrc);
 HGLRC  wglCreateAssociatedContextAMD (UINT id);
 HGLRC  wglCreateAssociatedContextAttribsAMD (UINT id, HGLRC hShareContext, const int *attribList);
 BOOL  wglDeleteAssociatedContextAMD (HGLRC hglrc);
 BOOL  wglMakeAssociatedContextCurrentAMD (HGLRC hglrc);
 HGLRC  wglGetCurrentAssociatedContextAMD (void);
 void  wglBlitContextFramebufferAMD (HGLRC dstCtx, GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);
typedef UINT (* PFNWGLGETGPUIDSAMDPROC) (UINT maxCount, UINT *ids);
typedef INT (* PFNWGLGETGPUINFOAMDPROC) (UINT id, int property, GLenum dataType, UINT size, void *data);
typedef UINT (* PFNWGLGETCONTEXTGPUIDAMDPROC) (HGLRC hglrc);
typedef HGLRC (* PFNWGLCREATEASSOCIATEDCONTEXTAMDPROC) (UINT id);
typedef HGLRC (* PFNWGLCREATEASSOCIATEDCONTEXTATTRIBSAMDPROC) (UINT id, HGLRC hShareContext, const int *attribList);
typedef BOOL (* PFNWGLDELETEASSOCIATEDCONTEXTAMDPROC) (HGLRC hglrc);
typedef BOOL (* PFNWGLMAKEASSOCIATEDCONTEXTCURRENTAMDPROC) (HGLRC hglrc);
typedef HGLRC (* PFNWGLGETCURRENTASSOCIATEDCONTEXTAMDPROC) (void);
typedef void (* PFNWGLBLITCONTEXTFRAMEBUFFERAMDPROC) (HGLRC dstCtx, GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);

// WGL_NV_video_capture 1
 BOOL  wglBindVideoCaptureDeviceNV (UINT uVideoSlot, HVIDEOINPUTDEVICENV hDevice);
 UINT  wglEnumerateVideoCaptureDevicesNV (HDC hDc, HVIDEOINPUTDEVICENV *phDeviceList);
 BOOL  wglLockVideoCaptureDeviceNV (HDC hDc, HVIDEOINPUTDEVICENV hDevice);
 BOOL  wglQueryVideoCaptureDeviceNV (HDC hDc, HVIDEOINPUTDEVICENV hDevice, int iAttribute, int *piValue);
 BOOL  wglReleaseVideoCaptureDeviceNV (HDC hDc, HVIDEOINPUTDEVICENV hDevice);
typedef BOOL (* PFNWGLBINDVIDEOCAPTUREDEVICENVPROC) (UINT uVideoSlot, HVIDEOINPUTDEVICENV hDevice);
typedef UINT (* PFNWGLENUMERATEVIDEOCAPTUREDEVICESNVPROC) (HDC hDc, HVIDEOINPUTDEVICENV *phDeviceList);
typedef BOOL (* PFNWGLLOCKVIDEOCAPTUREDEVICENVPROC) (HDC hDc, HVIDEOINPUTDEVICENV hDevice);
typedef BOOL (* PFNWGLQUERYVIDEOCAPTUREDEVICENVPROC) (HDC hDc, HVIDEOINPUTDEVICENV hDevice, int iAttribute, int *piValue);
typedef BOOL (* PFNWGLRELEASEVIDEOCAPTUREDEVICENVPROC) (HDC hDc, HVIDEOINPUTDEVICENV hDevice);

// WGL_NV_copy_image 1
 BOOL  wglCopyImageSubDataNV (HGLRC hSrcRC, GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, HGLRC hDstRC, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei width, GLsizei height, GLsizei depth);
typedef BOOL (* PFNWGLCOPYIMAGESUBDATANVPROC) (HGLRC hSrcRC, GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, HGLRC hDstRC, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei width, GLsizei height, GLsizei depth);


// WGL_NV_DX_interop 1
 BOOL  wglDXSetResourceShareHandleNV (void *dxObject, HANDLE shareHandle);
 HANDLE  wglDXOpenDeviceNV (void *dxDevice);
 BOOL  wglDXCloseDeviceNV (HANDLE hDevice);
 HANDLE  wglDXRegisterObjectNV (HANDLE hDevice, void *dxObject, GLuint name, GLenum type, GLenum access);
 BOOL  wglDXUnregisterObjectNV (HANDLE hDevice, HANDLE hObject);
 BOOL  wglDXObjectAccessNV (HANDLE hObject, GLenum access);
 BOOL  wglDXLockObjectsNV (HANDLE hDevice, GLint count, HANDLE *hObjects);
 BOOL  wglDXUnlockObjectsNV (HANDLE hDevice, GLint count, HANDLE *hObjects);
typedef BOOL (* PFNWGLDXSETRESOURCESHAREHANDLENVPROC) (void *dxObject, HANDLE shareHandle);
typedef HANDLE (* PFNWGLDXOPENDEVICENVPROC) (void *dxDevice);
typedef BOOL (* PFNWGLDXCLOSEDEVICENVPROC) (HANDLE hDevice);
typedef HANDLE (* PFNWGLDXREGISTEROBJECTNVPROC) (HANDLE hDevice, void *dxObject, GLuint name, GLenum type, GLenum access);
typedef BOOL (* PFNWGLDXUNREGISTEROBJECTNVPROC) (HANDLE hDevice, HANDLE hObject);
typedef BOOL (* PFNWGLDXOBJECTACCESSNVPROC) (HANDLE hObject, GLenum access);
typedef BOOL (* PFNWGLDXLOCKOBJECTSNVPROC) (HANDLE hDevice, GLint count, HANDLE *hObjects);
typedef BOOL (* PFNWGLDXUNLOCKOBJECTSNVPROC) (HANDLE hDevice, GLint count, HANDLE *hObjects);
]]

-- Definitions for Wgl (Windows GL)
ffi.cdef[[
	// Callback functions

	typedef int (__attribute__((__stdcall__)) *PROC)();

	BOOL wglCopyContext(HGLRC hglrcSrc, HGLRC hglrcDst, UINT  mask);

	HGLRC wglCreateContext(HDC hdc);

	HGLRC wglCreateLayerContext(HDC hdc, int  iLayerPlane);

	BOOL wglDeleteContext(HGLRC  hglrc);

//	BOOL wglDescribeLayerPlane(HDC hdc,int  iPixelFormat, int  iLayerPlane, UINT  nBytes, LPLAYERPLANEDESCRIPTOR plpd);
	BOOL wglDescribeLayerPlane(HDC hdc,int  iPixelFormat, int  iLayerPlane, UINT  nBytes, void * plpd);

	HGLRC wglGetCurrentContext(void);

	HDC wglGetCurrentDC(void);

	int wglGetLayerPaletteEntries(HDC  hdc, int  iLayerPlane, int  iStart,int  cEntries, const COLORREF *pcr);

	PROC wglGetProcAddress(LPCSTR lpszProc);

	BOOL wglMakeCurrent(HDC hdc, HGLRC  hglrc);

	BOOL wglRealizeLayerPalette(HDC hdc, int iLayerPlane, BOOL bRealize);

	int wglSetLayerPaletteEntries(HDC  hdc, int iLayerPlane,int  iStart,int  cEntries, const COLORREF *pcr);

	BOOL wglShareLists(HGLRC  hglrc1, HGLRC  hglrc2);

	BOOL wglSwapLayerBuffers(HDC hdc, UINT  fuPlanes);

	BOOL wglUseFontBitmapsA(HDC  hdc, DWORD  first, DWORD  count, DWORD listBase);
	BOOL wglUseFontBitmapsW(HDC  hdc, DWORD  first, DWORD  count, DWORD listBase);

	BOOL wglUseFontOutlinesA(HDC  hdc,DWORD  first, DWORD  count, DWORD  listBase,  FLOAT  deviation, FLOAT  extrusion,int  format, void *  lpgmf);
//	BOOL wglUseFontOutlinesA(HDC  hdc,DWORD  first, DWORD  count, DWORD  listBase,  FLOAT  deviation, FLOAT  extrusion,int  format, LPGLYPHMETRICSFLOAT  lpgmf);
//	BOOL wglUseFontOutlinesW(HDC  hdc,DWORD  first, DWORD  count, DWORD  listBase,  FLOAT  deviation, FLOAT  extrusion,int  format, LPGLYPHMETRICSFLOAT  lpgmf);

	// Extension functions
	// WGL_ARB_extensions_string
	typedef const char * (* PFNWGLGETEXTENSIONSSTRINGARBPROC)(HDC);

	const char *wglGetExtensionsStringARB(HDC);


]]
