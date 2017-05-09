gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

json = require "json"

font = resource.load_font("silkscreen.ttf")

util.loaders.json = function(filename)
    return json.decode(resource.load_file(filename))
end

util.auto_loader(_G)


function node.render()
    gl.clear(0, 0, 0, 1) -- black background

    -- render logo
    resource.render_child("header"):draw(0, 0, WIDTH, 100)

    -- show next event with linebreak
    size=100
    offset=50
    font:write(offset, 150, nextevent.weekday, size, 1,1,1,1)
    font:write(offset, 300, nextevent.date, size, 1,1,1,1)
    font:write(offset, 450, nextevent.time, size, 1,1,1,1)

    if (font:width(nextevent.name,size)+offset>WIDTH) then
      o=nextevent.name:len()
      while (o) and font:width(nextevent.name:sub(1,o),size)>WIDTH do
        o=nextevent.name:sub(1,o-1):match(".*%s()")
        if o then
          o=o-1
        end
      end
      if not o then
        o=nextevent.name:len()
      end
      while o>0 and font:width(nextevent.name:sub(1,o),size)>WIDTH do
        o=o-1
      end
      font:write(50, 600, nextevent.name:sub(1,o), 100, 1,1,0,1)
      font:write(50, 680, nextevent.name:sub(o+1), 100, 1,1,0,1)
    else
      font:write(50, 600, nextevent.name, 100, 1,1,0,1)
    end
end
