--[[
	OpenGL Manager (OglMan)

	This is a set of routines that makes programming with OpenGL
	a little bit easier.
]]
local ffi = require "ffi"

local libs = ffi_OpenGL_libs or {
   OSX     = { x86 = "OpenGL.framework/OpenGL", x64 = "OpenGL.framework/OpenGL" },
   Windows = { x86 = "OPENGL32.DLL",            x64 = "OPENGL32.DLL" },
   Linux   = { x86 = "libGL.so",                x64 = "libGL.so", arm = "libGL.so" },
   BSD     = { x86 = "libGL.so",                x64 = "libGL.so" },
   POSIX   = { x86 = "libGL.so",                x64 = "libGL.so" },
   Other   = { x86 = "libGL.so",                x64 = "libGL.so" },
}

local libname  = ffi_OpenGL_lib or libs[ ffi.os ][ ffi.arch ]

local gllib   = ffi.load( libname )

local gl = require "khronos.gl"
local glext = require "khronos.glext"
local wglext = require "khronos.wglext"



local function GetFunctionProtoName(fname)
	local upname = fname:upper();
	local protoname = string.format("PFN%sPROC", upname);

	return protoname;
end

local function CastFunctionPointer(fname, funcptr)
	local protoname = GetFunctionProtoName(fname);
	local castfunc = ffi.cast(protoname, funcptr);

	return castfunc;
end

local function GetWglFunction(fname)
	local funcptr = gllib.wglGetProcAddress(fname);

	if funcptr == nil then
		return nil
	end

	local castfunc = CastFunctionPointer(fname, funcptr);

	return castfunc;
end


--[[
	Convenience aliases
--]]
exports.glAlphaFunc = gl.glAlphaFunc;
exports.glBegin = gl.glBegin;
exports.glBlendFunc = gl.glBlendFunc;
exports.glClear = gl.glClear;
exports.glClearColor = gl.glClearColor;

exports.glColor3f = gl.glColor3f;
exports.glColor4f = gl.glColor4f;
exports.glColorMaterial = gl.glColorMaterial;
exports.glCullFace = gl.glCullFace;
exports.glDeleteLists = gl.glDeleteLists;
exports.glDepthFunc = gl.glDepthFunc;
exports.glDepthRange = gl.glDepthRange;
exports.glDisable = gl.glDisable;
exports.glEnable = gl.glEnable;
exports.glDrawPixels = gl.glDrawPixels;
exports.glEnd = gl.glEnd;
exports.glEndList = gl.glEndList;
exports.glFinish = gl.glFinish;
exports.glFlush = gl.glFlush;
exports.glGenLists = gl.glGenLists;
exports.glGetError = gl.glGetError;
exports.glHint = gl.glHint;
exports.glLineWidth = gl.glLineWidth;
exports.glLoadIdentity = gl.glLoadIdentity;
exports.glMatrixMode = gl.glMatrixMode;
exports.glPopMatrix = gl.glPopMatrix;
exports.glPushMatrix = gl.glPushMatrix;
exports.glOrtho = gl.glOrtho;
exports.glFrustum = gl.glFrustum;
exports.glPixelStorei = gl.glPixelStorei;
exports.glPointSize = gl.glPointSize;
exports.glPolygonMode = gl.glPolygonMode;
exports.glRasterPos2i = gl.glRasterPos2i;
exports.glRotatef = gl.glRotatef;
exports.glScalef = gl.glScalef;
exports.glShadeModel = gl.glShadeModel;

exports.glTexCoord = glTexCoord
exports.glTexCoord2f = glTexCoord;
exports.glTexCoord2d = gl.glTexCoord2d;
exports.glTranslate = glTranslate
exports.glTranslatef = gl.glTranslatef;


exports.glVertex2f = gl.glVertex2f;
exports.glVertex3f = gl.glVertex3f;
exports.glVertex4f = gl.glVertex4f;
exports.glVertex2d = gl.glVertex2d;
exports.glViewport = gl.glViewport;

--[[
	Some helper functions
]]

local function glClearDepth (depth)
	gllib.glClearDepth(depth);
end

local function glColor(...)
	local arg={...};
	local nargs = select('#', ...)

	if nargs == 3 then
		gllib.glColor3d(arg[1], arg[2], arg[3]);
	elseif nargs == 4 then
		gllib.glColor4d(arg[1], arg[2], arg[3], arg[4]);
	elseif nargs == 2 then
		gllib.glColor4d(arg[1], arg[1], arg[1], arg[2]);
	elseif nargs == 1 then
		if type(arg[1] == "number") then
			gllib.glColor3d(arg[1], arg[1], arg[1]);
		elseif type(arg[1]) == "table" then
			if #arg[1] == 3 then
				gllib.glColor3d(arg[1], arg[2], arg[3]);
			elseif #arg[1] == 4 then
				gllib.glColor4d(arg[1], arg[2], arg[3], arg[4]);
			end
		end
	end
end
exports.glColor = glColor




local function glRasterPos(x, y)
	gl.glRasterPos2d(x, y);
end

local function glRotate(angle, x, y, z)
	gl.glRotated(angle, x, y, z);
end

local function glScale(x, y, z)
	gl.glScaled (x, y, z);
end

local function glTexCoord(s, t, r, q)
	gl.glTexCoord2d(s, t);
end

local function glTranslate(x, y, z)
	gl.glTranslated(x, y, z);
end



local function glVertex(...)
local arg={...};
	if #arg == 3 then
		gl.glVertex3d(arg[1], arg[2], arg[3]);
	elseif #arg == 4 then
		gl.glVertex4d(arg[1], arg[2], arg[3], arg[4]);
	elseif #arg == 1 then
		if type(arg[1]) == "table" then
			if #arg[1] == 3 then
				gl.glVertex3d(arg[1], arg[2], arg[3]);
			elseif #arg[1] == 4 then
				gl.glVertex4d(arg[1], arg[2], arg[3], arg[4]);
			end
		end
	end
end
exports.glVertex = glVertex



local OglMan={}
local OglMan_mt = {
	__index = function(tbl, key)
		local funcptr = GetWglFunction(key)

		-- Set the function into the table of
		-- known functions, so next time around,
		-- it this code will not need to execute
		rawset(tbl, key, funcptr)

		return funcptr;
	end,

--[[
	__newindex = function(tbl, idx, value)
		if idx == "Execute" then
			rawset(tbl, idx, value)
		end
	end,
--]]
}

setmetatable(OglMan, OglMan_mt)


return OglMan;
