json = require "json"

gl.setup(1024, 768)

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
  -- Background: #00106f - dark blue
  gl.clear(0, 0.062745098, 0.435294118, 1)
  -- Headline
  vialog_lt_regular:write(20, 20, "Linie", 60, 1, 1, 1, 1)
  vialog_lt_regular:write(230, 20, "Ziel", 60, 1, 1, 1, 1)
  vialog_lt_regular:write(650, 20, "Abfahrt in Min.", 60, 1, 1, 1, 1)
  -- Horizontal line - probably should replace this with a shader?
  vialog_lt_regular:write(0, 30, "______________________________________________", 60, 1, 1, 1, 1)

  ypos = 90
  for i in pairs(departures) do
    getResource(departures[i].productsymbol):draw(20, ypos+8, 20+40, ypos+48)
  	getResource(departures[i].linesymbol):draw(90, ypos+8, 90+79, ypos+48)
    vialog_lt_regular:write(230, ypos, departures[i].destination, 60, 1, 1, 1, 1)
    vialog_lt_regular:write(WIDTH-20-(string.len(departures[i].time)*31), ypos, departures[i].time, 60, 1, 1, 1, 1)
    ypos = ypos+70
  end

  resource.render_child("ticker"):draw(0, HEIGHT-60, WIDTH, HEIGHT)
end

function getResource(product)
	return resource.load_image(product .. ".png")
end
