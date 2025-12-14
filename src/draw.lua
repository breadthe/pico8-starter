function draw_game()
	cls()
end

function draw_start()
	cls(1)
	print("spaceship game", 35, 40, 12)
	spr(1, 60, 60)
	print("press any key to start", 20, 80, blink())
end

function draw_over()
	timers = {}
	last_time = 0

	cls(8)
	print("game over", 46, 40, 2)
	print("game over", 47, 41, 10)

	rectfill(41, 56, 89, 76, 14)
	rectfill(40, 55, 88, 75, 2)
	print("score:" .. score, 42, 57, 10)
	print("kills:" .. kills, 42, 67, 10)

	if score > high_score then
		print("new high score:" .. score, 29, 86, 2)
		print("new high score:" .. score, 30, 87, 12)
	else
		print("high score:" .. high_score, 38, 87, 14)
	end

	print("press any key to continue", 20, 105, 7)
end
