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

	local c_1 = vector.new(x/4, h/2)
	local c_2 = vector.new(-x/4, h/2)

	local angleIn = 30

	cr:move_to(t_1:unpack())
	cr:line_to(t_2:unpack())
	cr:line_to(t_3:unpack())
	cr:line_to(t_1:unpack())


	-- helper line
	cr:move_to(c_1:unpack())
	cr:line_to(c_2:unpack())

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
