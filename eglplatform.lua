local ffi = require("ffi")

if ffi.os == "Windows" then
ffi.cdef[[
typedef HDC	EGLNativeDisplayType;
typedef HBITMAP EGLNativePixmapType;
typedef HWND    EGLNativeWindowType;
]]
elseif ffi.os == "Linux" then
-- <X11/Xlib.h>
-- <X11/Xutil.h>
ffi.cdef[[
typedef Display *EGLNativeDisplayType;
typedef Pixmap   EGLNativePixmapType;
typedef Window   EGLNativeWindowType;
]]
end

ffi.cdef[[
typedef khronos_int32_t EGLint;
]]

