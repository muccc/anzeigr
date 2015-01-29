gl.setup(1024, 100)

image = resource.load_image("logo_muccc_inv.png")
font = resource.load_font("silkscreen.ttf")

function node.render()
    gl.clear(0.1, 0.1, 0.1, 1) -- dark grey

    util.draw_correct(image, 0, 0, 150, 100)

    font:write(160, 10, "space state", 100, 1,1,1,1)
end
