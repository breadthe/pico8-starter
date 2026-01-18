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

-- chatgpt wrote dis
function dict_count(t)
	local n = 0
	for k, v in pairs(t) do
		n = n + 1
	end
	return n
end

-- @see https://pico-8.fandom.com/wiki/Centering_Text
function hcenter(s)
	-- screen center minus the
	-- string length times the
	-- pixels in a char's width,
	-- cut in half
	return 64 - #s * 2
end

-- @see https://pico-8.fandom.com/wiki/Centering_Text
function vcenter(s)
	-- screen center minus the
	-- string height in pixels,
	-- cut in half
	return 61
end
