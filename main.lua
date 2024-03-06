function love.load()
    tools = require("tools")
    updating_resources = require("update")
    graphic_resources = require("draw")
    
    set_values()
end

function love.update(dt)
    updating_resources.update_game(dt)
end

function love.draw()
    graphic_resources.draw_game()
end