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

    font:write(50, 200, "temperature:", 80, 1,1,1,1)
    -- show spacestate
    font:write(50, 350, pwrplnt.with.content.temperature, 100, 1,1,0,1)

end
