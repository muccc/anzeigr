gl.setup(1024, 768)

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

    -- show next event
    font:write(50, 150, nextevent.weekday, 100, 1,1,0,1)
    font:write(50, 200, nextevent.date, 100, 1,1,0,1)
    font:write(50, 350, nextevent.time, 100, 1,1,0,1)
    font:write(50, 500, nextevent.name, 100, 1,1,0,1)

end
