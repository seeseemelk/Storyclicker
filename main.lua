local GAME = "lovers/story.lua"

if love then
	isLove = true
	isCLI = false
elseif not love then
	print("WARNING! Not running in Love2D")
	love = {}
	isCLI = true
	isLove = false
end

require("script_lua/script")
local serpent = require("script_lua/serpent")

function string.occures(str, patt)
	return select(2, str:gsub(patt, ""))
end

local debugoptions = {
	skipfades = false
}

effects = {
	animation = false,
	fade = {
		enabled = false,
		fadein = true,
		tick = 0,
		colorr = 0,
		colorg = 0,
		colorb = 0,
		time = 0,
		interrupt = false
	},
	sleep = {
		enabled = false,
		starttime = 0,
		endttime = 0
	},
	music = {
		enabled = false,
		volume = false,
		object = false,
	},
	audio = {
		muted = false
	},
	image = {
		enabled = false,
		image = nil,
		fadeing = false,
		fadein = false,
		tick = 0,
		interrupt = false,
	},
	text = {
		time = 0,
	}
}

deltatime = 0

ui = {}
ui.currentFrame = 0
ui.text = "Starting..."
ui.textFrame = 0
ui.textWritten = false
ui.selected = ""
ui.questions = {}
ui.font = love.graphics.newFont(28)
--ui.background = nil
--ui.image = nil

local FADE_CONSTANT = (256 / math.sqrt(98))

function drawFade()
	local w, h = love.graphics.getDimensions()
	local effect = effects.fade

	--local alpha = effect.tick / 99 * 255
	local alpha = FADE_CONSTANT * math.sqrt(effect.tick)
	--alpha = effect.fadein and alpha or 255 - alpha

	love.graphics.setColor(effect.colorr, effect.colorg, effect.colorb, alpha)
	love.graphics.rectangle("fill", 0, 0, w, h)
	--print(percentage, alpha, effect.tick)
	if effect.enabled then
		if effect.fadein then
			effect.tick = effect.tick + (1/effect.time * 100 * deltatime)
		else
			effect.tick = effect.tick - (1/effect.time * 100 * deltatime)
		end
	end

	if effect.enabled then
		effects.animation = true
		if effect.tick > 100 then
			--effect.fadein = false
			effect.enabled = false
			effect.interrupt = true
			effects.animation = false
		elseif not effect.fadein and effect.tick < 0 then
			effect.enabled = false
			effect.interrupt = true
			effects.animation = false
		end
	end
end

function drawText()
	local w, h = love.graphics.getDimensions()
	local margin = 48
	local padding = 16

	local leftm = margin
	local rightm = w - margin - margin
	local topm = margin
	local bottomm = h - margin - margin

	local textheight = ui.font:getHeight()

	local topBarHeight = 0
	love.graphics.setFont(ui.font)
	local limit = rightm - padding * 2

	--local text = ui.text:sub(1, ui.currentFrame - ui.textFrame)
	local characterstoshow = effects.text.time * 40 --ui.currentFrame - ui.textFrame
	if ui.textWritten then
		characterstoshow = #ui.text
	end
	local ncharacters = characterstoshow
	local text = ui.text
	--local nLines = math.ceil(ui.font:getWidth(ui.text) / limit) + string.occures(ui.text, "\n")
	local maxwidth, lines = ui.font:getWrap(text, limit)
	local nLines = #lines
	local topBarHeight = nLines * ui.font:getHeight() + padding * 2

	if #ui.text > 0 then
		love.graphics.setColor(255, 255, 255, 200)
		love.graphics.rectangle("fill", leftm, topm, rightm, topBarHeight)
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("line", leftm, topm, rightm, topBarHeight)
		love.graphics.setColor(0, 0, 0)

		for index, line in ipairs(lines) do
			local charactersline = #line <= ncharacters and #line or ncharacters
			ncharacters = ncharacters - charactersline
			local printedline = line:sub(1, charactersline)
			love.graphics.printf(printedline, leftm + padding, topm + padding + textheight * (index - 1), limit, "left")
		end
	end

	--if #text - (ui.currentFrame - ui.textFrame) <= 0 then
	if #ui.text - characterstoshow <= 0 then
		ui.textWritten = true
	end

	return topBarHeight
end

function drawButtons()
	local w, h = love.graphics.getDimensions()
	local margin = 48
	local padding = 16

	local leftm = margin
	local rightm = w - margin - margin
	local topm = margin
	local bottomm = h - margin - margin

	local mouseX, mouseY = love.mouse.getPosition()

	local bottomBarHeight = margin
	local buttonHeight = margin
	local textheight = ui.font:getHeight()

	local by = h - margin / 2

	for index = #ui.questions, 1, -1 do
		local question = ui.questions[index]
		local text = question.text
		local bw = rightm
		local maxlimit = bw - padding * 2
		local maxwidth, lines = ui.font:getWrap(text, maxlimit)
		local bx = leftm
		local bh = textheight * #lines + 16
		by = by - bh - padding

		question.x = bx
		question.y = by
		question.w = bw
		question.h = bh

		love.graphics.setColor(255, 255, 255, 200)
		love.graphics.rectangle("fill", bx, by, bw, bh)

		if ui.textWritten and mouseX > bx and mouseX < bx + bw and mouseY > by and mouseY < by + bh then
			if love.mouse.isDown(1) then
				love.graphics.setColor(200, 200, 200)
			else
				love.graphics.setColor(100, 100, 100)
			end
		else
			love.graphics.setColor(0, 0, 0)
		end

		love.graphics.printf(text, bx + padding, by + padding / 2, maxlimit, "center")
		love.graphics.rectangle("line", bx, by, bw, bh)
	end
end

function drawMuteButton()
	local mx, my = love.mouse.getPosition()
	local over = math.sqrt((mx - 20)^2 + (my - 20)^2) <= 17
	local down = love.mouse.isDown(1)

	if not effects.audio.muted then
		if over then
			if down then
				love.graphics.setColor(200, 200, 200, 200)
			else
				love.graphics.setColor(255, 255, 255, 220)
			end
		else
			love.graphics.setColor(255, 255, 255, 200)
		end
	elseif effects.audio.muted then
		if over then
			if down then
				love.graphics.setColor(150, 150, 150, 200)
			else
				love.graphics.setColor(200, 200, 200, 220)
			end
		else
			love.graphics.setColor(200, 200, 200, 200)
		end
	end
	love.graphics.ellipse("fill", 20, 20, 15, 15)
	love.graphics.setColor(0, 0, 0)
	love.graphics.ellipse("line", 20, 20, 15, 15)
end

local IMAGE_FADE_CONSTANT = (256 / math.sqrt(98))
local IMAGE_TIME = 1 / .3 * 100
function drawImage()
	local w, h = love.graphics.getDimensions()
	if effects.image.enabled and effects.image.image then
		local alpha = IMAGE_FADE_CONSTANT * math.sqrt(effects.image.tick)
		love.graphics.setColor(255, 255, 255, alpha)
		--local height = h - topBarHeight - bottomBarHeight - margin)
		local ih = h * .5 -- (buttonHeight + margin) * 4
		local iw = ih / effects.image.image:getHeight() * effects.image.image:getWidth()

		local x = (w - iw) * .5
		local y = (h - ih) * .5
		love.graphics.draw(effects.image.image, x, y, 0, iw / effects.image.image:getWidth(), ih / effects.image.image:getHeight())

		if effects.image.fading then
			effects.animation = true
			if effects.image.fadein then
				effects.image.tick = effects.image.tick + IMAGE_TIME * deltatime
				if effects.image.tick >= 100 then
					effects.image.fading = false
					effects.image.tick = 100
					effects.image.interrupt = true
					effects.animation = false
				end
			else
				effects.image.tick = effects.image.tick - IMAGE_TIME * deltatime
				if effects.image.tick <= 0 then
					effects.image.tick = 100
					effects.image.fading = false
					effects.image.image = nil
					effects.image.enabled = false
					effects.image.interrupt = true
					effects.animation = false
				end
			end
		end
	elseif effects.image.enabled then
		effects.image.enabled = false
		effects.image.interrupt = true
	end
end

function love.draw()
	ui.currentFrame = ui.currentFrame + 1
	love.graphics.setBackgroundColor(255, 0, 255)

	-- Draw the background
	local w, h = love.graphics.getDimensions()
	local margin = 48
	local padding = 16


	if ui.background then
		love.graphics.setColor(255, 255, 255)
		local iw, ih = ui.background:getDimensions()
		love.graphics.draw(ui.background, 0, 0, 0, w / iw, h / ih)
	end

	local leftm = margin
	local rightm = w - margin - margin
	local topm = margin
	local bottomm = h - margin - margin

	-- Draw the image, if any
	drawImage()

	-- Draw the text and box
	local topBarHeight = drawText()

	-- Draw the question boxes
	drawButtons()

	drawMuteButton()

	-- Draw a fade effect if there is one
	drawFade()
end

function love.update(dt)
	deltatime = dt
	if effects.fade.interrupt then
		effects.fade.interrupt = false
		story()
	elseif effects.sleep.enabled then
		local time = love.timer.getTime()
		if time >= effects.sleep.endtime then
			effects.sleep.enabled = false
			story()
		end
	elseif effects.image.interrupt then
		effects.image.interrupt = false
		story()
	end

	if effects.music.enabled then
		if effects.music.object:isStopped() then
			effects.music.object:play()
		end
	end

	effects.text.time = effects.text.time + dt
end

function love.mousereleased(x, y, button)
	-- Check if the entire text has already been displayed
	--local left = #ui.text - ui.currentFrame + ui.textFrame
	--if left > 0 then

	if math.sqrt((x - 20)^2 + (y - 20)^2) <= 17 then
		effects.audio.muted = not effects.audio.muted
		if effects.audio.muted then
			love.audio.setVolume(0.0)
		else
			love.audio.setVolume(1.0)
		end
	elseif not ui.textWritten then
		--ui.textFrame = ui.textFrame - #ui.text + ui.currentFrame - ui.textFrame
		ui.textWritten = true
	elseif not effects.animation then
		-- Check if a button is pressed

		for index, question in ipairs(ui.questions) do
			if question.x then
				local bx = question.x
				local by = question.y
				local bw = question.w
				local bh = question.h

				if x > bx and x < bx + bw and y > by and y < by + bh then
					ui.selected = question.name
					print("Player chose " .. ui.selected)
					story()
					return
				end
			end
		end
	else
		print("Ongoing animation")
	end
end

function love.keypressed(key)
	if key == "f1" then
		debugoptions.skipfades = not debugoptions.skipfades
		print("Skip fades is now " .. (debugoptions.skipfades and "enabled" or "disabled"))
	end
end

function script.ext.say(text)
	ui.text = text
	ui.textFrame = ui.currentFrame
	ui.textWritten = false
	effects.text.time = 0
end

function script.ext.ask(questions)
	ui.questions = questions
	coroutine.yield()
	return ui.selected
end

function script.ext.clearask(question)
	ui.questions = {}
end

function script.ext.background(filename)
	ui.background = love.graphics.newImage(filename)
end

function script.ext.image(filename)
	if filename then
		effects.image.image = love.graphics.newImage(filename)
		effects.image.fading = true
		effects.image.fadein = true
		effects.image.tick = 0
		effects.image.enabled = true
	else
		effects.image.fading = true
		effects.image.fadein = false
		effects.image.tick = 100
		effects.image.enabled = true
	end
	coroutine.yield()
end

function script.ext.fadein(colorr, colorg, colorb, time)
	if debugoptions.skipfades then
		time = 0
	end
	effects.fade.enabled = true
	effects.fade.colorr = colorr
	effects.fade.colorg = colorg
	effects.fade.colorb = colorb
	effects.fade.time = time
	effects.fade.tick = 0
	effects.fade.fadein = true
	effects.fade.interrupt = false
end

function script.ext.fadeout(colorr, colorg, colorb, time)
	if debugoptions.skipfades then
		time = 0
	end
	effects.fade.enabled = true
	effects.fade.colorr = colorr
	effects.fade.colorg = colorg
	effects.fade.colorb = colorb
	effects.fade.time = time
	effects.fade.tick = 100
	effects.fade.fadein = false
	effects.fade.interrupt = false
end

function script.ext.waitforfade()
	coroutine.yield()
end

function script.ext.save(tbl, name)
	local dump = serpent.dump(tbl, {
		comment = false,
		compact = true,
	})
	local file, err = love.filesystem.newFile(name .. ".dat", "w")
	if not file then
		error(err)
	end
	file:write(dump)
	file:close()
end

function script.ext.load(name)
	local content, size = love.filesystem.read(name .. ".dat")
	return loadstring(content)()
end

function script.ext.saveexists(name)
	return love.filesystem.exists(name .. ".dat")
end

function script.ext.sleep(amount)
	effects.sleep.enabled = true
	effects.sleep.starttime = love.timer.getTime()
	effects.sleep.endtime = effects.sleep.starttime + amount
	coroutine.yield()
end

function script.ext.music(filename)
	if not filename then
		effects.music.enabled = false
		effects.music.object:stop()
	else
		filename = script.directory .. filename
		effects.music.filename = filename
		effects.music.object = love.audio.newSource(filename)
		effects.music.enabled = true
		effects.music.object:play()
	end
end

-- Love routines
function love.load(args)
	if not args[1] then
		args[1] = GAME
	end
	local storyFile = args[1]

	storyCode = script.load(storyFile)

	if love then
		love.window.setTitle("Storyclicker Alpha")
		love.window.setMode(800, 600, {
			resizable = true,
			minwidth = 640,
			minheight = 480
		})
	end

	story = script.init(storyCode)
	story()
end

if isCLI then
	local args = {...}
	table.insert(args, 1, "lua")
	love.load(args)
end
