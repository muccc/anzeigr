json = require "json"

gl.setup(1024, 60)

util.loaders.json = function(filename)
    return json.decode(resource.load_file(filename))
end

util.auto_loader(_G)

ticker = util.running_text{
    font = vialog_lt_regular;
    size = 60;
    speed = 150;
    color = {1, 1, 1, 1};
    generator = util.generator(function() return mvgticker end)
}

function node.render()
  -- Background: #0c01f5 - lighter blue
  gl.clear(0.047058824, 0.003921569, 0.960784314, 1)
  ticker:draw(0)
  resource.render_child("syminfo"):draw(0, 0, 60, 60)
end
