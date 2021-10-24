local angle = 0
local blocks = 0

local log = {}

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
	local turn = math.random()
	
	while true do
		if turn > 0.5 then
			turtle.turnRight()
			angle = wrap(angle + 1,-2,2)
		end
		if turn < 0.5 then
			turtle.turnLeft()
			angle = wrap(angle - 1,-2,2)
		end
		
		if not turtle.inspect() then
			break
		end
	end
end

local function log(text)
	if #log > 10 then
		table.remove(log,10)
	end
	
	table.insert(log,text)
end

while true do
	term.clear()
	
	term.setCursorPos(1,1)
	term.write("blocks: " .. blocks)
	
	term.setCursorPos(1,2)
	term.write("angle: " .. angle)
	
	while true do
		local down = turtle.inspectDown()
		local front = turtle.inspect()
		
		if not down then
			repeat turtle.down()
			until turtle.inspectDown()
			
			break
		end
		if front then
			turn()
			break
		end
		
		turtle.forward()
		blocks = blocks + 1
	end
end
