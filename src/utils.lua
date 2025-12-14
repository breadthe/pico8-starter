function blink()
	local anim = { 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 7, 7, 6, 6, 5, 5 }

	if blink_t > #anim then
		blink_t = 1
	end

	return anim[blink_t]
end

function draw_sprite(sprite)
	spr(sprite.spr, sprite.x, sprite.y)
end

-- countdown and exec the callback ONCE
function add_timer(seconds, fn)
	add(timers, {
		t = seconds,
		cb = fn
	})
end

-- countdown and exec the callback FOREVER
function add_repeat_timer(seconds, fn)
	add_timer(seconds, function()
		fn()
		add_repeat_timer(seconds, fn)
	end)
end

function execute_timers()
	local now = time()
	local dt = now - last_time -- seconds since last frame
	last_time = now

	for i = #timers, 1, -1 do
		local tm = timers[i]
		tm.t = tm.t - dt

		-- interval passed, exec callback + remove timer
		if tm.t <= 0 then
			tm.cb()
			deli(timers, i) -- remove finished timer
		end
	end
end

function log(text)
	printh(text, "log", true)
end

function is_colision(a, b)
	if a.y > b.y + 7 then return false end
	if b.y > a.y + 7 then return false end
	if a.x > b.x + 7 then return false end
	if b.x > a.x + 7 then return false end

	return true
end
