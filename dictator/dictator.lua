
function sc(...)
	say(...)
	confirm()
end

function scc(...)
	say(...)
	confirm()
	clear()
end


location = "butcher"
playerHasMoney = false
playerHasMeat = false
playerHasAcid = false
playerHasBomb = false
customerAlive = true
pilotAlive = true
pilotHasMoney = true
panic = false
randomBomb = false

function butcher()
	local o
	local inButcher = true

	background "butchers.png"
	while inButcher do
		say "You are at the butcher"

		if customerAlive then
			o = ask("a:Buy meat", "b:Talk to customer", "c:Leave")
		else
			o = ask("a:Buy meat", "c:Leave")
		end

		if o == "a" then
			say "Butcher: Good evening sir! What would you like?"
			ask("a:Some steak", "b:A meat loaf")
			say "Butcher: Okay sir, that will be 10$"
			if playerHasMoney then
				ask "a:Give 10$"
				sc "Thank you, and here is you purchase."
				playerHasMoney = false
				playerHasMeat = true
			else
				ask "a:<No money>"
				sc "Me: I have no money."
				say "Butcher: Then I can't give you anything."
				o = ask("a:Do nothing", "b:Execute butcher")
				if o == "b" then
					say "Me: I'm going to call someone who is going to kill you!"
					o = ask("a: Do nothing", "b:Call 202-555-0180")
					if o == "b" then
						sc "You notice that you phone's battery is dead."
					end
				end
			end
		elseif o == "b" then
			say "Customer: Haven't I seen you on TV?"
			o = ask("y:Yes", "n:No", "i:Ignore")
			if o == "y" or o == "n" then
				say "Customer: Yeah, I recognize you, the angry guy with the beard."
				o = ask("a:Execute customer", "i:Ignore")
				if o == "a" then
					sc "You grab the customer's backpack and hit him to death with it."
					customerAlive = false
				end
			end
		elseif o == "c" then
			inButcher = false
		end
	end
end

function mansion()
	local o
	local inMansion = true

	while inMansion do
		say "You are in your mansion."
		o = ask("c:Take chopper to work", "s:Go to sleep", "d:Call someone", "l:Leave")

		if o == "l" then
			inMansion = false
		elseif o == "c" then
			if not pilotAlive then
				sc "Sorry, but you killed the pilot."
			else
				say "Pilot: We can't fly today, the chopper is broken."
				o = ask("t:Take his money", "e:Execute him and take his money", "f:Forgive him")
				if o == "t" then
					if pilotHasMoney then
						sc "You take the pilot his wallet and look inside. You find 10$."
						pilotHasMoney = false
						playerHasMoney = true
					else
						sc "You already took the pilot his money."
					end
				elseif o == "e" then
					if pilotHasMoney then
						sc "You kill the pilot and then look through his wallet. You find 10$."
					else
						sc "You kill the pilot and then look through his wallet. You don't find anything."
					end
					pilotHasMoney = false
					playerHasMoney = true
					pilotAlive = false
				elseif o == "f" then
					-- Do nothing
				end
			end
		elseif o == "s" then
			sc "You're not sleepy yet"
		elseif o == "d" then
			say "Who you gonna call!?"
			o = ask("a:911", "b:202-555-0198", "c:202-555-0147", "d:Ghostbusters!", "e:Go back")
			if o == "a" then
				say "Operator: 911, what is your emergency!?"
				o = ask("a:I'm going to kill myself!", "b:I'm going to kill you!",
					"c:You're going to kill me!", "d:You're going to kill yourself!", "e:The president must die!")
				if o == "a" then
					sc "Operator: Sir, pleast stay where you are, we are going to *click*"
				elseif o == "b" then
					sc "Operator: Sir, I'm sending the police to you, please stay where you *click"
				elseif o == "c" then
					sc "Operator: Is that supposed to be a threat, because if it is, it is a bad one. *click*"
				elseif o == "e" then
					sc "Operator: What! Hang on... *click*"
					panic = true
				end
			elseif o == "b" then
				say "Chemist: This is Billy the chemist. How can I help you?"
				o = ask("a:I want to buy a bomb.", "b:I want to buy H2SO4.", "c:I want to execute you.")
				if o == "a" then
					sc "Chemist: Sorry, we don't sell bombs. *click*"
				elseif o == "b" then
					if playerHasAcid then
						sc "Chemist: Sorry, but you already have bought some H2SO4. *click*"
					else
						sc "Chemist: Okay, I'll send some to your place. *click*"
						playerHasAcid = true
					end
				elseif o == "c" then
					say "Chemist: What? I'll just ignore that. *click*"
				end
			elseif o == "c" then
				say "I don't know whose number this is."
				o = ask("a:Call anyway", "b:Nevermind")
				if o == "a" then
					sc "???: Bomb detonated succesfully"
					randomBomb = true
				end
			elseif o == "d" then
				sc "Sadly, 'Ghostbusters!' isn't a valid phone number"
			end
		end
	end
end

function embassy()
	local o
	local inEmbassy = true
	
	background "lobby.png"
	while inEmbassy do
		if panic then
			say(table.concat {"You enter the embassy. As you look around you notice a panic. Apparently some called",
			 "in a death threat to the president using 911. The president is in the meeting room"})
		else
			say "You enter the embassy"
		end

		o = ask("a:Check for e-mail", "b:Talk to secretary", "c:Enter personal only area", "d:Enter meeting room", "e:Leave")
		if o == "a" then
			sc "You only have one message. It reads: 'Your objective is: kill the president'"
		elseif o == "b" then
			say "Secretary: Hello"
			o = ask "a:Hello", "b:Leave"
			if o == "a" then
				sc "You say hi, but she seems quite busy and does not respond."
			end
		elseif o == "c" then
			if not randomBomb then
				sc "Guard: Sorry, you can't come in here."
			else
				say "You enter the personal only area."
				o = ask("a:Leave", "b:Create bomb")
				if o == "b" then
					if playerHasBomb then
						sc "You already have a bomb."
					elseif playerHasAcid and playerHasMeat then
						sc "You have successfully crafted a bomb."
						playerHasBomb = true
					elseif not playerHasMeat and not playerHasAcid then
						sc "You still need acid and meat. (Don't ask about the meat)"
					elseif not playerHasMeat then
						sc "You still need meat. (Don't ask)"
					elseif not playerHasAcid then
						sc "You still need acid."
					end
				end
			end
		elseif o == "d" then
			if not panic then
				sc "There is not much to do here, and so you leave."
			else
				say "You have entered the meeting room."
				if playerHasBomb then
					o = ask("a:Detonate bomb", "b:Leave")
				else
					o = ask("b:Leave")
				end

				if o == "a" then
					sc(table.concat {"You place the bomb in the meeting room and leave. Not soon after you hear a loud explosion.",
						"As you look back you see that the meeting room is gone. You try to run away but you trip over",
						"the president's decapited head."})
					sc "Congratulations!! You won the game!!"
					sc "This is the last message. After this one the game will automatically close itself."
					quit()
				end
			end
		elseif o == "e" then
			inEmbassy = false
		end
	end
end

function city()
	local o
	while true do
		if location == "butcher" then
			butcher()
		elseif location == "mansion" then
			mansion()
		elseif location == "embassy" then
			embassy()
		end

		background "city.png"
		say "You find yourself in a city"
		o = ask("b:Enter butchers", "m:Go to your mansion", "e:Go to the embassy")
		if o == "b" then
			location = "butcher"
		elseif o == "m" then
			location = "mansion"
		elseif o == "e" then
			location = "embassy"
		end
	end
end

city()
quit()