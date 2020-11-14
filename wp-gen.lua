#! /usr/bin/env lua

local M = {}
local math = require 'math'
local colors = require 'colors'

-- Simulate a harmonograph
function M.harmonograph(cr, palette, width, height)

	-- From Wikipedia: [...] A typical harmonograph has two pendulums that move
	-- in such a fashion, and a pen that is moved by two perpendicular rods
	-- connected to these pendulums.  Therefore, the path of the harmonograph
	-- figure is described by the parametric equations.
	--
	-- [..] in which:
	--
	-- f represents frequency
	-- p represents phase
	-- A represents amplitude
	-- d represents damping
	-- t represents time
	--
	-- The position of the pen can be calculated by:
	-- y  = A3 * sin(t*f3 + p3 ) * e^(−d * 3t) + A4 * sin( t * f4 + p4 ) * e^(−d4 * t)
	-- x  = A1 * sin(t*f1 + p1 ) * e^(−d * 1t) + A2 * sin( t * f2 + p2 ) * e^(−d2 * t)

	-- Random seed and function parameters
	math.randomseed(os.time())

	local f1, f2, f3, f4 = math.random(15), math.random(15), math.random(15), math.random(15)
	local d1, d2, d3, d4 = math.random() * 0.04, math.random() * 0.04, math.random() * 0.04, math.random() * 0.04
	local p1, p2, p3, p4 = (math.random() * math.pi), (math.random() * math.pi), (math.random() * math.pi), (math.random() * math.pi)

	-- Amplitude should be around half the screen size
	local Ax1, Ax2 = width / 4 + math.random(width/4), width / 4 + math.random(width/4)
	local Ay1, Ay2 = height / 4 + math.random(height/4), height / 4 + math.random(height/4)

	-- Draw background
	cr:set_source_rgb(colors.hex( palette.base02))
	cr:paint()

	-- Set line parameters
	cr:set_source_rgb(colors.hex(palette.base0D))
	cr.line_width = 2

	-- Center on screen
	cr:translate(width/2, height/2)

	-- Start position doesn't really matter, since the first line be fully transparent
	local x, y = 0, 0

	local fg_colors =  { palette.base08, palette.base09, palette.base0A,
	palette.base0B, palette.base0C, palette.base0D, palette.base0E,
	palette.base0F }

	-- Pick a random foregraound color
	local col = fg_colors[math.random(#fg_colors)]

	for t = 0, 100, 0.01 do

		-- Fade the color in using the alpha channel
		cr:set_source_rgba( colors.hex(col, t/100))

		-- Move to previous point
		cr:move_to(x, y)

		-- Calculate position and draw line to it
		x = (Ax1 * (math.exp(-d1*t) * math.sin(t*f1+p1))) + (Ax2 * (math.exp(-d2*t) * math.sin(t* f2 + p2)))
		y = (Ay1 * (math.exp(-d3*t) * math.sin(t*f3+p3))) + (Ay2 * (math.exp(-d4*t) * math.sin(t* f4 + p4)))
		cr:line_to(x, y)
		cr:stroke()
	end
end

-- Minimalistic wallpaper with colored lines
function M.lines(cr, palette, width, height)

	-- Draw background
	cr:set_source_rgb(colors.hex( palette.base02))
	cr:paint()

	-- Set line parameters
	local line_width = 100
	cr.line_width = line_width
	cr.line_cap = 'ROUND'

	local fg_colors =  { palette.base08, palette.base09, palette.base0A,
	palette.base0B, palette.base0C, palette.base0D, palette.base0E,
	palette.base0F }

	math.randomseed(os.time())

	-- Iterate lines
	for y = line_width + 5, height - line_width/2, line_width + 5 do

		-- Pick a random foregraound color
		local col = fg_colors[math.random(#fg_colors)]
		cr:set_source_rgb(colors.hex(col))

		-- Randomize length
		length = math.random(width)

		-- Start
		local x = math.random(width)

		cr:move_to(x,y)
		cr:line_to(x+length, y)
		cr:stroke()

	end
end

-- Draw the Batman symbol using the batman equation. This one is quite poor in
-- performance, you might not want to call it too often
-- https://math.stackexchange.com/questions/54506/is-this-batman-equation-for-real
--
-- (Yes, it is.)
--
function M.batman(cr, palette, width, height)

	-- Draw background
	cr:set_source_rgb(colors.hex( palette.base02))
	cr:paint()

	-- Set line parameters
	cr.line_width = 10
	cr.line_cap = 'ROUND'
	cr.line_join = 'CAIRO_LINE_JOIN_ROUND'

	-- Pick a random foreground color
	math.randomseed(os.time())

	local fg_colors =  { palette.base08, palette.base09, palette.base0A,
	palette.base0B, palette.base0C, palette.base0D, palette.base0E,
	palette.base0F }
	local col = fg_colors[math.random(#fg_colors)]
	cr:set_source_rgb(colors.hex(col))

	-- Center
	cr:translate(width/2, height/2)

	-- Helper function to draw circles at x, y
	local function dot(x,y)
		-- Scaling factor
		local a = -100
		cr:arc(x*a, y*a , 1,0 ,math.rad(350))
		cr:stroke()
	end

	-- The result of 2 hours of pain
	for x = -8, 8, 0.001 do

		dot(x ,
			2 * math.sqrt(
				-1 * math.abs( math.abs(x) - 1) *
				math.abs(3 -  math.abs(x)) /
				(
					(math.abs(x) - 1) *
					(3 -  math.abs(x))
				)
			) *
			(
				1 +  math.abs(math.abs(x) - 3) / (math.abs(x) - 3)
			) *
			math.sqrt(1 - math.pow(x / 7,2)) +
			(
				5 + 0.97 * (
					math.abs(x - 0.5) + math.abs(x + 0.5)
				) - 3 *
				( math.abs(x - 0.75) +  math.abs(x + 0.75))
			) *
			(
				1 + math.abs(1 - math.abs(x)) /
				(1 -  math.abs(x))
			)
		)

		dot(x,
			-3 * math.sqrt(1 - math.pow(x / 7,2)) *
			math.sqrt(math.abs(math.abs(x) - 4) / ( math.abs(x) - 4))
		)

		dot(x,
			math.abs(x / 2) - 0.0913722 * math.pow(x,2) - 3 +
			math.sqrt(
				1 - math.pow(math.abs(math.abs(x) - 2) - 1,2)
			)
		)

		dot(x,
			0.9 + math.sqrt(
				math.abs(math.abs(x) - 1) /
				(math.abs(x) - 1)
			) *
			(
				2.71052 + 1.5 - 0.5 *  math.abs(x) - 1.35526 *
				math.sqrt(
					4 - math.pow(math.abs(x) - 1, 2)
				)
			)
		)
	end
end

return M
