local ffi = require "ffi"
local C = ffi.C
local bit = require "bit"
local lshift = bit.lshift
local rshift = bit.rshift

local band = bit.band	-- &
local bor = bit.bor	-- |
local bnot = bit.bnot	-- ~

require "WTypes"

ffi.cdef[[
/* pixel types */
enum PFDPixelType
{
	PFD_TYPE_RGBA = 0,
	ColorIndex = 1
}

    /* layer types */
enum PFDLayerPlanes
{
    PFD_MAIN_PLANE = 0,
    Overlay = 1,
    Underlay = (-1)
}


/* PIXELFORMATDESCRIPTOR flags */
enum PFDFlags {
	PFD_DOUBLEBUFFER = 0x00000001,
    Stereo = 0x00000002,
	PFD_DRAW_TO_WINDOW = 0x00000004,
	DrawToBitmap = 0x00000008,
	SupportGDI = 0x00000010,
	PFD_SUPPORT_OPENGL = 0x00000020,
	GenericFormat = 0x00000040,
	NeedPalette = 0x00000080,
	NeedSystemPalette = 0x00000100,
	SwapExchange = 0x00000200,
	SwapCopy = 0x00000400,
	SwapLayerBuffers = 0x00000800,
	GenericAccelerated = 0x00001000,
	SupportDirectDraw = 0x00002000,
	Direct3DAccelerated = 0x00004000,
	SupportComposition = 0x00008000,
};

    /* PIXELFORMATDESCRIPTOR flags for use in ChoosePixelFormat only */
enum ChoosePixelFlags {
        PFD_DEPTH_DONTCARE = 0x20000000,
        PFD_DOUBLEBUFFER_DONTCARE = 0x40000000,
        PFD_STEREO_DONTCARE = 0x80000000,
};

enum {
	SRCCOPY		= 0x00CC0020,
	SRCPAINT	= 0x00EE0086,
	SRCERASE	= 0x00440328,
	BLACKNESS	= 0x00000042,
	WHITENESS	= 0x00FF0062,
};

enum StockObjectIndex {
	WHITE_BRUSH        = 0,
	LTGRAY_BRUSH        = 1,
	GRAY_BRUSH          = 2,
	DKGRAY_BRUSH        = 3,
	BLACK_BRUSH         = 4,
	NULL_BRUSH          = 5,
	//HOLLOW_BRUSH        = NULL_BRUSH,
	WHITE_PEN           = 6,
	BLACK_PEN           = 7,
	NULL_PEN            = 8,
	OEM_FIXED_FONT      = 10,
	ANSI_FIXED_FONT     = 11,
	ANSI_VAR_FONT       = 12,
	SYSTEM_FONT         = 13,
	DEVICE_DEFAULT_FONT = 14,
	DEFAULT_PALETTE     = 15,
	SYSTEM_FIXED_FONT   = 16,
	DEFAULT_GUI_FONT    = 17,
	DC_BRUSH            = 18,
	DC_PEN              = 19,
};

]]


-- GDI32
ffi.cdef[[
typedef struct {
	HDC		Handle;
} DeviceContext;


typedef struct {
	void * Handle;
	BITMAP	Bitmap;
	unsigned char * Pixels;
} GDIBitmap;

typedef struct {
	void	*Handle;
	DeviceContext	hDC;
	int		Width;
	int		Height;
	int		BitsPerPixel;
	char * Pixels;
	BITMAPINFO	Info;
} GDIDIBSection;

typedef struct _POINTFLOAT {
  FLOAT  x;
  FLOAT  y;
} POINTFLOAT;

typedef struct _GLYPHMETRICSFLOAT {
  FLOAT      gmfBlackBoxX;
  FLOAT      gmfBlackBoxY;
  POINTFLOAT gmfptGlyphOrigin;
  FLOAT      gmfCellIncX;
  FLOAT      gmfCellIncY;
} GLYPHMETRICSFLOAT, *LPGLYPHMETRICSFLOAT;

typedef struct tagPIXELFORMATDESCRIPTOR {
  WORD  nSize;
  WORD  nVersion;
  DWORD dwFlags;
  BYTE  iPixelType;
  BYTE  cColorBits;
  BYTE  cRedBits;
  BYTE  cRedShift;
  BYTE  cGreenBits;
  BYTE  cGreenShift;
  BYTE  cBlueBits;
  BYTE  cBlueShift;
  BYTE  cAlphaBits;
  BYTE  cAlphaShift;
  BYTE  cAccumBits;
  BYTE  cAccumRedBits;
  BYTE  cAccumGreenBits;
  BYTE  cAccumBlueBits;
  BYTE  cAccumAlphaBits;
  BYTE  cDepthBits;
  BYTE  cStencilBits;
  BYTE  cAuxBuffers;
  BYTE  iLayerType;
  BYTE  bReserved;
  DWORD dwLayerMask;
  DWORD dwVisibleMask;
  DWORD dwDamageMask;
} PIXELFORMATDESCRIPTOR;


typedef struct tagLAYERPLANEDESCRIPTOR {
  WORD  nSize;
  WORD  nVersion;
  DWORD dwFlags;
  BYTE  iPixelType;
  BYTE  cColorBits;
  BYTE  cRedBits;
  BYTE  cRedShift;
  BYTE  cGreenBits;
  BYTE  cGreenShift;
  BYTE  cBlueBits;
  BYTE  cBlueShift;
  BYTE  cAlphaBits;
  BYTE  cAlphaShift;
  BYTE  cAccumBits;
  BYTE  cAccumRedBits;
  BYTE  cAccumGreenBits;
  BYTE  cAccumBlueBits;
  BYTE  cAccumAlphaBits;
  BYTE  cDepthBits;
  BYTE  cStencilBits;
  BYTE  cAuxBuffers;
  BYTE  iLayerPlane;
  BYTE  bReserved;
  COLORREF crTransparent;
} LAYERPLANEDESCRIPTOR, *LPLAYERPLANEDESCRIPTOR;

]]


ffi.cdef[[



// For OpenGL
typedef int  (* PFNCHOOSEPIXELFORMAT)(HDC  hdc, const PIXELFORMATDESCRIPTOR *  ppfd);
typedef int  (* PFNDESCRIBEPIXELFORMAT)(HDC hdc, int iPixelFormat, unsigned int nBytes, PIXELFORMATDESCRIPTOR *  ppfd);
typedef BOOL (* PFNSETPIXELFORMAT)(HDC hdc, int  iPixelFormat, const PIXELFORMATDESCRIPTOR *  ppfd);
typedef int  (* PFNSWAPBUFFERS)(HDC hdc);


int ChoosePixelFormat(HDC  hdc, const PIXELFORMATDESCRIPTOR *  ppfd);
int DescribePixelFormat(HDC hdc, int iPixelFormat, unsigned int nBytes, PIXELFORMATDESCRIPTOR *  ppfd);
BOOL SetPixelFormat(HDC hdc, int  iPixelFormat, const PIXELFORMATDESCRIPTOR *  ppfd);
int SwapBuffers(HDC hdc);


HDC CreateDCA(LPCSTR lpszDriver,LPCSTR lpszDevice,LPCSTR lpszOutput,const void * lpInitData);
HDC CreateCompatibleDC(HDC hdc);
HDC GetDC(HWND hWnd);

int SaveDC(void *hdc);
bool RestoreDC(void *hdc, int nSavedDC);

COLORREF SetDCPenColor(HDC hdc, COLORREF crColor);
COLORREF SetDCBrushColor(HDC hdc, COLORREF crColor);

HGDIOBJ SelectObject(HDC hdc, HGDIOBJ hgdiobj);
int GetObjectA(HGDIOBJ hgdiobj, int cbBuffer, LPVOID lpvObject);
HGDIOBJ GetStockObject(int fnObject);

bool GdiFlush();

// Drawing
uint32_t SetPixel(HDC hdc, int x, int y, uint32_t color);
BOOL SetPixelV(HDC hdc, int X, int Y, uint32_t crColor);

int MoveToEx(HDC hdc, int X, int Y, void *lpPoint);

int LineTo(HDC hdc, int nXEnd, int nYEnd);

bool Rectangle(HDC hdc, int left, int top, int right, int bottom);

bool RoundRect(HDC hdc, int left, int top, int right, int bottom,
	int width, int height);


BOOL Ellipse(HDC hdc,
  int nLeftRect,
  int nTopRect,
  int nRightRect,
  int nBottomRect);



int GetDIBits(HDC hdc,
	HBITMAP hbmp,
	UINT uStartScan,
	UINT cScanLines,
	LPVOID lpvBits,
	PBITMAPINFO lpbi,
	UINT uUsage);

BOOL BitBlt(  HDC hdcDest,
  int nXDest,
  int nYDest,
  int nWidth,
  int nHeight,
  HDC hdcSrc,
  int nXSrc,
  int nYSrc,
  DWORD dwRop);

int StretchDIBits(HDC hdc,
  int XDest,
  int YDest,
  int nDestWidth,
  int nDestHeight,
  int XSrc,
  int YSrc,
  int nSrcWidth,
  int nSrcHeight,
  const void *lpBits,
  const BITMAPINFO *lpBitsInfo,
  UINT iUsage,
  DWORD dwRop);

  // Text
  BOOL TextOutA(HDC hdc, int nXStart, int nYStart, LPCSTR lpString, int cbString);

HBITMAP CreateCompatibleBitmap(HDC hdc,
  int nWidth,
  int nHeight);

HBITMAP CreateDIBSection(HDC hdc,
  const BITMAPINFO *pbmi,
  UINT iUsage,
  void **ppvBits,
  HANDLE hSection,
  DWORD dwOffset);
]]





-- For Color
-- 0x00bbggrr
function RGB(byRed, byGreen, byBlue)
	local acolor = lshift(byBlue,16) + lshift(byGreen,8) + byRed;
	return acolor;
end

function GetRValue(c)
	return band(c, 0xff)
end

function GetGValue(c)
	return band(rshift(c,8), 0xff)
end

function GetBValue(c)
	return band(rshift(c,16), 0xff)
end

--
-- This function answers the question:
-- Given:
--		We know the size of the byte boundary we want
--		to align to.
-- Question:
--		How many bytes need to be allocated to ensure we
--		will align to that boundary.
-- Discussion:
--		This comes up in cases where you're allocating a bitmap image
--		for example.  It may be a 24-bit image, but you need to ensure
--		that each row can align to a 32-bit boundary.  So, we need to
--		essentially scale up the number of bits to match the alignment.
--
local function GetAlignedByteCount(width, bitsperpixel, alignment)

	local bytesperpixel = bitsperpixel / 8;
	local stride = band((width * bytesperpixel + (alignment - 1)), bnot(alignment - 1));

	return stride;
end




GDIContext = nil
GDIContext_mt = {
	__tostring = function(self) return string.format("GDIContext(0x%s)", tostring(self.Handle)) end,
	__index = {
		TypeName = "DeviceContext",
		Size = ffi.sizeof("DeviceContext"),

		CreateDC = function(self, driver)
			return GDIContext(C.CreateDCA(driver, nil, nil, nil))
		end,

		CreateCompatibleDC = function(self)
			return GDIContext(C.CreateCompatibleDC(self.Handle))
		end,

		CreateForDefaultDisplay = function(self)
			self.Handle = C.CreateDCA("DISPLAY", nil, nil, nil)

            return self;
		end,

		CreateForMemory = function(self)
			local displayDC = C.CreateDCA("DISPLAY", nil, nil, nil)
			return GDIContext(C.CreateCompatibleDC(displayDC))
		end,

		CreateCompatibleBitmap = function(self, width, height)
				local bm = GDIBitmap(C.CreateCompatibleBitmap(self.Handle,width,height));
				bm:Init(self.Handle)

				return bm
		end,

		SelectObject = function(self, gdiobj)
				C.SelectObject(self.Handle, gdiobj.Handle)
		end,

		-- Drawing routines
		MoveTo = function(self, x, y)
			local result = C.MoveToEx(self.Handle, x, y, nil);
			return result
		end,

		LineTo = function(self, xend, yend)
			local result = C.LineTo(self.Handle, xend, yend);
			return result
		end,

		RoundRect = function(self, left, top, right, bottom, width, height)
			return C.RoundRect(self.Handle, left, top, right, bottom, width, height);
		end,

		Text = function(self, txt, x, y)
			x = x or 0
			y = y or 0
			return C.TextOutA(self.Handle, x, y, txt, string.len(txt));
		end,

		-- Device Context State
		Flush = function(self)
			return C.GdiFlush()
		end,


		SelectStockObject = function(self, objectIndex)
            -- First get a handle on the object
            local objHandle = C.GetStockObject(objectIndex);

            --  Then select it into the device context
            return C.SelectObject(self.Handle, objHandle);
        end,

		UseDCBrush = function(self)
			self:SelectStockObject(C.DC_BRUSH)
		end,

		UseDCPen = function(self)
			self:SelectStockObject(C.DC_PEN)
		end,

		SetDCBrushColor = function(self, color)
			return C.SetDCBrushColor(self.Handle, color)
		end,

		SetDCPenColor = function(self, color)
			return C.SetDCPenColor(self.Handle, color)
		end,
	}
}
GDIContext = ffi.metatype("DeviceContext", GDIContext_mt)






BITMAP = ffi.typeof("BITMAP")

GDIBitmap = nil
GDIBitmap_mt = {
	__tostring = function(self) return string.format("GDIBitmap(0x%s)", tostring(self.Handle)) end,
	__index = {
		TypeName = "BITMAP",
		Size = ffi.sizeof("GDIBitmap"),
		Init = function(self, hdc)
			local bmap = ffi.new("BITMAP[1]")
			local bmapsize = ffi.sizeof("BITMAP");
			C.GetObjectA(self.Handle, bmapsize, bmap)
			self.Bitmap = bmap[0]

			end,

		Print = function(self)
			print(string.format("Bitmap"))
			print(string.format("        type: %d", self.Bitmap.bmType))
			print(string.format("       width: %d", self.Bitmap.bmWidth))
			print(string.format("      height: %d", self.Bitmap.bmHeight))
			print(string.format(" Width Bytes: %d", self.Bitmap.bmWidthBytes))
			print(string.format("      Planes: %d", self.Bitmap.bmPlanes))
			print(string.format("BitsPerPixel: %d", self.Bitmap.bmBitsPixel));

			end,
	}
}
GDIBitmap = ffi.metatype("GDIBitmap", GDIBitmap_mt)

--
-- GDIDIBSection_mt
--
GDIDIBSection = nil
GDIDIBSection_mt = {
	__index = {
		TypeName = "GDIDIBSection",
		Size = ffi.sizeof("GDIDIBSection"),
		Init = function(self, width, height, bitsperpixel, alignment)
			alignment = alignment or 2
			bitsperpixel = bitsperpixel or 32

			self.Width = width
			self.Height = height
			self.BitsPerPixel = bitsperpixel


			-- Need to construct a BITMAPINFO structure
			-- to describe the image we'll be creating
			local bytesPerRow = GetAlignedByteCount(width, bitsperpixel, alignment)
			local info = ffi.new("BITMAPINFO")
			info:Init()
			info.bmiHeader.biWidth = width
			info.bmiHeader.biHeight = height
			info.bmiHeader.biPlanes = 1
			info.bmiHeader.biBitCount = bitsperpixel
			info.bmiHeader.biSizeImage = bytesPerRow * height
			info.bmiHeader.biClrImportant = 0
			info.bmiHeader.biClrUsed = 0
			info.bmiHeader.biCompression = 0	-- GDI32.BI_RGB
			self.Info = info

			-- Create the DIBSection, using the screen as
			-- the source DC
			local ddc = GDIContext():CreateForDefaultDisplay().Handle
			local DIB_RGB_COLORS = 0
			local pixelP = ffi.new("void *[1]")
			self.Handle = C.CreateDIBSection(ddc,
                info,
				DIB_RGB_COLORS,
				pixelP,
				nil,
				0);
--print("GDIDIBSection Handle: ", self.Handle)
			--self.Pixels = ffi.cast("Ppixel_BGRA_b", pixelP[0])
			self.Pixels = pixelP[0]

			-- Create a memory device context
			self.hDC = GDIContext():CreateForMemory()
			local selected = C.SelectObject(self.hDC.Handle, self.Handle)
--print("Selected: ", selected)
			--print("self.Pixels after cast: ", self.Pixels)

			return self
		end,

		Print = function(self)
			print("Bits Per Pixel: ", self.BitsPerPixel)
			print("Size: ", self.Width, self.Height)
			print("Pixels: ", self.Pixels)
		end,
		}
}
GDIDIBSection = ffi.metatype("GDIDIBSection", GDIDIBSection_mt)

--[[
print("win_gdi_32.lua - TEST")
local sec = GDIDIBSection():Init(320,240)
sec:Print()


--]]




function StretchBlt(winDC, img, XDest, YDest,DestWidth,DestHeight)
	local SRCCOPY = 0x00CC0020

	XDest = XDest or 0
	YDest = YDest or 0
	DestWidth = DestWidth or img.Width
	DestHeight = DestHeight or img.Height

	-- Draw a pixel buffer
	local bmInfo = BITMAPINFO();
	bmInfo:Init();
	bmInfo.bmiHeader.biWidth = img.Width;
    bmInfo.bmiHeader.biHeight = img.Height;
    bmInfo.bmiHeader.biPlanes = 1;
    bmInfo.bmiHeader.biBitCount = img.BitsPerElement;
    bmInfo.bmiHeader.biClrImportant = 0;
    bmInfo.bmiHeader.biClrUsed = 0;
    bmInfo.bmiHeader.biCompression = 0;

	ffi.C.StretchDIBits(winDC,
		XDest,YDest,DestWidth,DestHeight,
		0,0,img.Width, img.Height,
		img.Data,
		bmInfo,
		0,
		SRCCOPY);
end



