function moment_meetabudosan()
	image "sebusan.png"
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
	if o == "a" thend
		setRomance("abudosan", 3)
	elseif o == "b" then
	elseif o == "c" then
		setRomance("abudosan", -8)
	end
	sc "(Note to self: Gotta work on this part some more...)"
end
