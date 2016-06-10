gl.setup(540, 200)

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
      font:write(0, -size/2, t1, size, r, g, b, 1-alpha)
      gl.popMatrix()

      gl.rotate(alpha*90-90, 1, 0, 0)
      gl.translate(0, 0, -size/3)
      font:write(0, -size/2, t2, size, r, g, b, alpha)

      gl.popMatrix()
      font:write(x, y, t3, size, r, g, b, a)
    else
      font:write(x, y, text, size, r, g, b, a)
    end
  end

  return {
    set = set;
    render = render;
  }

end

local last_update = sys.now()
local fliptime = fliptext(bold, 0, 100, 114, 1, 1, 1, 1, 0.9)
local c = clock(fliptime)

function node.render()

  if sys.now() - last_update > 0.1 then
    c.update()
    last_update = sys.now()
  end

  fliptime:render()

  bold:write(0, 0, c.day(), 50, 1.0, 1.0, .4, 1)
  regular:write(0, 50, c.date(), 50, .7, 1.0, .7, 1)
end
