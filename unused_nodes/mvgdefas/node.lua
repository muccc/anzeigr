gl.setup(1366, 768)

util.auto_loader(_G)

function node.render()
  -- Background: #00106f - dark blue
  gl.clear(0, 0.062745098, 0.435294118, 1)
  -- Headline
  vialog_lt_regular:write(20, 20, "Linie", 60, 1, 1, 1, 1)
  vialog_lt_regular:write(230, 20, "Ziel", 60, 1, 1, 1, 1)
  vialog_lt_regular:write(1000, 20, "Abfahrt in Min.", 60, 1, 1, 1, 1)
  -- Horizontal line - probably should replace this with a shader?
  vialog_lt_regular:write(0, 30, "______________________________________________", 60, 1, 1, 1, 1)

  
  destinations = {
    {"U", "U1", "Antarktis", "1"},
    {"U", "U1", "Antarktis", "10"},
    {"U", "U1", "Antarktis", "15"},
    {"U", "U1", "Antarktis", "20"},
    {"U", "U1", "Antarktis", "25"},
    {"U", "U1", "Antarktis", "30"},
    {"U", "U1", "Antarktis", "50"},
    {"U", "U1", "Antarktis", "90"},
    {"U", "U1", "Antarktis", "120"},
  }

  ypos = 90
  for i in pairs(destinations) do
    vialog_lt_regular:write(20, ypos, destinations[i][1], 60, 1, 1, 1, 1)
    vialog_lt_regular:write(70, ypos, destinations[i][2], 60, 1, 1, 1, 1)
    vialog_lt_regular:write(230, ypos, destinations[i][3], 60, 1, 1, 1, 1)
    vialog_lt_regular:write(WIDTH-20-(string.len(destinations[i][4])*31), ypos, destinations[i][4], 60, 1, 1, 1, 1)
    ypos = ypos+70
  end

  resource.render_child("ticker"):draw(0, HEIGHT-60, WIDTH, HEIGHT)
end
