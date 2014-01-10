gl.setup(1366, 768)

font = resource.load_font("font.ttf")

local Absatz = "absatz"

local preise = {
    {"Tschunk",   "1,- €"},
    {"Mate",      "1,50 €"},
    {"Bier",      "1,50 €"},
    Absatz,
    {"Cola",    "1,- €"},
    {"Spezi",   "1,- €"},
}

function Preisliste(preise, x, y, spacing, size)
    local row
    local col
    local next_kaputt

    function select_next()
        repeat
            row = math.random(#preise)
        until preise[row] ~= Absatz
        local title, price = unpack(preise[row])
        col = math.random(#title - 1)
        next_kaputt = sys.now() + math.random() * 60 + 30
    end

    select_next()

    function draw()
        local yy = y
        for n, item in pairs(preise) do
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

local preisliste = Preisliste(preise, 50, 150, 1000, 105)

function node.render()
    gl.clear(0, 0, 0, 1) -- black background

    -- render logo
    resource.render_child("header"):draw(0, 0, WIDTH, 100)

    preisliste:draw()

end
