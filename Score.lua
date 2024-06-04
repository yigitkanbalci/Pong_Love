Score = Class{}

function Score:init(leftBound, rightBound, player1Score, player2Score, serving)
    self.leftBound = leftBound
    self.rightBound = rightBound
    self.player1Score = player1Score
    self.player2Score = player2Score
    self.serving = serving
    self.gameOver = false
end

function Score:reset()
    self.player1Score = 0
    self.player2Score = 0
    self.serving = nil
    self.gameOver = false
end

function Score:update(Ball, AudioPlayer)
    if Ball.x < self.leftBound then
        AudioPlayer:play("score_sound")
        self.player2Score = self.player2Score + 1
        self.serving = 2
        Ball:reset()
    elseif Ball.x > self.rightBound then
        AudioPlayer:play("score_sound")
        self.player1Score = self.player1Score + 1
        self.serving = 1
        Ball:reset()
    end
end

function Score:isGameOver()
    self.gameOver = self.player1Score == 10 or self.player2Score == 10
    return self.gameOver
end

function Score:render(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.print(self.player1Score, VIRTUAL_WIDTH / 2 - 36, VIRTUAL_HEIGHT / 3 - 50)
    love.graphics.print(self.player2Score, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3 - 50)
end

function Score:renderGameOver(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.print("Game Over, ", VIRTUAL_WIDTH / 2 - 120, VIRTUAL_HEIGHT / 2 - 50)
    love.graphics.printf("Player ".. self.serving.. " wins!", VIRTUAL_WIDTH / 2 - 40, VIRTUAL_HEIGHT / 2 -50, 200, "center")
    love.graphics.print("Press R to restart", VIRTUAL_WIDTH / 2 - 90, VIRTUAL_HEIGHT / 2 + 50)
end
