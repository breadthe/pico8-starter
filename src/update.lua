function update_game()
	handle_buttons()

	-- do stuff or run function that calls handle_game_over()

	execute_timers()
end

function update_start()
	if btnp(4) or btnp(5) then
		start_game()
	end
end

function update_over()
	if btnp(4) or btnp(5) then
		mode = "start"
	end
end

function handle_buttons()
	-- left button
	if btn(0) then
		-- do stuff
	end

	-- right button
	if btn(1) then
		-- do stuff
	end

	-- up button
	if btn(2) then
		-- do stuff
	end

	-- down button
	if btn(3) then
		-- do stuff
	end

	-- shift+o=🅾️=4=z,c,n
	if btnp(4) then
		-- do stuff
	end

	-- shift+x=❎=5=x,v,m
	if btnp(5) then
		-- do stuff
	end
end

function handle_game_over()
	if lives <= 0 then
		high_score = dget(0)

		if score > high_score then
			dset(0, score)
		end

		mode = "over"
	end
end
