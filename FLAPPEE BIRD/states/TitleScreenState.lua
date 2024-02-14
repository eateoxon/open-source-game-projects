--[[
    TitleScreenState Class

    The TitleScreenState is the starting screen of the game, shown on startup. It should
    display "Press Enter" and also our highest score.
]]

TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()
    state = 'title'
end

function TitleScreenState:update(dt)
    
end

function TitleScreenState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.printf('Flappee Bird', 0, 85, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter to start', 0, 145, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Controls: SPACEBAR or LEFT Mouse button', 0, 235, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press P to Pause while in game', 0, 250, VIRTUAL_WIDTH, 'center')
end

function love.mouse(istouch)
    
end