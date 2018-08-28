local ffi = require 'ffi'
local C = ffi.os == 'Windows' and ffi.load('glfw3') or ffi.C

ffi.cdef [[
  typedef enum {
    GLFW_CURSOR = 0x00033001,
    GLFW_CURSOR_NORMAL = 0x00034001,
    GLFW_CURSOR_HIDDEN = 0x00034002,
    GLFW_CURSOR_DISABLED = 0x00034003
  } Constants;

  typedef struct GLFWwindow GLFWwindow;
  typedef void(*GLFWmousebuttonfun)(GLFWwindow*, int, int, int);
  typedef void(*GLFWcursorposfun)(GLFWwindow*, double, double);
  typedef void(*GLFWscrollfun)(GLFWwindow*, double, double);

  GLFWwindow* glfwGetCurrentContext(void);
  void glfwGetInputMode(GLFWwindow* window, int mode);
  void glfwSetInputMode(GLFWwindow* window, int mode, int value);
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

function mouse.getRelativeMode()
  return C.glfwGetInputMode(window, C.GLFW_CURSOR) == C.GLFW_CURSOR_DISABLED
end

function mouse.setRelativeMode(enable)
  C.glfwSetInputMode(window, C.GLFW_CURSOR, enable and C.GLFW_CURSOR_DISABLED or C.GLFW_CURSOR_NORMAL)
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
