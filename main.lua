function love.load()
	if love.graphics.getMode then -- 0.8
		screen = {love.graphics.getMode()}
	else -- 0.9
		screen = {love.window.getMode()}
	end

	font = love.graphics.newFont("PT Sans Caption.ttf", 14)
	love.graphics.setFont(font)

	pos = {screen[1]/2,screen[2]/2}
	speed = {0,0}
	size = {20,20}
	acceleration = 4500
	friction = 0.001
	lost = false
	time = 0
	ennemies = {{pos={10,0}, size={100,5}, speed={0,100}}}
end

function love.draw()
	love.graphics.setColor(199,199,255,255)
	love.graphics.print(string.format("Score: %d", time), 0,0)
	if lost then
		return love.graphics.print("You loose ! Press space to try again.", 100,100)
	end

	-- hero
	love.graphics.setColor(122,122,198,255)
	love.graphics.rectangle("fill", pos[1], pos[2], size[1], size[2])

	-- ennemies
	for i=1,#ennemies do
		local e = ennemies[i]
		love.graphics.setColor(e.speed[1],e.speed[2],98,255)
		love.graphics.rectangle("line", e.pos[1], e.pos[2], e.size[1], e.size[2])
	end
end

function love.update(dt)
	if lost then return end
	time = time + dt

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
		lost = true
		for i = 1,2 do
			if e.pos[i] > screen[i] or e.pos[i] < 0 then
				table.remove(ennemies, ennum)
			end
			e.pos[i] = e.pos[i] + e.speed[i]*dt
			lost = lost and pos[i] + size[i] > e.pos[i] and e.pos[i] + e.size[i] > pos[i]
		end
		if lost then break end
	end

	-- add ennemies
	if math.random() < 0.02 + 0.01*math.sqrt(time) then
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
	end
	if key == 'f' then
		love.graphics.toggleFullscreen()
	end
end
