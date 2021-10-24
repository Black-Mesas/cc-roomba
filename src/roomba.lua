local angle = 0
local blocks = 0

local last = -1

assert(turtle,"Machine is not a turtle.")

local function wrap(x,min,max)
	if x < min then
		x = max
	end
	if x > max then
		x = min
	end
	return x
end

local function turn()
	local next
	
	while true do
		next = math.random(0,1)
		
		if last ~= next then
			last = next
			break
		end
	end
	
	if next == 0 then
		turtle.turnRight()
		angle = wrap(angle - 1,-2,2)
	end
	if next == 1 then
		turtle.turnLeft()
		angle = wrap(angle + 1,-2,2)
	end
end

term.clear()

while true do
	local down = turtle.inspectDown()
	local front = turtle.inspect()
	
	local move = true
	
	if not down then
		turtle.back()
		turn()
		
		blocks = blocks - 1
		move = false
	end
	if front then
		turn()
		move = false
	end
	
	if move then
		turtle.forward()
		blocks = blocks + 1
	end
	
	term.setCursorPos(1,1)
	term.write("blocks: " .. blocks)
	
	term.setCursorPos(1,2)
	term.write("angle: " .. angle)
end
