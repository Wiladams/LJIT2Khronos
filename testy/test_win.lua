package.path = package.path..";..\\?.lua";

local win32 = require("win32")
local gl = require("khronos.gl.gl")
local wglext = require("khronos.gl.wglext")

print("wglext", wglext)