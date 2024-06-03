push = require "push"
Class = require "class"

require "Paddle"
require "Ball"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

GAME_START = false


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest') --rendering graphics without blur
    smallFont = love.graphics.newFont("Retro Gaming.ttf", 16) --configuring font and size to be used in the game
    love.graphics.setFont(smallFont) --setting the determined font

    math.randomseed(os.time()) --seeding random number generator with the current time

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false, vsync = true}) --launching the game window

    player1Score = 0 --player 1 score variable
    player2Score = 0 --player 2 score variable

    --initial positions of the paddles
    Paddle1 = Paddle(10, VIRTUAL_HEIGHT / 2, 5, 20)
    Paddle2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT / 2, 5, 20)

    --initial position of the ball
    Ball = Ball(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2 + 2, 4, 4)

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
    Paddle1:render()
    Paddle2:render()
    Ball:render()

    --Welcome message
    if GAME_START == false then
        love.graphics.printf("The Game of Pong", 0, 20, VIRTUAL_WIDTH, "center")
    end

    --Scores
    if GAME_START == true then
        love.graphics.print(player1Score, VIRTUAL_WIDTH / 2 - 36, VIRTUAL_HEIGHT / 3 - 50)
        love.graphics.print(player2Score, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3 - 50)
    end
    push:apply("end")
end

function love.update(dt)
    --moving left paddle
    if love.keyboard.isDown('w') then
        Paddle1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        Paddle1.dy = PADDLE_SPEED
    else
        Paddle1.dy = 0
    end

    --moving right paddle
    if love.keyboard.isDown('up') then
        Paddle2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        Paddle2.dy = PADDLE_SPEED
    else
        Paddle2.dy = 0
    end

    if Ball:collides(Paddle1) then
        Ball.dx = -Ball.dx * 1.03
        Ball.x = Paddle1.x + 5

        if Ball.dy < 0 then
            Ball.dy = -math.random(10, 150)
        else
            Ball.dy = math.random(10, 150)
        end
    end

    if Ball:collides(Paddle2) then
        Ball.dx = -Ball.dx * 1.03
        Ball.x = Paddle2.x - 5
        
        if Ball.dy < 0 then
            Ball.dy = -math.random(10, 150)
            Ball.dy = math.random(10, 150)
        end
    end

    if Ball.y >= VIRTUAL_HEIGHT - 4 then
        Ball.y = VIRTUAL_HEIGHT - 4
        Ball.dy = -Ball.dy
    end

    if Ball.y <= 0 then
        Ball.y = 0
        Ball.dy = -Ball.dy
    end


    --Moving ball
    if GAME_START == true then
        Ball:update(dt)
    end

    Paddle1:update(dt)
    Paddle2:update(dt)

end