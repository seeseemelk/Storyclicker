
function scc(...)
	say(...)
	confirm()
	clear()
end

function sc(...)
	say(...)
	confirm()
end

local data = {
	version = 1,
	name = "",
	location = "home",
	stats = {
		itsaku = 0,
		sebusan = 0,
		abudosan = 0,
		durinusu = 0,
	},
	met = {
		itsaku = false,
		sebusan = false,
		abudosan = false,
		durinusu = false,
	},
	day = 1
}

function getDay()
	return data.day
end

function setDay(day)
	data.day = day
end

function setRomance(person, delta)
	data.stats[person] = data.stats[person] + delta
end

function getRomance(person)
	return data.stats[person]
end

function setLocation(location)
	data.location = location
end

function getLocation()
	return data.location
end

function setMet(person, bool)
	data.met[person] = bool
end

function hasMet(person)
	return data.met[person]
end

function lockName(person)
	if person == "Abdellah" or person == "Isaak" or
		person == "Drini" or person == "Selina" or
		person == "Jan" or person == "Sebastiaan" then
			name = person
	else
		(nil)()
	end
end

function sask(...)
	local c = {...}
	local o = ask(...)
	for index, fulltext in ipairs(c) do
		local name = fulltext:match("^(.-):") or " "
		local text = fulltext:match(":(.*)$")
		if name == o then
			sc("Leia: " .. text)
			return o
		end
	end
	return o
end

function moment_intro()
	local o

	background "intro.png"
	fadeout(5)
	sleep(3)
	fadein(5)

	background "heaven.png"
	fadeout(5)
	if name == nil then
		sc "Hello, and welcome to Super Lover Fun!!!"
		sc "First, I need to know your name."
		say "So choose your name in the list below."
		o = ask("a:Abdellah", "i:Isaak", "d:Drini", "j:Jan", "sl:Selina", "sb:Sebastiaan", "o:Something else")
		if o == "o" then
			sc "Oh no! You're actually not allowed to play this game, sorry!"
			save({true}, "license")
			quit()
		elseif o == "a" then
			name = "Abdellah"
		elseif o == "i" then
			name = "Isaak"
		elseif o == "d" then
			name = "Drini"
		elseif o == "sl" then
			name = "Selina"
		elseif o == "j" then
			name = "Jan"
		elseif o == "sb" then
			name = "Sebastiaan"
		end
		sc ("Hi " .. name .. ", nice to see you! ")
	else
		sc ("Hello " .. name .. ", and welcome to Super Lover Fun!!!")
		if name:lower() == "abdellah" then
			sc "So, you've played this before. I think I might have added some content since you last played it..."
			sc "But I'm not really sure to be honest."
		elseif name:lower() == "isaak" then
			sc "I've told you about this game while we were on a dangerous quest for some iPads"
			sc "and here it finally is."
			sc "Note that it isn't finished yet, but it still fun."
			sc "Or at least, i think so"
		elseif name:lower() == "sebusan" then
			sc "Hello me!"
		else
			error("I don't know who you are!")
		end
		sc "Anyway, here you go. Oh, also don't send this copy to anyone."
		sc "I'm creating personalized intro messages for everyone"
	end
	sc "Now, you will not be playing this game as yourself, but as a girl called..."
	sc "Leia!"
	sc "Are you ready!?"
	sc "The game will begin..."
	if saveexists("license") then
		local license = load("license")[1]
		if license then
			sc "Never, because you didn't get permission to play it!"
			quit()
		end
	end
	sc "Right after you click ok!"
	fadein(1)
	clear()
end

function moment_home()
	local exit = false
	background "bedroom_dark.png"
	image ""
	clear()
	fadeout(1)
	sc "Leia: Ah, home sweet home."
	while not exit do
		say "Leia: So, what should I do?"
		local o = ask("save:Save the game", "load:Load the last save", "d:Dream about the boys", "s:Sleep and go to school")
		if o == "d" then
			local text = "Dreamy voice: Your current romance stats are..."
			local met = 0
			if hasMet("itsaku") then
				met = met + 1
				text = text .. "\nItsaku: " .. getRomance("itsaku")
			end if hasMet("sebusan") then
				met = met + 1
				text = text .. "\nSebusan: " .. getRomance("sebusan")
			end if hasMet("durinusu") then
				met = met + 1
				text = text .. "\nDurinusu: " .. getRomance("durinusu")
			end
			if met > 0 then
				sc(text)
			else
				sc "Dreamy voice: The only boy I can dream about is my dad..."
			end
		elseif o == "s" then
			exit = true
			setLocation("school")
			fadein(1.5)
			clear()
			background "bedroom.png"
			fadeout(1.5)
			sc("Day " .. getDay() .. "...")
			sc("Leia: Let's go to school!")
			fadein(1)
		elseif o == "save" then
			say "Saving the game..."
			save(data, "profile")
			sc "Saved the game!"
		elseif o == "load" then
			say "Loading the last save..."
			if saveexists("profile") then
				data = load("profile")
				sc "Loaded the last save!"
			else
				sc "There is no save!"
			end
		end
	end
end

function moment_schoolclass()
	clear()
	background("class.png")
	fadeout(1)
	sc "Leia: Ph... School's boring!"
	say "Leia: What class should I take?"

	local choices = {}
	if hasMet("itsaku") then
		choices[#choices+1] = "music:Music class"
	end if hasMet("sebusan") then
		choices[#choices+1] = "math:Maths class"
	end if hasMet("durinusu") then
		choices[#choices+1] = "economic:Economics class"
	end
	local o = ask(unpack(choices))
	if o == "music" then
		sc "You listen to the awesome guitar solos of Itsaku."
		setRomance("itsaku", 3)
	elseif o == "math" then
		sc "You watch as Sebastiaan solves some difficult maths problems."
		setRomance("sebusan", 3)
	elseif o == "economic" then
		sc "Durinusu helps you calculate how long it would take for Belgium to pay off its national debt."
		setRomance("durinusu", 3)
	end

	sc "Leia: It's late, I'm going to see my friends and then I'll go home."
	fadein(1)
end

function moment_firstday()
	background "school_podium_backtoschool.png"
	clear()
	fadeout(1)
	sc "Leia: Oh, it's the first day of school, the summer vacation felt so short. :-("
	image "director.png"
	sc "Director: Welcome students, to the beginning of a new year!"
	sc "Director: This will be an action packed year filled with fun activities."
	sc "Director: I also want you to meet Takahiro, the new math teacher..."
	sc "Director: and Katsuro, the newly-graduated musics teacher."
	sc "Director: The first day there aren't going to be any classes yet, so you can meet your new friends."
	sc "Director: However, tomorrow classes will begin!"
	image ""
	sc "Leia: I hope this year will be fun."

	sc "???: Hey you there! Yes you!"
	image "itsaku.png"
	sc "???: What's your name?"
	sc "Leia: I'm Leia, and you?"
	sc "???: I'm Itsaku, you look nice!"
	sc "Leia: Um, thanks, I guess."
	say "Itsaku: You should come to music class tomorrow, I'm going to pull off some slick guitar solos!"
	setMet("itsaku", true)
	local o1 = "I would love to come!"
	local o2 = "Perhaps, I don't know yet."
	local o3 = "Nah, I've got better things to do than to listen to your boring guitar solos!"
	local o = ask("a:"..o1, "b:"..o2, "c:"..o3)
	if o == "a" then
		sc ("Leia: " .. o1)
		sc "Itsaku: Great! Can't wait until tomorrow!"
		setRomance("itsaku", 2)
	elseif o == "b" then
		sc ("Leia: " .. o2)
		sc "Itsaku: Oh, well I do hope you'll come."
	elseif o == "c" then
		sc ("Leia: " .. o3)
		sc "Itsaku: That's mean!"
		setRomance("itsaku", -2)
	end
	sc "Itsaku: Anyway, I've got to bail, there are a lot of people to meet."
	sc "Leia: Bye!"
	image ""
	sc "**TRIIiiiIIIiiING**"
	sc "Leia: Oh goodness! The bell! It's time to go home! I wonder what the next day will bring."
end

function moment_secondday()
	background("school_podium.png")
	clear()
	fadeout(1)
	sc "???: Hey Leia!"
	image "itsaku.png"
	say "Itsaku: There is someone you should meet."
	local o = ask("a:Not interested", "b:Oh, who?")
	if o == "a" then
		if getRomance("itsaku") < 0 then
			sc "Itsaku: I don't really like you, but for the sake of the story you're going to meet him anyway!"
			setRomance("itsaku", -1)
		else
			sc "Itsaku: No no no, with that attitude you're not going to make any friends! You're going to meet him."
		end
	else
		if getRomance("itsaku") < 0 then
			sc "Itsaku: You know, the way you acted yesterday makes me a bit hesitant to let you two meet."
			sc "Itsaku: I guess you'll meet anyway sooner or later, so why not now."
		else
			sc "Itsaku: Great! You are going to love this person!"
			setRomance("itsaku", 1)
		end
	end
	image ""
	sc "Itsaku: Meet..."
	image "sebusan.png"
	sc "Itsaku: Sebusan!"
	say "Sebusan: Hi!"
	setMet("sebusan", true)
	o = ask("a:Hi!", "b:(Ignore)")
	if o == "a" then
		sc "Leia: Hi!"
	elseif o == "b" then
		sc "Sebusan: Um, hello!?"
		setRomance("sebusan", -3)
		sc "Sebusan: Um, anyway..."
	end
	sc "Sebusan: I'm Sebusan, nice to meet you."
	sc "Sebusan: Itsaku told me you liked his guitar showoffs."
	sc "Sebusan: I actually prefer maths."
	say "Sebusan: Currently I'm working on calculating how often you have to stab a human being in the chest on average before he dies! Really interesting stuff."
	o = ask("a:Wow, that's fascinating!", "b:Do you study it vicarously or emotionlessly?", "c:Itsaku, is he always this creepy?")
	if o == "a" then
		sc "Leia: Wow, that's fascinating!"
		sc "Sebusan: Finally someone who agrees with me! "
		setRomance("sebusan",  1)
	elseif o == "b" then
		sc "Leia: Do you study it vicarously or emotionlessly?"
		sc "Sebusan: Emotionlessly of course, it wouldn't be much fun otherwise."
	elseif o == "c" then
		sc "Leia: Itsaku, is he always this creepy?"
		image "itsaku.png"
		sc "Itsaku: Sometimes. It mostly depends on his mood."
		setRomance("sebusan", -2)
		image "sebusan.png"
	end
	sc "Sebusan: Anyway, you should come to maths class."
	say "Sebusan: You might even learn something about number theory!"
	o = ask("a:Sure, I'll come.", "b:I don't know yet.", "c:Maths! Haha! You must be crazy to like that boring course!")
	if o == "a" then
		sc "Leia: Sure, I'll come. Maths does sound quite interesting."
		sc "Sebusan: That's the spirit!"
		setRomance("sebusan", 1)
	elseif o == "b" then
		sc "Leia: I don't know yet. I've still got a lot to do."
		sc "Sebusan: A lot to do? Now? School just started, we've got no homework yet."
		sc "Sebusan: Well, I haven't got any. I'll let you to it."
	elseif o == "c" then
		sc "Leia: Maths! Haha! You must be crazy to like that boring course! Never in my live would I take that course willingly!"
		sc "Sebusan: While it might not seem like it, I do still have feelings."
		setRomance("sebusan", -4)
	end
	sc "Leia: Oh, I've got to get home for dinner. Bye!"
	sc "Sebusan: Goodbye."
end

function moment_thirdday()
	background("school_podium.png")
	clear()
	fadeout(1)
	say("I've got some time left, with who should I meet?")
	local o = ask("itsaku:I should meet with Itsaku", "sebusan:I should meet with Sebusan")
	if o == "itsaku" then
		moment_meetdurinusu()
	else
		moment_meetabudosan()
	end
end

function moment_meetdurinusu()
	sc "Leia: Hey, Itsaku!"
	image "itsaku.png"
	sc "Itsaku: Hey Leia, good to see you."
	sc "Leia: So, what have you been up to?"
	sc "Itsaku: I've mostly been practising the guitar."
	sc "Itsaku: Hey you should meet Durinusu!"
	image "durinusu.png"
	setMet("durinusu", true)
	say "Durinusu: Howdy partner! How you doin'?"
	local o = ask("a:I'm doing fine, and you?", "b:Are you from Texas?", "c:Are you a Muslim?", "d:Are you an anti-Semite?")
	if o == "a" then
		sc "Durinusu: I'm doin' mighty fine, thank you!"
		setRomance("durinusu", 1)
	elseif o == "b" then
		say "Durinusu: No, I'm not. Though I wish I was. Did you really not notice?"
		o = ask("a:No, not at all!", "b:It was quite convincing.", "c:I was making fun of you!")
		if o == "a" then
			sc "Leia: No, not at all!"
			sc "Durinusu: Thank you. I've been practising all summer."
			setRomance("durinusu", 4)
		elseif o == "b" then
			sc "Leia: It was quite convincing."
			sc "Durinusu: I guess I should practise a little more then."
			setRomance("durinusu", 3)
		elseif o == "c" then
			sc "Leia: I was making fun of you!"
			sc "Durinusu: Fuck you!"
			setRomance("durinusu", -2)
		end
	elseif o == "c" then
		sc "Leia: Are you a Muslim?"
		sc "Durinusu: What? How did you know that?Hey h racial slur to me you're going to meet with the end of my 12-Gauge. And it won't be the butt end!"
		sc "Durinusu: What! You think I'm one of those stupid idiot jews! How dare you talk to me like that! Some day you might meet  with the end of my 12-Gauge. And it won't be the butt end!"
		setRomance("durinusu", -5)
	elseif o == "d" then
		sc "Leia: Are you an anti-Semite?"
		sc "Durinusu: What! If you dare speak such racial slur to me you're going to meet with the end of my 12-Gauge. And it won't be the butt end!"
		setRomance("durinusu", -5)
	end
	sc "Durinusu: Anyway, I've got to go. There is a lot of homework waiting for my presence"
	image ""
end

function moment_meetabudosan()
	--[[image "sebusan.png"
	sc "Leia: Hi Sebusan."
	sc "Sebusan: Hi Leia, I would like you to meet Abudosan."
	if name ~= "Abdellah" then
		sc "Leia: Who's Abudosan?"
		sc "Sebusan: He's right in front of you."
		sc "Leia: I don't see him."
		sc "Abudosan: I'm down here!"
		image "abudosan.png"
		sc "Leia: Oh, there you are. I hadn't seen you."
	else
		sc "Leia: Okay, where is he?"
		sc "Sebusan: He's right here."
		image "abudosan.png"
		sc "Abudosan: Hi!"
		sc "Leia: Hello."
	end
	sc "Abudsan: I don't really know if you follow chemistry, but if you ever want to find me I'll probably be in the lab."
	local o = ask("a:I luv chemistry <3", "b:I'm not really into science to be honest with you", "c:What! Are you making bombs! I knew it! You're a terrorist!")
	if o == "a" then
		setRomance("abudosan", 3)
	elseif o == "b" then
	elseif o == "c" then
		setRomance("abudosan", -8)
	end
	sc "(Note to self: Gotta work on this part some more...)"
	--]]
	image "sebusan.png"
	sc "Sebusan: Hey Leia, how are you?"
	sc "Leia: I'm fine! You?"
	sc "Sebusan: As fine as I'll ever be."
	sc "Leia: So what have you been up to recently?"
	say "Sebusan: I've been working on some science projects with Abudosan."
	local o = sask("a:Oh, Abudosan.", "b:Never heard of him.")
	if o == "a" then
		sc "Sebusan: So you've met him then."
		sc "Leia: Well, not yet."
		sc "Sebusan: He's not right here at the moment, but he should arrive shortly."
	elseif o == "b" then
		sc "Sebusan: No, well he'll be here shortly. You can meet him then."
	end
	image "abudosan.png"
	sc "Abudosan: Hey Sebusan!"
	setMet("abudosan", true)
	image "sebusan.png"
	sc "Sebusan: Oh, you're back. You should meet Leia."
	image "abudosan.png"
	say "Abudosan: Oh realy? Nice to meet you, Leia."
	local o = sask("a:Nice to meet you!", "b:Eat shit and die!", "c:Narrator, do I really have to go through all these boring conversations?")
	if o == "a" then
		sc "Abudosan: Nice to meet you to!"
		setRomance("abudosan", 2)
	elseif o == "b" then
		sc "Abudosan: Fuck you!"
		setRomance("abudosan", -3)
	elseif o == "c" then
		image "narrator.png"
		sc "Narrator: Look, If you don't like this game, DON'T PLAY IT. I'm not going to change the story just because you don't like it."
		sc "Narrator: Now I have to make up something for Abudosan to say. Hmm, I've got an idea!"
		image "abudosan.png"
		sc "Abudosan: Thank you, how polite of you."
		image "narrator.png"
		sc "Narrator: Wait, that doesn't quite fit the story. Let me change this."
		image "abudosan.png"
		sc "Abudosan: Eat shit and die!"
		image "narrator.png"
		sc "Narrator: Damn, wrong again. Hang on, this time I'll get it right."
		image "abudosan.png"
		sc "Abudosan: You don't say much, do you."
		image "narrator.png"
		sc "Narrator: That's better!"
		image "abudosan.png"
		sc "Abudosan: That's okay."
	end
	sc "Abudosan: Anyway, you can find me most of the times in the Chemistry lab working on experiments. I'm only trying to blow up the school."
	sc "Leia: Oh, okay."
	sc "Abudosan: Well, I've got to go or one of my experiments will literally blow up."
	sc "Leia: Bye!"
	sc "Abudosan: Bye!"
	image ""
end

function moment_schooltalk()
	local day = getDay()
	if day == 1 then
		moment_firstday()
		fadein(1)
	elseif day == 2 then
		moment_secondday()
		fadein(1)
	elseif day == 3 then
		moment_thirdday()
		fadein(1)
	elseif day == 4 then
		clear()
		fadeout(1)
		if hasMet("durinusu") then
			moment_meetabudosan()
		else
			moment_meetdurinusu()
		end
	end
end

function main()
	clear()
	--lockName "Abdellah"
	lockName "Isaak"
	fadein(0)
	music "normal.ogg"
	moment_intro()
	while true do
		print("It's day " .. getDay())
		moment_home()
		if getLocation() == "school" then
			if getDay() == 1 then
				moment_schooltalk()
			else
				moment_schoolclass()
				moment_schooltalk()
			end
			setLocation("home")
		end
		setDay(getDay() + 1)
	end
end

blocky(true)
main()
quit()
