-- Pink floyd like prisma using defined palette
vector = require "generators.lib.vector"

function prisma(cr, palette, width, height)

	-- Draw background
	local colors = require 'colors'
	cr:set_source_rgb(colors.hex(palette.base00))
	cr:paint()

	-- Set line parameters
	local line_width = 5
	cr.line_width = line_width
	cr.line_cap = 'ROUND'

	math.randomseed(os.time())

	-- side length
	local x = 500

	-- height
	local h = math.sqrt(math.pow(x, 2) - math.pow((x/2), 2))


	cr:translate(width/2, (height/2) - h/1.5 )
	-- points
	local t_1 = vector.new(0, 0)
	local t_2 = vector.new(x/2, h)
	local t_3 = vector.new(-x/2, h)

	local c_2 = vector.new(-x/4, h/2)
	local c_1 = vector.new(x/4, h/2)


	-- The original pink floyd logo's incoming beam is about 15 degrees angled
	-- towards flat the x-axis
	local b1 = width/2 / math.sin(math.rad(width/2)) * math.sin(math.rad(15))
	local b2 = width/2 / math.sin(math.rad(width/2)) * math.sin(math.rad(7.5))
	local w_2 = vector.new(-width/2, h/2 - b1)
	local w_1 = vector.new(width/2, h/2 - b2)

	local angleIn = 30

	-- triangle
	cr:move_to(t_1:unpack())
	cr:line_to(t_2:unpack())
	cr:line_to(t_3:unpack())
	cr:line_to(t_1:unpack())


	-- helper line
	cr:move_to(c_1:unpack())
	cr:line_to(c_2:unpack())

	-- incoming
	cr:move_to(w_2:unpack())
	cr:line_to(c_2:unpack())

	cr:set_source_rgb(1, 1, 1)
	cr:stroke()

	--
	local colors = require 'colors'
	local beam_colors =  { palette.base08, palette.base09, palette.base0A,
	palette.base0B, palette.base0D, palette.base0E }



	--top point rays out
		local z = x/3
	-- out
	for i=1,6 do

		cr:set_source_rgb(colors.hex(beam_colors[7-i]))

		local wx1 = vector.new(
			width/2,
			h/2 - ((b1 - b1/6 * i) + b1/2)
		)
		local wx2 = vector.new(
			width/2,
			h/2 - ((b1 - b1/6 * (i+1)) + b1/2)
		)

		-- TODO fix these two
		--


		-- bottom
		local c_3a = vector.new(
			x/6 + ((7- i)*(x/36)),
			h/3 + ((7- i) * (h/18))
		)

		--top
		local c_3b = vector.new(
			x/6 + ((7-i-1)*(x/36)),
			h/3 + ((7- i-1) * (h/18))
		)

		cr:move_to(c_3b:unpack())
		cr:line_to(c_3a:unpack())
		cr:line_to(wx1:unpack())
		cr:line_to(wx2:unpack())
		-- cr:close_path()
		cr:fill()

		-- cr:stroke()
	end


	-- cr:close_path()

	cr:set_source_rgb(1, 1, 1)
	cr:stroke()
	-- cr:fill()
	--
	-- for name, color in pairs(palette) do
	--	print(color)
	--	cr:set_source_rgb(colors.hex(color))
	--	cr:move_to(1300, n*100)
	--	cr:line_to(1300 + 100, n*100)
	--	cr:stroke()
	--	n = n+1
	-- end

end


return prisma
