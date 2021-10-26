local angle = 0
local blocks = 0

local output = {}

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
	local direction = math.random(0,1)
	
	while true do
		if direction == 0 then
			turtle.turnRight()
			log("turn right")
			
			angle = wrap(angle + 1,-1,2)
		end
		if direction == 1 then
			turtle.turnLeft()
			log("turn left")
			
			angle = wrap(angle - 1,-1,2)
		end
		
		if not turtle.inspect() then
			break
		end
	end
end

function log(text)
	if #output > 9 then
		table.remove(output,9)
	end
	
	table.insert(output,1,text)
	
	for i,line in pairs(output) do
		term.setCursorPos(1,4 + i)
		term.clearLine()	
		term.write(line)
	end
end

term.clear()

while true do
	while true do
		local down = turtle.inspectDown()
		local front = turtle.inspect()
		
		if not down then
			repeat turtle.down(); log("falling")
			until turtle.inspectDown()
			
			log("landed")
			
			break
		end
		if front then
			turn()
			log("hit block")
			
			break
		end
		
		turtle.forward()
		blocks = blocks + 1
		
		log("forward")
		
		term.setCursorPos(1,1)
		term.clearLine()
		term.write("blocks: " .. blocks)
		
		term.setCursorPos(1,2)
		term.clearLine()
		term.write("angle: " .. angle)
		
		term.setCursorPos(1,3)
		term.clearLine()
		term.write("fuel: " .. turtle.getFuelLevel())
		
		if not turtle.inspect() then
			turtle.suck()
		end
	end
end
