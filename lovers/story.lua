
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
		setsuko = 0,
		takahiro = 0,
	},
	met = {
		itsaku = false,
		sebusan = false,
		abudosan = false,
		durinusu = false,
		setsuko = false,
		takahiro = false,
	},
	day = 1,
	firstTheology = true,
	followedClass = "", --Contains the name of the person whose class you last took
	teammember = "",
	teamname = "",
}

--[[
data.day = 7
data.met.itsaku = true
data.met.sebusan = true
data.met.abudosan = true
data.met.durinusu = true
data.met.setsuko = true
data.met.takahiro = true
data.stats.itsaku = 100

for name, stat in pairs(data.stats) do
	data.stats[name] = -10
end
--]]

function getDay()
	return data.day
end

function setDay(day)
	data.day = day
end

function isSunday()
	return getDay() % 8 == 7
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
	print("Setting met state of " .. person .. " to " .. tostring(bool))
	data.met[person] = bool
end

function getName(person)
	return person:sub(1,1):upper() .. person:sub(2,-1):lower()
end

-- Get the name of the person with the highest romance stat
function getMax()
	local maxname
	local max = -math.huge
	for name, value in pairs(data.stats) do
		if value > max then
			max = value
			maxname = name
		end
	end
	return maxname
end

-- Get the name of the person with the lowest romance stat
function getMin()
	local minname
	local min = math.huge
	for name, value in ipairs(data.stats) do
		if value < min then
			min = value
			minname = name
		end
	end
	return minname
end

-- Returns a list of the names of everyone who the player has already met
-- Or a boolean value if the person has already met with a specific person
function hasMet(person)
	if person then
		return data.met[person]
	else
		local met = {}
		for name, hasmet in pairs(data.met) do
			if hasmet then
				met[#met+1] = name
			end
		end
		return met
	end
end

function getTeamname()
	local teamname = data.teamname
	if teamname == "yankees" then
		return "The Yankees"
	elseif teamname == "bees" then
		return "The Bees"
	elseif teamname == "poptarts" then
		return "The Pop-Tarts"
	elseif teamname == "brain" then
		return "The Brains"
	elseif teamname == "braindead" then
		return "The Braindeads"
	else
		return "The Unnamed"
	end
end

function showImage(person)
	image(getImage(person))
end

-- Get the path to the image of a certain person
function getImage(person)
	if person == "abudosan" then
		return "abudosan.png"
	elseif person == "itsaku" then
		return "itsaku.png"
	elseif person == "sebusan" then
		return "sebusan.png"
	elseif person == "durinusu" then
		return "durinusu.png"
	elseif person == "setsuko" then
		return "setsuko.png"
	elseif person == "takahiro" then
		return "takahiro.png"
	else
		return "customer.png"
	end
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
		image "narrator.png"
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
		elseif name:lower() == "sebastiaan" then
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
	image""
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
			end if hasMet("abudosan") then
				met = met + 1
				text = text .. "\nAbudosan: " .. getRomance("abudosan")
			end if hasMet("setsuko") then
				met = met + 1
				text = text .. "\nSetsuko: " .. getRomance("setsuko")
			end if hasMet("takahiro") then
				met = met + 1
				text = text .. "\nTakahiro: " .. getRomance("takahiro")
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
			if isSunday() then
				sc "Leia: Ah! Sunday. A day of rest."
				sc "Leia: I wonder what the day will bring."
			else
				sc "Leia: Let's go to school!"
			end
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
	sc "Leia: Pf... School's boring!"
	say "Leia: What class should I take?"

	local choices = {}
	if hasMet("itsaku") then
		choices[#choices+1] = "music:Music class"
	end if hasMet("sebusan") then
		choices[#choices+1] = "math:Maths class"
	end if hasMet("durinusu") then
		choices[#choices+1] = "economics:Economics class"
	end if hasMet("abudosan") then
		choices[#choices+1] = "chemistry:Chemistry class"
	end if hasMet("setsuko") then
		choices[#choices+1] = "theology:Theology"
	end if hasMet("takahiro") then
		choices[#choices+1] = "english:English class"
	end
	local o = ask(unpack(choices))
	if o == "music" then
		sc "You listen to the awesome guitar solos of Itsaku."
		setRomance("itsaku", 3)
		data.followedClass = "itsaku"
	elseif o == "math" then
		sc "You watch as Sebastiaan solves some difficult maths problems."
		setRomance("sebusan", 3)
		data.followedClass = "sebusan"
	elseif o == "economics" then
		sc "Durinusu helps you calculate how long it would take for Belgium to pay off its national debt."
		setRomance("durinusu", 3)
		data.followedClass = "durinusu"
	elseif o == "chemistry" then
		sc "You're adding some random chemicals together when suddenly your experiment blows up. Abudosan helps you clean up afterwards."
		setRomance("abudosan", 3)
		data.followedClass = "abudosan"
	elseif o == "theology" then
		if data.firstTheology then
			sc "Leia: I'm going to do something completely random."
			sc "Leia: How about some theology?"
			image "setsuko.png"
			sc "Setsuko: Hey Leia!"
			sc "Leia: Hello Setsuko."
			sc "Setsuko: I didn't know you took theology!"
			sc "Leia: I don't, it's more of a one time thing."
			sc "Setsuko: Oh, okay. Maybe I'll see you around more often."
			data.firstTheology = false
		end
		sc "You and Setsuko learn to summon Satan."
		image ""
		setRomance("setsuko", 3)
		data.followedClass = "setsuko"
	elseif o == "english" then
		sc "Thou shalt listen carefully as thou teacher teaches the fine priniciple of the English tongue."
		setRomance("takahiro", 3)
		data.followedClass = "abudosan"
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
	sc "Director: I also want you to meet Takahiro, the new english teacher."
	--sc "Director: and Katsuro, the newly-graduated musics teacher."
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
		sc "Sebusan: While it might not seem so, I do still have feelings."
		setRomance("sebusan", -4)
	end
	sc "Leia: Oh, I've got to get home for dinner. Bye!"
	sc "Sebusan: Goodbye."
end

function moment_thirdday()
	background("school_podium.png")
	clear()
	fadeout(1)
	say("I've got some time left, with whom should I meet?")
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
		sc "Durinusu: I'm doin' mighty fine, thank you! How are you doin!?"
		sc "Leia: I'm doing fine as well."
		sc "Durinusu: Mighty fine!"
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
	sc "Durinusu: Anyway, I've got to go. There is a lot of homework awaiting my presence."
	image ""
end

function moment_meetabudosan()
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
	sc "Abudosan: Anyway, you can find me most of the times in the chemistry lab working on experiments. I'm only trying to blow up the school."
	sc "Leia: Oh, okay."
	sc "Abudosan: Well, I've got to go back or one of my experiments might literally blow up."
	sc "Leia: Bye!"
	sc "Abudosan: Bye!"
	image ""
end

function moment_fifthday()
	clear()
	background("class.png")
	fadeout(1)
	showImage(data.followedClass)
	local name = getName(data.followedClass)
	sc (name .. ": Hey! Are you coming! Class is already over!")
	sc "Leia: I'm coming, I just have to clean this up."
	sc (name .. ": Look, I don't want to wait all day...")
	sc "Leia: You go on ahead! I'll catch up."
	sc (name .. ": Okay, if you say so.")
	image ""
	sc "Leia: Almost done..."
	sc "(knock) (knock)"
	image "takahiro.png"
	say "???: Hey, I was supposed to drop some documents off here. Is the teacher gone already?"
	--sc "Leia: Oh, he'll be back soon."
	local o = sask("a:Oh, he'll be back soon.", "b:Oh, he'll be ba... Why are you not wearing a shirt?")
	if o == "b" then
		sc "???: Um..."
		sc "???: Why are you looking at my nice and sexy body!?"
		sc "???: Student teacher relationships aren't allowed. So don't look at 'dem muscles!"
		sc "Leia: (I can barely take my eyes of them.)"
		sc "Leia: Anyway, he'll be back soon."
	end
	sc "???: Okay then, I'll just put them here. Will you tell him I placed them on his desk?"
	sc "Leia: Sure! Oh, what's your name?"
	sc "???: The name's Takahiro."
	sc "Takahiro: Bart Takahiro!"
	sc "Leia: Okay, Mr. Takahiro!"
	setMet("takahiro", true)
	sc "Leia: Hey, you teach English class, right?"
	sc "Takahiro: That's right. You can drop by anytime you like!"
	sc "Leia: Okay! Thanks!"
	sc "Takahiro: Well, I'll see you around."
	sc "Leia: You too!"
	image ""
end

function moment_sixthday()
	background("class.png")
	clear()
	fadeout(1)
	sc "Narrator: You are leaving the school when suddenly..."
	sc "???: Auch!"
	sc "Narrator: You turn around to see a girl whose books just fell to the floor."
	image "setsuko.png"
	local o = sask("a:Hey, let me help you with that, okay?", "b:Don't drop your books like that bitch! They're expensive!", "c:(ignore)")
	if o == "a" then
		setMet("setsuko", true)
		sc "???: Oh, thank you! Everyone runs around without looking where they're going."
		sc "Leia: Yeah, I know."
		sc "???: The name's Setsuko by the way."
		sc "Leia: Hi Setsuko."
		sc "Setsuko: Oh, I've really got to go now. My boyfriend's waiting!"
		sc "Leia: Oh, okay. Well, see you around!"
		sc "Setsuko: You too!"
		setRomance("setsuko", 3)
		image ""
	elseif o == "b" then
		sc "???: Oh, so you're one of them, right?"
		sc "Leia: One of whom?"
		sc "???: Those bullies!"
		local ob = sask("a:Yeah, I am. Now get the fuck out!", "b:I like them, but I'm not really a part of them", "c:What!? No! I hate them as much as the next guy!")
		if ob == "a" then
			sc "???: I knew! Well, got to go. I hope I'll never see you again!"
			setRomance("setsuko", -4)
			image ""
		elseif ob == "b" then
			setMet("setsuko", true)
			sc "???: What's that supposed to mean!?"
			sc "Leia: Well, I know them. I have befriended some of them, but I don't hang around with them"
			sc "???: Mmmh..."
			sc "???: Okay..."
			sc "???: I'm Setsuko. You're weird."
			sc "Setsuko: Anyway, I've got to bail. Goodbye."
			setRomance("setsuko", 0)
			image ""
		elseif ob == "c" then
			setMet("setsuko", true)
			sc "???: Good. The enemy of your enemy is your friend."
			sc "Leia: You're completely right!"
			sc "???: The name's Setsuko by the way."
			sc "Leia: Nice to meet you, Setsuko!"
			sc "Setsuko: Nice to meet you too"
			sc "Setsuko: Anyway, I don't have much time left, my bus will arrive soon."
			sc "Leia: Well, bye!"
			sc "Setsuko: Bye!"
			image ""
			setRomance("setsuko", 1)
		end
	elseif o == "c" then
		sc "Narrator: You turn around and leave"
		image ""
	end
end

function moment_seventhday(noleave)
	clear()
	fadeout(1)
	sc "Leia: You know, I'm going to go to the city, see if anything is happening there.'"
	fadein(.5)
	background "city.png"
	clear()
	fadeout(.5)
	sc "Leia: It seems so quite today. That isn't very usual."
	sc "Leia: Let's find a place to eat!"
	sc "(Screeck) Whaa! (boom) What the fuck is that!? (zap)"
	sc "You turn around and see a flash of blinding coloured light in the distance that vanishes almost immidiately."
	say "You see only a car wreck on the street. There is nothing, and no one, else"
	local o = ask("a:Investigate the light", "b:Investigate the car wreck", ((not noleave) and "c:Leave"))
	if o == "a" then
		sc "You decide to investigate the light that came from the distance."
		sc "After walking for a while towards the direction the light came from you see nothing except for a couple of trees."
		sc "Leia: Where did that odd light come from? I can't see anything anywere that could have caused it."
		sc "Leia: I should probably head back home, it's starting to get late."
	elseif o == "b" then
		sc "You walk towards the car wreck. The car is completely wrecked and inside you see a person who isn't moving at all."
		sc "Interestingly, you can see the drivers backpack in the backseat, but also a woman's purse and a second phone in the charger."
		sc "You also see that there is some blood on the steering wheel, but also near the passenger seat."
		sc "However, you don't see any passenger."
		sc "Leia: Oh, the paramedics are arriving, I should probably leave, it's starting to get late anyway."
	elseif o == "c" then
		image "narrator.png"
		sc "Narrator: Really? I am trying to tell a story here! But it doesn't work if you just ignore everything that happens"
		sc "Narrator: So, because you're such a bitch, I'll just redo this part. This time without the leave option."
		fadein(1)
		background "bedroom.png"
		image ""
		return moment_seventhday(true)
	end

	image "narrator.png"
	sc "Narrator: Did that really just happen!?"
	sc "Narrator: Could this be a sign of..."
	sc "Narrator: Of..."
	sc "Narrator: The super natural!?"
	sc "Narrator: Well, I'm not going to tell you."
	sc "Narrator: And if you thought 'I'll check out both the light and the car', well... Have I got a surprise for you!"
	fadein(1)
	background "bedroom_dark.png"
	clear()
	fadeout(1)
	sc "Narrator: I'm not giving you this option! Mwahaha!"
end

function moment_eightday()
	clear()
	fadeout(1)
	sc "Leia: Hey, why are there so many people gathering at the scool podium? I should take a look."
	fadein(.5)
	clear()
	background "school_podium.png"
	fadeout(.5)
	image "director.png"
	sc "Director: Ladies and gentleman. As usual we will be holding the annual sporting games next week."
	sc "Director: A whole week has passed, so you should have had enough time to meet your friends."
	sc "Director: For the games you will have to pick a team member to assist you and a team name."
	sc "Director: That's all. I expect to see you all next week!"
	image ""
	say "Leia: How fun! Who should I bring?"

	local asked = {}
	local member
	local found = false

	while not found do
		local options = {}
		print("Enumerating annual sporting game team member possibilities")
		for _, name in ipairs(hasMet()) do
			if not asked[name] and name ~= "takahiro" then
				options[#options+1] = name .. ":" .. getName(name)
				print(options[#options])
			end
		end

		if #options <= 0 then
			sc "???: Hey, have you found some yet?"
			sc "Leia: Who's there?"
			image "takahiro.png"
			sc "Takahiro: I am!"
			sc "Leia: Hey sexy! I've already asked some people, but they had already found someone."
			sc "Takahiro: Well, I'm still free!"
			sc "Leia: Oh, (blush), I would sure like to go with you!"
			sc "Takahiro: Together we will conquer everyone and win."
			sc "Leia: Yay!"
			sc "Takahiro: Anyway, I've get to get home. There are a lot of tests that won't correct themselves!"
			sc "Leia: Bye!"
			sc "Takahiro: Bye!"
			image ""
			member = "takahiro"
			found = true
			setRomance("takahiro", 1)
		else
			member = ask(options)
			local name = getName(member)
			local stat = getRomance(member)

			sc ("Leia: I should ask " .. name .. ".")
			image(getImage(member))
			sc "Leia: Oh, here he is! Hey!"
			if stat < -1 then
				sc (name .. ": Hello.")
				sc "Leia: Would you like to come with me to the sporting festival?"
				sc (name .. ": With you? No, I don't.")
				sc "Leia: Why not?"
				sc (name .. ": Because you're mean to me!")
				sc (name .. ": And even then, someone has already asked me to come.")
				sc "Leia: Oh, okay."
				sc (name .. ": Bye.")
				sc "Leia: Bye."
				image ""
				sc "Leia: Guess I'll need to pick someone else then."
				asked[member] = true
			elseif stat < 1 then
				sc (name .. ": Hey!")
				sc "Leia: Would you like to come with me to the sporting festival?"
				if math.random() < .5 then
					sc (name .. ": Oh, sorry. Someone has already asked me. Thanks though.")
					sc "Leia: Oh, no problem. I'll find someone else."
					asked[member] = true
				else
					sc (name .. ": Oh thanks! No one has asked me yet!")
					sc "Leia: So you're going with me?"
					sc (name .. ": Totally!")
					sc "Leia: Thanks!"
					sc (name .. ": Well, I've got to go home. It's quite late already. Bye!")
					sc "Leia: Bye! See you next week!"
					image ""
					setRomance(member, 1)
					found = true
				end
			else
				sc (name .. ": Hey there!")
				sc "Leia: Would you like to come with me to the sporting event?"
				sc (name .. ": Hell yeah!")
				sc "Leia: Great!"
				sc (name .. ": Well, I've got to go home. It's quite late already. Bye!")
				sc "Leia: Bye! See you next week!"
				image ""
				setRomance(member, 2)
				found = true
			end
		end
	end
	sc ("You selected " .. getName(member) .. " as your team member.")
	data.teammember = member
	sc "Now, a slightly less important question."
	say "What will your team name be?"
	local o = ask("yankees:The Yankees", "bees:The Bees", "poptarts:The Pop-Tarts", "brain:The Brains", "braindead:The Braindeads")
	data.teamname = o
	sc ("You selected " .. getTeamname() .. " as your teamname.")
end

function moment_ninthday()
	clear()
	background "school_podium.png"
	fadeout(1)
	local person = getMax()
	local name = getName(person)
	showImage(person)
	sc (name .. ": Hey! How are you doing?")
	sc "Leia: Oh, I'm doing fine!"
	if data.teammember == person then
		sc (name .. ": Thanks for asking me yesterday.")
		sc (name .. ": I was starting to think I wouldn't find anyone!")
		local o = sask("a:(blush)", "b:(blush more)", "c:(blush a lot)", "d:I was always going to pick you!", "e:You were last on my list!")
		if o == "a" or o == "b" or o == "c" then
			sc (name .. ": Heh. Anyway, thanks again!")
			sc "Leia: No problem."
			sc (name .. ": Guess I'll see you next week!")
			sc "Leia: Okay, bye!"
			image ""
			setRomance(person, 2)
		elseif o == "d" then
			sc (name .. ": Oh, (blush), you so sweet!")
			sc "Leia: ..."
			sc (name .. ": Well, I guess I'll see you next week!")
			sc "Leia: See you then sexy, bye!"
			sc (name .. ": Bye!")
			image ""
			setRomance(person, 4)
		elseif o == "e" then
			sc (name .. ": Really? I was?")
			sc "Leia: Sorry pal."
			sc (name .. ": No no, it's okay.")
			sc "Leia: I hope I didn't hurt your feeling too much."
			sc (name .. ": I understand. Anyway, I'm going home. I've got a lot of homework.")
			sc "Leia: Bye."
			sc (name .. ": See you next week.")
			image ""
			setRomance(person, -2)
		end
	else
		sc (name .. ": Hey, I tried to find you yesterday, but I couldn't. Where were you yesterday?")
		sc "Leia: Oh, sorry. I didn't know you were looking for me."
		say (name .. ": I wanted to ask you if you could be on my team for the sporting event.")
		local teamname = getName(data.teammember)
		local o = sask("a:Well, I am actually already going with " .. teamname .. ", sorry.",
			"b:I though I asked you.", "c:Why would I ever ask you?")
		if o == "a" then
			sc (name .. ": Oh, I didn't know.")
			sc "Leia: I'm truly sorry!"
			sc (name .. ": No, it's no problem.")
			sc "Leia: We good?"
			sc (name .. ": Yeah, we good.")
			sc "Leia: Oh, my bus will arrive soon. See you tomorrow?"
			sc (name .. ": Sure, see you tomorrow.")
			setRomance(name, -1)
		elseif o == "b" then
			sc (name .. ": You didn't!")
			sc "Leia: I really thought I did!"
			sc (name .. ": Why do I think you're lying?")
			sc "Leia: Hey, there's always next year! Besides, there will be plenty more occassions choose each other."
			sc (name .. ": Are you serious? Well, I'm going with Katsuro, no thanks to you!")
			sc (name .. ": Oh shoot! I have to be home soon. Bye!")
			sc "Leia: Bye!"
			image ""
			setRomance(name, -3)
		elseif o == "c" then
			sc (name .. ": What!")
			sc "Leia: No really, who would want to be in a team with you?"
			sc (name .. ": You! You didn't just say that!")
			sc "Leia: Oh, what are you going to do? Cry?"
			sc (name .. ": I might!")
			sc "Leia: Well boo fucking hoo! Go on! Cry! Cry like a little bitch!"
			sc (name .. ": You! Fuck you!")
			sc "Leia: Oh, fuck me? Can't you come up with something better than 'fuck you'? You're pathetic!"
			sc (name .. ": Whaah!!!!!")
			image ""
			sc "Leia: Perhaps I was a bit too harsh on him."
			setRomance(name, -15)
		end
	end
end

function moment_schooltalk()
	local day = getDay()
	if day == 1 then
		moment_firstday()  -- Monday
	elseif day == 2 then
		moment_secondday() -- Tuesday
	elseif day == 3 then
		moment_thirdday() -- Wednesday
	elseif day == 4 then
		clear() -- Thursday
		background("school_podium.png")
		fadeout(1)
		if hasMet("durinusu") then
			moment_meetabudosan()
		else
			moment_meetdurinusu()
		end
	elseif day == 5 then
		moment_fifthday() -- Friday
	elseif day == 6 then
		moment_sixthday() -- Saturday
	elseif day == 7 then
		moment_seventhday() -- Sunday
	elseif day == 8 then
		moment_eightday() -- Monday
	elseif day == 9 then
		moment_ninthday() -- Tuesday
	elseif day == 10 then
		-- Wednesday
	elseif day == 11 then
		-- Thursday
	elseif day == 12 then
		-- Friday
	elseif day == 13 then
		-- Saturday
	elseif day == 14 then
		-- Sunday
	elseif day == 15 then
		-- Monday
		-- Also sporting event!
	end
	fadein(1)
end

function main()
	clear()
	--lockName "Abdellah"
	--lockName "Isaak"
	fadein(0)
	music "normal.ogg"
	moment_intro()
	while true do
		print("It's day " .. getDay())
		moment_home()
		if getLocation() == "school" then
			if getDay() == 1 then
				moment_schooltalk()
			elseif isSunday() then
				moment_schooltalk() -- Weekends
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
