json = require "json"

gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.loaders.json = function(filename)
  return json.decode(resource.load_file(filename))
end

util.resource_loader{
  "vialog_lt_regular.ttf";
}

util.file_watch("departures.json", function(content)
  departures = json.decode(content)
end)

function node.render()
  local size=60
  -- Background: #00106f - dark blue
  gl.clear(0, 0.062745098, 0.435294118, 1)
  -- Headline
  vialog_lt_regular:write(20, 20, "Linie", size, 1, 1, 1, 1)
  vialog_lt_regular:write(230, 20, "Ziel", size, 1, 1, 1, 1)
  local str="Abfahrt in Min."
  local w=vialog_lt_regular:width(str,size)
  vialog_lt_regular:write(WIDTH-w-20, 20, str, size, 1, 1, 1, 1)
  -- Horizontal line - probably should replace this with a shader?
  vialog_lt_regular:write(0, 30, "______________________________________________", size, 1, 1, 1, 1)

  ypos = 90
  for i in pairs(departures) do
    -- getResource(departures[i].productsymbol):draw(20, ypos+8, 20+40, ypos+48):dispose()
    vialog_lt_regular:write(20, ypos+8, string.sub(departures[i].product, 0, 1), 60, 1, 1, 1, 1)
    -- getResource(departures[i].linesymbol):draw(90, ypos+8, 90+79, ypos+48):dispose()
    vialog_lt_regular:write(90, ypos+8, departures[i].linename, 60, 1, 1, 1, 1)
    vialog_lt_regular:write(230, ypos, departures[i].destination, 60, 1, 1, 1, 1)
    vialog_lt_regular:write(WIDTH-20-(string.len(departures[i].time)*31), ypos, departures[i].time, 60, 1, 1, 1, 1)
    ypos = ypos+70
  end

  resource.render_child("ticker"):draw(0, HEIGHT-60, WIDTH, HEIGHT):dispose()
end

function getResource(product)
  return resource.load_image(product .. ".png")
end
