--[[
    ScoreState Class

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}



--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:init(dt)
    state = 'score'
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oops! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Your score is ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
    if self.score >= 30 then
        love.graphics.draw(medal1, 240, 120)
    else
        if self.score >= 20 then
            love.graphics.draw(medal2, 240, 120)
        else
            if self.score >= 10 then
                love.graphics.draw(medal3, 240, 120)
            end
        end
    end
    love.graphics.printf('Press Enter to Play Again!', 0, 180, VIRTUAL_WIDTH, 'center')
end