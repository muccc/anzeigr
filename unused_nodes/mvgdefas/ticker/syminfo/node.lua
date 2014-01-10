gl.setup(60, 60)

util.auto_loader(_G)

function node.render()
  -- Background: #f6d400 - yellow
  gl.clear(0.964705882, 0.831372549, 0, 1)
  -- Headline
  vialog_lt_bold:write(18, 0, "i", 70, 0, 0, 0, 1)
end
