local ffi = require 'ffi'
local C = ffi.os == 'Windows' and ffi.load('glfw3') or ffi.C

ffi.cdef [[
  typedef struct GLFWwindow GLFWwindow;
  typedef void(*GLFWmousebuttonfun)(GLFWwindow*, int, int, int);
  typedef void(*GLFWcursorposfun)(GLFWwindow*, double, double);
  typedef void(*GLFWscrollfun)(GLFWwindow*, double, double);

  GLFWwindow* glfwGetCurrentContext(void);
  void glfwGetCursorPos(GLFWwindow* window, double* x, double* y);
  int glfwGetMouseButton(GLFWwindow* window, int button);
  GLFWmousebuttonfun glfwSetMouseButtonCallback(GLFWwindow* window, GLFWmousebuttonfun callback);
  GLFWcursorposfun glfwSetCursorPosCallback(GLFWwindow* window, GLFWcursorposfun callback);
  GLFWcursorposfun glfwSetScrollCallback(GLFWwindow* window, GLFWscrollfun callback);
]]

local window = C.glfwGetCurrentContext()

local mouse = {}

function mouse.getX()
  local x = ffi.new('double[1]')
  C.glfwGetCursorPos(window, x, nil)
  return x[0]
end

function mouse.getY()
  local y = ffi.new('double[1]')
  C.glfwGetCursorPos(window, nil, y)
  return y[0]
end

function mouse.getPosition()
  local x, y = ffi.new('double[1]'), ffi.new('double[1]')
  C.glfwGetCursorPos(window, x, y)
  return x[0], y[0]
end

function mouse.isDown(button, ...)
  if not button then return false end
  return C.glfwGetMouseButton(window, button - 1) > 0 or mouse.isDown(...)
end

C.glfwSetMouseButtonCallback(window, function(target, button, action, mods)
  if target == window then
    local x, y = mouse.getPosition()
    lovr.event.push(action > 0 and 'mousepressed' or 'mousereleased', x, y, button + 1, false)
  end
end)

local px, py = mouse.getPosition()
C.glfwSetCursorPosCallback(window, function(target, x, y)
  if target == window then
    lovr.event.push('mousemoved', x, y, x - px, y - py, false)
    px, py = x, y
  end
end)

C.glfwSetScrollCallback(window, function(target, x, y)
  if target == window then
    lovr.event.push('wheelmoved', x, y)
  end
end)

return mouse
