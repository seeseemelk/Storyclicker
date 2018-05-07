script.env = {}
script.ext = {}

function script.init(code)
	return code.script
end

script.env.error = error
script.env.tonumber = tonumber
script.env.tostring = tostring
script.env.math = math
script.env.table = table
script.env.string = string
script.env.unpack = table.unpack or unpack
script.env.pairs = pairs
script.env.ipairs = ipairs

function script.env.say(text)
	print("Said: " .. text)

	if not isCLI then
		script.ext.say(text)
	end
end

function script.env.clear()
	script.env.say("")
	script.ext.clearask()
end

function script.env.ask(...)
	print("=== Question time! ===")

	local questions = {...}
	if type(questions[1]) == "table" then
		return script.env.ask(unpack(questions[1]))
	end
	local names = {}

	for i, v in ipairs(questions) do
		local name = string.match(v, "^(.-):") or " "
		local text = string.match(v, ":(.*)$")
		questions[i] = {name = name, text = text}
		print("(" .. tostring(name) .. "): " .. tostring(text))
	end

	local answer
	if isCLI then
		repeat
			answer = io.read()
		until table.has(names, answer)
	else
		answer = script.ext.ask( questions)
	end

	return answer
end

function script.env.quit()
	if isCLI then
		os.exit()
	elseif isLove then
		love.event.quit()
		coroutine.yield()
	end
end

function script.env.confirm()
	script.env.ask("c:Ok...")
end

local music, voice

function script.env.music(filename)
	if isLove then
		script.ext.music(filename)
	else
		print("Can't do music under current environment")
	end
end

function script.env.voice(filename)
	if isLove then
		filename = script.directory .. filename

		if voice then
			voice:stop()
		end

		voice = love.audio.newSource(filename)
		voice:play()
	else
		print("Can't do music under the current environment")
	end
end

function script.env.background(filename)
	if isLove then
		filename = script.directory .. filename
		script.ext.background(filename)
	else
		print("Can't show a background under the current environment")
	end
end

function script.env.image(filename)
	if isLove then
		if filename == "" then
			script.ext.image()
		else
			filename = script.directory .. filename
			script.ext.image(filename)
		end
	else
		print("Can't show images under the current environment")
	end
end

function script.env.blocky(bool)
	if bool then
		if love then
			love.graphics.setDefaultFilter("nearest", "nearest", 1)
		end
	else
		if love then
			love.graphics.setDefaultFilter("linear", "linear", 1)
		end
	end
end

function script.env.print(...)
	print(...)
end

--[[
function script.env.fade(colorr, colorg, colorb, time)
	if not colorg then
		script.env.fade(0, 0, 0, colorr)
	else
		script.ext.fade(colorr, colorg, colorb, time)
	end
end
--]]

function script.env.fadein(colorr, colorg, colorb, time)
	if not colorg then
		script.env.fadein(0, 0, 0, colorr)
	else
		assert(time, "No time parameter given for fadein effect")
		script.ext.fadein(colorr, colorg, colorb, time)
		script.env.fadeblock()
	end
end

function script.env.fadeout(colorr, colorg, colorb, time)
	if not colorg then
		script.env.fadeout(0, 0, 0, colorr)
	else
		assert(time, "No time parameter given for fadeout effect")
		script.ext.fadeout(colorr, colorg, colorb, time)
		script.env.fadeblock()
		script.env.sleep(.3)
	end
end

--[[
function script.env.blockfade(colorr, colorg, colorb, time)
	script.env.fade(colorr, colorg, colorb, time)
	script.env.waitforfade()
end

function script.env.fullblockfade(colorr, colorg, colorb, time)
	script.env.fade(colorr, colorg, colorb, time)
	script.env.waitforfade(true)
end

function script.env.waitforfade(waitforfullcycle)
	if waitforfullcycle then
		script.ext.waitforfade()
	end
	script.ext.waitforfade()
end
--]]

function script.env.fadeblock()
	script.ext.waitforfade()
end

function script.env.fade(colorr, colorg, colorb, time)
	script.env.fadein(colorr, colorg, colorb, time / 2)
	script.env.fadeout(colorr, colorg, colorb, time / 2)
end

function script.env.save(tbl, name)
	script.ext.save(tbl, name)
end

function script.env.load(name)
	return script.ext.load(name)
end

function script.env.saveexists(name)
	return script.ext.saveexists(name)
end

function script.env.sleep(amount)
	script.ext.sleep(amount)
end
