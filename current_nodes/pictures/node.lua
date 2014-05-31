gl.setup(1024, 768)

image = resource.load_image("kannste.png")


function node.render()
    gl.clear(0, 0, 0, 1) -- black background

    -- render logo
    --resource.render_child("header"):draw(0, 0, WIDTH, 100)

    -- show current flipdot img
    util.draw_correct(image, 0, 0, WIDTH, HEIGHT)

end
