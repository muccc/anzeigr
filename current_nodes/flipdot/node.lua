gl.setup(1366, 768)

image = resource.load_image("flipdot.png")


function node.render()
    gl.clear(0, 0, 0, 1) -- black background

    -- render logo
    resource.render_child("header"):draw(0, 0, WIDTH, 100)

    -- show current flipdot img
    util.draw_correct(image, 100, 150, WIDTH-100, HEIGHT-50)

end
