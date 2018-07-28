lovr.mouse = require 'lovr-mouse'

function lovr.mousepressed(x, y, button)
  print('press', x, y, button)
end

function lovr.mousereleased(x, y, button)
  print('release', x, y, button)
end

function lovr.mousemoved(x, y, dx, dy)
  if lovr.mouse.isDown(1, 2, 3) then
    print('move', x, y, dx, dy)
  end
end

function lovr.wheelmoved(dx, dy)
  print('wheel', dx, dy)
end
