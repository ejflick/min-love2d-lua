lume = require("lib.lume")

function love.load()
  local stdio_code = [[
    require("love.event")
    while 1 do
      love.event.push("stdin", io.read("*line"))
    end
  ]]

  love.thread.newThread(stdio_code):start()
end

---@diagnostic disable-next-line: undefined-field
function love.handlers.stdin(line)
  local func, err = load(line)

  if err then
    print(err)
    return
  end

---@diagnostic disable-next-line: param-type-mismatch
  local _, val = pcall(func)
  print(val)
end
