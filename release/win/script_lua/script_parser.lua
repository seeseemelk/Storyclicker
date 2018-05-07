function script.load(filename)
	script.directory = filename:match("^(.*/)")
	local env = script.env
	--local script = assert(loadfile(filename, "=" .. filename, env))
	local script = assert(load(string.dump(love.filesystem.load(filename)), "=" .. filename, "bt", env))
	local obj = {
		env = env,
		script = coroutine.wrap(script)
	}

	return obj
end
