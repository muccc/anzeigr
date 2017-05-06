gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

json = require "json"

font = resource.load_font("silkscreen.ttf")


util.auto_loader(_G)

function node.render()
    gl.clear(1, 1, 1, 1) -- white background

    str_stats = resource.load_file("node_stats")
    -- render logo
    resource.render_child("header"):draw(0, 0, WIDTH, 100)

    font:write(75, 300, "Nodes Online", 80, 0,0,0,1)
    font:write(75, 600, "Clients Connected", 80, 0,0,0,1)

    router = 0
    clients = 0
    router, clients, ltime = string.match(str_stats, '(%d+) (%d+) (.+)')

    font:write(75, 150, router, 160, 0,0,0,1)    
    font:write(75, 450, clients, 160, 0,0,0,1)

    font:write(1120, 740, ltime, 20, 0,0,0,1)
end
