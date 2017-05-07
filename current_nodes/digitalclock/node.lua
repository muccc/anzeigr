gl.setup(540, 200)

local font = resource.load_font("silkscreen.ttf")

util.auto_loader(_G)

function clock(fliptime)
  local time, day, date

  local function update()
    time = os.date("%X")
    day = os.date("%A")
    date = os.date("%d. %B %Y")
    fliptime:set(time)
  end

  local function get_time() return time end
  local function get_day() return day end
  local function get_date() return date end

  update()

  return {
    update = update,
    time = get_time,
    day = get_day,
    date = get_date
  }
end

function fliptext(font, x, y, size, r, g, b, a, duration)
  local text
  local old_text
  local anim_start = 0
  local t1, t2, t3

  local function set(_, e)
    if e ~= text then
      old_text = text or e
      text = e
      anim_start = sys.now()

      local pos = 0
      t1 = ""
      t2 = ""
      t3 = ""
      for i = 1,#text do
        local a = old_text:sub(i, i)
        local b = text:sub(i, i)
        if a == b then
          t1 = t1 .. " "
          t2 = t2 .. " "
          t3 = t3 .. a
        else
          t1 = t1 .. a
          t2 = t2 .. b
          t3 = t3 .. " "
        end
      end
    end
  end

  local function render()
    local width=size* 0.6
    if anim_start > 0 then
      local delta = sys.now() - anim_start
      local alpha = math.sin(delta/duration*3.14159/2)

      if delta > duration then
        anim_start = 0
      end

      gl.pushMatrix()
      gl.translate(x, y + size/2, size/3)

      gl.pushMatrix()
      gl.rotate(alpha*90, 1, 0, 0)
      gl.translate(0, 0, -size/3)
      local c = width/2
      for i = 1,#t1 do
        local l = t1:sub(i, i)
	local w = font:width(l, size)
        font:write(c-w/2, -size/2, l, size, r, g, b, 1-alpha)
	c = c + width
      end
      gl.popMatrix()

      gl.rotate(alpha*90-90, 1, 0, 0)
      gl.translate(0, 0, -size/3)
      local c = width/2
      for i = 1,#t2 do
        local l = t2:sub(i, i)
	local w = font:width(l, size)
        font:write(c-w/2, -size/2, l, size, r, g, b, alpha)
	c = c + width
      end

      gl.popMatrix()
      local c = width/2
      for i = 1,#t3 do
        local l = t3:sub(i, i)
	local w = font:width(l, size)
        font:write(x+c-w/2, y, l, size, r, g, b, a)
	c = c + width
      end
    else
      local c = width/2
      for i = 1,#text do
        local l = text:sub(i, i)
	local w = font:width(l, size)
        font:write(x+c-w/2, y, l, size, r, g, b, a)
	c = c + width
      end
    end
  end

  return {
    set = set;
    render = render;
  }

end

local last_update = sys.now()
local fliptime = fliptext(font, 0, 100, 114, 1, 1, 1, 1, 0.9)
local c = clock(fliptime)

function node.render()

  if sys.now() - last_update > 0.1 then
    c.update()
    last_update = sys.now()
  end

  fliptime:render()

  font:write(0, 0, c.day(), 50, 1.0, 1.0, .4, 1)
  font:write(0, 50, c.date(), 50, .7, 1.0, .7, 1)
end
