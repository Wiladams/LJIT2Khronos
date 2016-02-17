


--[[
/*
***************************************************************************************************
*   Platform-specific directives and type declarations
***************************************************************************************************
*/
--]]
--[[
/* Platform-specific calling convention macros.
 *
 * Platforms should define these so that Vulkan clients call Vulkan commands
 * with the same calling conventions that the Vulkan implementation expects.
 *
 * VKAPI_ATTR - Placed before the return type in function declarations.
 *              Useful for C++11 and GCC/Clang-style function attribute syntax.
 * VKAPI_CALL - Placed after the return type in function declarations.
 *              Useful for MSVC-style calling convention syntax.
 * VKAPI_PTR  - Placed between the '(' and '*' in function pointer types.
 *
 * Function declaration:  VKAPI_ATTR void VKAPI_CALL vkCommand(void);
 * Function pointer type: typedef void (VKAPI_PTR *PFN_vkCommand)(void);
 */
--]]

local ffi = require("ffi")
local e = {}

if ffi.os == "Windows" then
    -- On Windows, Vulkan commands use the stdcall convention
    e.VKAPI_ATTR = "";
    e.VKAPI_CALL = "__stdcall";
    e.VKAPI_PTR  = e.VKAPI_CALL;
elseif __ANDROID__ and __ARM_EABI__ and not __ARM_ARCH_7A__ then
    -- Android does not support Vulkan in native code using the "armeabi" ABI.
    error ("Vulkan requires the 'armeabi-v7a' or 'armeabi-v7a-hard' ABI on 32-bit ARM CPUs")
elseif __ANDROID__ and __ARM_ARCH_7A__ then
    -- On Android/ARMv7a, Vulkan functions use the armeabi-v7a-hard calling
    -- convention, even if the application's native code is compiled with the
    -- armeabi-v7a calling convention.
    e.VKAPI_ATTR = '__attribute__((pcs("aapcs-vfp")))'
    e.VKAPI_CALL = "";
    e.VKAPI_PTR  = e.VKAPI_ATTR
else
    -- On other platforms, use the default calling convention
    e.VKAPI_ATTR = ""
    e.VKAPI_CALL = ""
    e.VKAPI_PTR = ""
end


--[[
// Platform-specific headers required by platform window system extensions.
// These are enabled prior to #including "vulkan.h". The same enable then
// controls inclusion of the extension interfaces in vulkan.h.

#ifdef VK_USE_PLATFORM_ANDROID_KHR
#include <android/native_window.h>
#endif

#ifdef VK_USE_PLATFORM_MIR_KHR
#include <mir_toolkit/client_types.h>
#endif

#ifdef VK_USE_PLATFORM_WAYLAND_KHR
#include <wayland-client.h>
#endif

#ifdef VK_USE_PLATFORM_WIN32_KHR
#include <windows.h>
#endif

#ifdef VK_USE_PLATFORM_XLIB_KHR
#include <X11/Xlib.h>
#endif

#ifdef VK_USE_PLATFORM_XCB_KHR
#include <xcb/xcb.h>
#endif
--]]

return e;
