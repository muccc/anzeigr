local INTERVAL = 4

gl.setup(1024, 768)

pictures = util.generator(function()
    local out = {}
    for name, _ in pairs(CONTENTS) do
        if name:match(".*jpg") then
            out[#out + 1] = name
        end
    end
    return out
end)
node.event("content_remove", pictures.remove)

util.set_interval(INTERVAL, function()
    local next_image_name = pictures.next()
    print("now showing " .. next_image_name)
    current_image = resource.load_image(next_image_name)
end)

function node.render()
    gl.clear(0, 0, 0, 1) -- black background

    -- render logo
    resource.render_child("header"):draw(0, 0, WIDTH, 100)

    -- show images
    util.draw_correct(current_image, 0, 100, WIDTH, HEIGHT-100)

end

