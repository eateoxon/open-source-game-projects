--[[
    CMPE40032
    Super Mario Bros. Remake

]]

PlayerJumpState = Class{__includes = BaseState}

function PlayerJumpState:init(player, gravity)
	self.player = player
	self.gravity = gravity
	self.animation = Animation {
		frames = {3},
		interval = 1
	}
	self.player.currentAnimation = self.animation
end

function PlayerJumpState:enter(params)
	if params.heightMod == 0 then
		gSounds['jump']:play()
		self.player.dy = PLAYER_JUMP_VELOCITY
	else
		self.player.dy = PLAYER_JUMP_VELOCITY - params.heightMod
	end

	self.xMomentum = params.xMomentum
	self.player.speed = self.xMomentum
end

function PlayerJumpState:update(dt)
	self.player.currentAnimation:update(dt)
	self.player.dy = self.player.dy + self.gravity
	self.player.y = self.player.y + (self.player.dy * dt)

	-- go into the falling state when y velocity is positive
	if self.player.dy >= 0 then
	
		self.player:changeState('falling', {xMomentum = self.xMomentum})
	end

	self.player.y = self.player.y + (self.player.dy * dt)

	-- look at two tiles above our head and check for collisions; 3 pixels of leeway for getting through gaps
	local tileLeft = self.player.map:pointToTile(self.player.x + 4, self.player.y)
	local tileRight = self.player.map:pointToTile(self.player.x + self.player.width - 4, self.player.y)

	-- if we get a collision up top, go into the falling state immediately
	if (tileLeft and tileRight) and (tileLeft:collidable() or tileRight:collidable()) then
		self.player.dy = 0

		self.player:changeState('falling', {xMomentum = self.xMomentum})

	-- else test our sides for blocks
	elseif love.keyboard.isDown(PLAYER_LEFT) then
		self.player.direction = 'left'
	
		self.player.x = self.player.x - self.xMomentum * dt
		self.player:checkLeftCollisions(dt)
	elseif love.keyboard.isDown(PLAYER_RIGHT) then
		self.player.direction = 'right'

		self.player.x = self.player.x + self.xMomentum * dt
		self.player:checkRightCollisions(dt)
	end

	-- check if we've collided with any collidable game objects
	for k, object in pairs(self.player.level.objects) do
		if object:collides(self.player) then
			if object.collidable then
				object.onCollide(self.player, object)

				self.player.y = object.y + object.height
				self.player.dy = 0

			
				self.player:changeState('falling', {xMomentum = self.xMomentum})
			end

			if object.consumable then
				object.onConsume(self.player, object)
				table.remove(self.player.level.objects, k)
			end
		end
	end

	-- check if we've collided with any entities and die if so
	for k, entity in pairs(self.player.level.entities) do
		if entity:collides(self.player) then
			self.player.gameOver = true
			self.player:changeState('death')
		end
	end
end
