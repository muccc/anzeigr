gl.setup(1366, 768)

json = require "json"

util.loaders.json = function(filename)
    return json.decode(resource.load_file(filename))
end

util.auto_loader(_G)

font = resource.load_font("font.ttf")

function Drinkleaker(drinks, x, y, spacing, size)
    local row
    local col
    local next_kaputt

    function select_next()
        repeat
            row = math.random(#drinks)
        until drinks[row] ~= Absatz
        local title, price = unpack(drinks[row])
        col = math.random(#title - 1)
        next_kaputt = sys.now() + math.random() * 60 + 20
    end

    select_next()

    function draw()
        local yy = y
        for n, item in pairs(drinks) do
            if item == Absatz then
                yy = yy + size
            else
                local title, price = unpack(item)
                if sys.now() > next_kaputt - 3 and n == row then
                    local a = title:sub(1, col-1)
                    local b = title:sub(col, col)
                    local c = title:sub(col+1, col+1)
                    local d = title:sub(col+2)
                    title = a .. c .. b .. d
                    font:write(x, yy, title, size, .1,.7,.1,1)
                elseif sys.now() > next_kaputt then
                    select_next()
                    font:write(x, yy, title, size, .1,.7,.1,1)
                else
                    font:write(x, yy, title, size, .1,.7,.1,1)
                end
                font:write(x + spacing, yy, price, size, .1,.7,.1,1)
                yy = yy + size
            end
        end
    end
    return {
        draw = draw;
    }
end

function node.render()
    gl.clear(0, 0, 0, 1) -- black background

    -- render logo
    resource.render_child("header"):draw(0, 0, WIDTH, 100)

    local drinkleaker = Drinkleaker(drinks, 50, 150, 900, 105)
    drinkleaker:draw()

end
