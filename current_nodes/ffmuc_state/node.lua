gl.setup(1024, 768)

json = require "json"

font = resource.load_font("silkscreen.ttf")

util.loaders.json = function(filename)
    return json.decode(resource.load_file(filename))
end

util.auto_loader(_G)


function node.render()
    gl.clear(1, 1, 1, 1) -- white background

    -- render logo
    resource.render_child("header"):draw(0, 0, WIDTH, 100)

    font:write(75, 250, "Nodes Online", 80, 0,0,0,1)
    font:write(75, 450, "Gateways Online", 80, 0,0,0,1)
    font:write(75, 650, "Clients Connected", 80, 0,0,0,1)

    nodecount=0
    gatewaycount=0
    clients=0
    for Index,Value in pairs(nodes.nodes) do
	if(Value.flags.online) == true then	
	  if(Value.flags.client) == true then
            clients = clients+1
          elseif(Value.flags.gateway) == true then
            gatewaycount = gatewaycount + 1
          else
            nodecount = nodecount + 1          
          end
        end
    end

    font:write(75, 550, clients, 100, 0,0,0,1)
    font:write(75, 350, gatewaycount, 100, 0,0,0,1)    
    font:write(75, 150, nodecount, 100, 0,0,0,1)

end
