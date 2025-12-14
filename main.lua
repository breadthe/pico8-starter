function _init()
	mode = "start"

	-- (OPTIONAL) load cart data
	-- cart_id = "breadthe_XXXX_v1"
	-- cartdata(cart_id)
end

function _update()
	if mode == "game" then
		update_game()
	elseif mode == "start" then
		update_start()
	elseif mode == "over" then
		update_over()
	end
end

function _draw()
	if mode == "game" then
		draw_game()
	elseif mode == "start" then
		draw_start()
	elseif mode == "over" then
		draw_over()
	end
end

function start_game()
	mode = "game"

	sprites = {
	}

	sounds = {
	}

	add_repeat_timer(2, spawn_random_enemy)
	add_repeat_timer(1, regenerate_ship_energy)
end
