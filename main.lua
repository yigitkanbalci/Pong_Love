push = require "push"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    smallFont = love.graphics.newFont("Retro Gaming.ttf", 16)
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false, vsync = true})
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:apply("start")

    --Clear the screen with a gray color
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    --Draw the game objects
    love.graphics.rectangle("fill", 10, VIRTUAL_HEIGHT / 2, 5, 20)

    love.graphics.rectangle("fill", VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT / 2, 5, 20)

    love.graphics.rectangle("fill", VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, 4, 4)

    love.graphics.printf("The Game of Pong", 0, 20, VIRTUAL_WIDTH, "center")
    push:apply("end")
end