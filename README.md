LJIT2Khronos
============

LuaJIT FFI Binding to Khronos APIs

The bindings here are rudimentary and quite old, originally done in 2011 timeframe.  The style is sufficient, but there are probably better, more up to date bindings to the 
various Khronos APIs at this point.  This is a consolidated set, that was created
to play around with the different APIs at the time.

The resurrection of these APIs (2019) is due to a desire to resurrect various programs
that relied on them.  At the same time, they need to be modernized based on 8 years of
further understanding and evolution of the LuaJIT ffi mechanism.

Usage
=====
Copy the khronos directory to your lua environment.  Then you can simply access things
like this:

```lua
local gl = require("khronos.gl.gl")
local OglMan = require("khronos.gl.OglMan")
```

OglMan (OpenGL Manager) is a super convenience as it allows you easy access to various of the APIs in a more Lua friendly way.

OpenGL has a lot of constants, and functions.  If you were programming in the 'C' language,
everything is essentially in one giant shared namespace.  When programming in lua, it is
idiomatic to put things into local scope rather than global scope.  All the constants in 
this OpenGL binding are stored in local scope, nothing should be global.  The challenge
imposed by this design constraint is that your code can become very wordy.

```lua
local gl = require("khronos.gl.gl")

-- print the value of one of the constants
print("GL_SET: ", gl.constants.GL_SET)
```

This would become even more tedious if you were using these values in function calls, which
will happen a log.  You can put some aliases at the top of your file:

```lua
local gl = require("khronos.gl.gl")
local GL_SET = gl.constants.GL_SET

print("GL_SET: ", GL_SET)
```

But, given the literally thousands of constants that are available, this would become very
tedious, and wasteful.

There is a convenience method in the test directory 'namespace.lua'.  With this, you can 
quickly put a bunch of stuff into your local namespace without much effort:

```lua
local gl = require("khronos.gl.gl")
local namespace = require("namespace")
local ns = namespace()

ns = ns + gl.constants

print("GL_SET: ", GL_SET)
print("GL_NOR: ", GL_NOR)
```

Using this mechanism, you will be able to quickly add things to your local namespace ('ns')
without having to type out all those aliases.  Then you can use them as if they were in 
the global namespace.  You can add all the constants, or all functions.  If you do this,
your programs will look pretty much the same as they would if you were programming OpenGL
in 'C'.
