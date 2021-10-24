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
	if #output > 10 then
		table.remove(output,10)
	end
	
	table.insert(output,text)
	
	for i,line in pairs(log) do
		term.setCursorPos(1,3 + i)
		term.clearLine()	
		term.write(line)
	end
end

while true do	
	term.setCursorPos(1,1)
	term.clearLine()
	term.write("blocks: " .. blocks)
	
	term.setCursorPos(1,2)
	term.clearLine()
	term.write("angle: " .. angle)
	
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
		log("forward")
		
		blocks = blocks + 1
	end
end
