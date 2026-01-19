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

-- simple 8x8 sprite collision
function is_collision(a, b)
	if a.y > b.y + 7 then return false end
	if b.y > a.y + 7 then return false end
	if a.x > b.x + 7 then return false end
	if b.x > a.x + 7 then return false end

	return true
end

-- objects with smaller hitboxes should define an (optional) property
-- hitbox = { tl_x, tl_y, br_x, br_y }
-- representing the bounding box of the sprite
-- (optional) spr_w, spr_h are the sprite tile width/height (default 1,1 for 8x8 sprites)
-- chatgpt wrote dis
function hitbox_edges(o)
	local hb = o.hitbox

	local w = (o.spr_w or 1) * 8
	local h = (o.spr_h or 1) * 8

	local max_x = w - 1
	local max_y = h - 1

	local l = o.x + (hb and hb.tl_x or 0)
	local t = o.y + (hb and hb.tl_y or 0)
	local r = o.x + (hb and hb.br_x or max_x)
	local b = o.y + (hb and hb.br_y or max_y)

	return l, t, r, b
end

-- advanced collision with support for hitboxes and large sprites
-- chatgpt wrote dis
function is_hitbox_collision(a, b)
	local al, at, ar, ab = hitbox_edges(a)
	local bl, bt, br, bb = hitbox_edges(b)

	if ar < bl then return false end
	if br < al then return false end
	if ab < bt then return false end
	if bb < at then return false end

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
