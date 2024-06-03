push = require "push"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 100

GAME_START = false


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    smallFont = love.graphics.newFont("Retro Gaming.ttf", 16)
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false, vsync = true})

    player1Score = 0
    player2Score = 0

    paddle1Y = VIRTUAL_HEIGHT / 2
    paddle2Y = VIRTUAL_HEIGHT / 2
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    GAME_START = true
end

function love.draw()
    push:apply("start")

    --Clear the screen with a gray color
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    ---------DRAW GAME OBJECTS------------

    --Left paddle
    love.graphics.rectangle("fill", 10, paddle1Y, 5, 20)

    --Right paddle
    love.graphics.rectangle("fill", VIRTUAL_WIDTH - 10, paddle2Y, 5, 20)

    --Ball
    love.graphics.rectangle("fill", VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, 4, 4)

    --Welcome message
    if GAME_START == false then
        love.graphics.printf("The Game of Pong", 0, 20, VIRTUAL_WIDTH, "center")
    end

    --Scores
    if GAME_START == true then
        love.graphics.print(player1Score, VIRTUAL_WIDTH / 2 - 34, VIRTUAL_HEIGHT / 3 - 50)
        love.graphics.print(player2Score, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3 - 50)
    end
    push:apply("end")
end

function love.update(dt)
    --moving left paddle
    if love.keyboard.isDown('w') then
        paddle1Y = paddle1Y + (-PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        paddle1Y = paddle1Y + (PADDLE_SPEED * dt)
    end

    --moving right paddle
    if love.keyboard.isDown('up') then
        paddle2Y = paddle2Y + (-PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        paddle2Y = paddle2Y + (PADDLE_SPEED * dt)
    end


    ------Paddle movement boundary checks------
    if paddle1Y < 0 then --left paddle upward movement check
        paddle1Y = 0 --limit position by resetting
    elseif paddle1Y > VIRTUAL_HEIGHT - 20 then --left paddle downward movement check
        paddle1Y = VIRTUAL_HEIGHT - 20 --limit position by resetting
    end

    if paddle2Y < 0 then --right paddle upward movement check
        paddle2Y = 0 --limit position by resetting
    elseif paddle2Y > VIRTUAL_HEIGHT - 20 then --right paddle downward movement check
        paddle2Y = VIRTUAL_HEIGHT - 20 --limit position by resetting
    end

end