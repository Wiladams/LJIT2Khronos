local subs = {
	quick = 'slow';
	brown = 'black';
	fox = 'slug';
}

local target = "The quick brown fox jumps over the lazy dogs back"

local function cleanup(target, patts)
	local str = target
	for key,value in pairs(patts) do
		str = string.gsub(str, key, value)
	end

	return str;
end

local str = cleanup(target, subs)

print(str)

