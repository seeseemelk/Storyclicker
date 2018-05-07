
function scc(...)
	say(...)
	confirm()
	clear()
end

function sc(...)
	say(...)
	confirm()
end

function moment_wakeup()
	local o
	background "bedroom.png"
	say("Me: Haww...")
	confirm()
	say("Alarm: Good morning!")
	--image("alarm.png")
	o = ask("b:Hmm...", "c:Hgg...",
			"a:Good morning alarm",
			"d:I'll fucking kill you")
	if o == "a" then
		say("Me: Hello to you too alarm!")
	elseif o == "b" then
		say("Me: Hmm...")
	elseif o == "c" then
		say("Me: Hgg...")
	elseif o == "d" then
		say("Me: I'll take the fucking screwdriver, screw you open and gut you while you are plugged in!")
		confirm()
		say("Me: Afterwards, I'll go to the store and murder your entire fucking family!")
		confirm()
		say("Alarm: That's a sad thing to say!")
		confirm()
		say("Me: I don't fucking care!")
	end
	confirm()
	say("Me: Hmm... Fine! I'll get up.")
	confirm()
end

function moment_getready()
	local o
	local teeth = false
	local breakfast = false
	local clothes = false

	sc("Me: Now what should I do?")
	scc("Me: I have to get changed, brush my teeth and eat breakfast.")

	local location = "bedroom"

	while not (clothes and teeth and breakfast) do
		if location == "bedroom" then
			background "bedroom.png"
			o = ask("a:Put on clothes", "b:Go to bathroom", "c:Go to kitchen")
			if o == "a" then
				if clothes then
					scc "Me: I already have my clothes."
				else
					clothes = true
					-- voice "put_on_clothes.ogg"
					scc "Me: Got me clothes!"
				end
			elseif o == "b" then
				location = "bathroom"
			elseif o == "c" then
				location = "kitchen"
			end
		elseif location == "bathroom" then
			background "bathroom.png"
			o = ask("a:Brush teeth", "b:Go back")
			if o == "a" then
				if teeth then
					scc("Me: I already brushed my teeth.")
				else
					teeth = true
					scc("Me: Brushed my teeth!")
				end
			elseif o == "b" then
				location = "bedroom"
			end
		elseif location == "kitchen" then
			background "kitchen.png"
			o = ask("a:Eat breakfast", "b:Leave", "c:Go back")
			if o == "a" then
				if breakfast then
					scc "Me: I have already had my breakfast."
				else
					breakfast = true
					scc "Me: Ate my breakfast!"
				end
			elseif o == "b" then
				sc "Me: I can't leave yet."
				if not teeth then
					sc "Me: I haven't brushed my teeth yet."
				elseif not clothes then
					sc "Me: I still have to change."
				elseif not breakfast then
					sc "Me: I still have to eat."
				end
				clear()
			elseif o == "c" then
				location = "bedroom"
			end
		end
	end

	say "Ready to leave!"
	confirm()
end

function moment_outside()
	background "outside.png"
	sc "Me: Ah! Outside. The bright sun is shining on my face!"
	say "Me: What should I do?"
	ask("a:Go to McDonalds", "b:Go to KFC", "c:Go to BurgerKing")
	sc "Me: That's a good idea, I'll go there."
	-- voice "car_coming.ogg"
	sc "Dude: Oh no, who did I hit!?"
	sc "Dude: I should probably just drive away!"
	-- voice "car_away.ogg"	
	background "heaven.png"
	sc "God: Thank you for playing me.\nI hope you liked it!"
	sc "God: But I'm afraid you're going to hell, sorry."
	sc "The end"
end

function main()
	moment_wakeup()
	moment_getready()
	moment_outside()
end

blocky(true)
main()
quit()