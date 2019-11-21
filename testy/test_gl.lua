package.path = package.path..";..\\?.lua";

local gl = require("khronos.gl.gl")
local glext = require("khronos.gl.glext")
local wglext = require("khronos.gl.wglext")

local ns = require("namespace")()

ns = ns + gl.constants

print("GL_SET: ", GL_SET)
print("GL_NOR: ", GL_NOR)