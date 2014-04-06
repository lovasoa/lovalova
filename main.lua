score = {
	current = 0,
	best = 0
}
function score:set (n)
	self.current = math.floor(n)
	if self.current > self.best then
		self.best = self.current
	end
end
function score:save()
	love.filesystem.write('score', self.best)
end
function score:load()
	if love.filesystem.exists('score') then
		self.best = math.max(love.filesystem.read('score'), self.best)
	else
		love.filesystem.write('score', '0')
	end
end

function love.load()
	icon = love.graphics.newImage("icon.png")
	if love.window then -- 0.9
		love.window.setIcon(icon:getData())
		screen = {love.window.getMode()}
	else  -- 0.8
		love.graphics.setIcon(icon)
		screen = {love.graphics.getMode()}
	end

	font = love.graphics.newFont("PT Sans Caption.ttf", 14)
	love.graphics.setFont(font)

	pos = {screen[1]/2,screen[2]/2}
	speed = {0,0}
	size = {20,20}
	acceleration = 4500
	friction = 0.001
	lost = false
	score:load()
	score:set(0)
	startTime = love.timer.getTime()
	ennemies = {}
end

function love.draw()
	love.graphics.setColor(199,199,255,255)
	love.graphics.print(string.format("Score: %d  | Best: %d", score.current, score.best), 0,0)
	if lost then
		return love.graphics.print("You loose ! Press space to try again.", 100,100)
	end

	-- hero
	love.graphics.setColor(122,122,198,255)
	love.graphics.rectangle("fill", pos[1], pos[2], size[1], size[2])

	-- ennemies
	for i=1,#ennemies do
		local e = ennemies[i]
		love.graphics.setColor(e.speed[1]*255/150,e.speed[2]*255/150,255,255)
		love.graphics.rectangle("line", e.pos[1], e.pos[2], e.size[1], e.size[2])
	end
end

function love.update(dt)
	if lost or paused then return end

	score:set((love.timer.getTime() - startTime))

	local directions = {{"left", "right"},{"up","down"}}

	-- hero
	for i=1,2 do

		for j=1,2 do
			if love.keyboard.isDown(directions[i][j]) then
				speed[i] = speed[i] + (2*j-3)*acceleration*dt
			end
		end

		speed[i] = speed[i]*math.pow(friction,dt) -- friction
		pos[i] = pos[i] + speed[i]*dt
		if math.abs(pos[i]) < 1 then pos[i] = 0 end
		if pos[i] < 0 then
			pos[i] = 0
			speed[i] = -speed[i]
		elseif pos[i] > screen[i] - size[i] then
			pos[i] = screen[i] - size[i]
			speed[i] = -speed[i]
		end
	end



	-- ennemies
	local dirs = {'h', 'w'}
	for ennum=1,#ennemies do
		local e = ennemies[ennum]
		if not e then break end
		local lost = true
		for i = 1,2 do
			if e.pos[i] > screen[i] or e.pos[i] < 0 then
				table.remove(ennemies, ennum)
			end
			e.pos[i] = e.pos[i] + e.speed[i]*dt
			lost = lost and pos[i] + size[i] > e.pos[i] and e.pos[i] + e.size[i] > pos[i]
		end
		if lost then 
			return loose()
		end
	end

	-- add ennemies
	if math.random() < 0.02 + 0.01*math.sqrt(score.current) then
		local horiz = math.random() < 0.5
		local newenn = {pos={0,0}, size={3,3}, speed={0,0} }
		for n=1,2 do
			if horiz == (n==1) then
				newenn.pos[n] = math.random()*screen[n]
				newenn.size[n] = 20 + math.random()*100
				newenn.speed[3-n] = 50 + math.random()*100
			end
		end
		table.insert(ennemies, newenn)
	end

end

function love.keypressed(key)
	if key == ' ' then
		love.load()
	elseif key == 'p' then
		paused = not paused
	elseif key == 'q' and os and os.exit then
		quit()
	elseif key == 'f' then -- fullscreen
		love.mouse.setVisible(false)
		if love.window then -- 0.9
			if love.window.getFullscreen() then return end
			love.window.setFullscreen(true, 'desktop')
			screen = {love.window.getMode()}
		else -- 0.8
			if ({love.graphics.getMode()})[3] then return end
			for i,mode in pairs(love.graphics.getModes()) do
				if mode.width*mode.height > screen[1]*screen[2] then
					screen[1] = mode.width
					screen[2] = mode.height
				end
			end
			love.graphics.setMode(screen[1], screen[2], true)
		end
	elseif key == 'escape' then
		love.mouse.setVisible(true)
		if love.window then
			if not love.window.getFullscreen() then return end
			love.window.setFullscreen(false)
			screen = {love.window.getMode()}
		else
			if not ({love.graphics.getMode()})[3] then return end
			screen[1] = 800
			screen[2] = 600
			love.graphics.setMode(screen[1], screen[2], false)
		end
	end

end

function loose()
	lost = true
	score:save()
end

function love.quit ()
	-- Executed before quitting
	score:save()
end

function quit()
	-- force exit
	love.quit()
	os.exit()
end
