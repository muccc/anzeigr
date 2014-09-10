gl.setup(1024, 100)

image = resource.load_image("Ffmuc-logo-250.png")
font = resource.load_font("silkscreen.ttf")

function node.render()
    gl.clear(1, 1, 1, 1) -- white

    util.draw_correct(image, 0, 0, 150, 100)

    font:write(160, 10, "Freifunk Muc", 100, 0,0,0,1)
end
