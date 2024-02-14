--[[
    CMPE40032
    -- Super Mario Bros. Remake --

]]

GameObject = Class{}

function GameObject:init(def)
	self.x = def.x
	self.y = def.y
	self.texture = def.texture
	self.width = def.width
	self.height = def.height
	self.frame = def.frame
	self.collidable = def.collidable
	self.consumable = def.consumable
	self.onCollide = def.onCollide
	self.onConsume = def.onConsume
	self.hit = def.hit


	self.spawnEnemy = def.spawnEnemy
	self.enemyX = def.enemyX
	self.enemyY = def.enemyY


	self.animation = def.animation
	self.currentAnimation = self.animation
end

function GameObject:collides(target)
	return not (target.x > self.x + self.width - 3 or self.x + 3 > target.x + target.width or
			target.y > self.y + self.height - 3 or self.y > target.y + target.height)
end

function GameObject:update(dt)

	if self.animation ~= nil then
		self.currentAnimation:update(dt)
	end
end

function GameObject:render()
	if self.animation == nil then
		love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame], self.x, self.y)
	else
		love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()], self.x, self.y)

	end
end
