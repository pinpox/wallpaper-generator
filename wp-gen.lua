#! /usr/bin/env lua

local math = require 'math'
local lgi = require 'lgi'

local M = {}



function M.harmonograph(cr, colors, width, height)

	-- From Wikipedia: [...] A typical harmonograph has two pendulums that move
	-- in such a fashion, and a pen that is moved by two perpendicular rods
	-- connected to these pendulums.  Therefore, the path of the harmonograph
	-- figure is described by the parametric equations.
	--
	-- [..] in which:
	--
	-- f represents frequency,
	-- p p represents phase,
	-- A represents amplitude,
	-- d represents damping and
	-- t represents time.
	--
	-- y  = A3 * sin(t*f3 + p3 ) * e^(−d * 3t) + A4 * sin( t * f4 + p4 ) * e^(−d4 * t)
    -- x  = A1 * sin(t*f1 + p1 ) * e^(−d * 1t) + A2 * sin( t * f2 + p2 ) * e^(−d2 * t)
	--
	
	-- set random seed
	math.randomseed( os.time() )

	-- local A1, A2, A3, A4 = 1000, 200, 200, 200
	-- local f1, f2, f3, f4 = 0.2, 0.2, 0.2, 0.2
	-- local d = 0.009
	-- local p1, p2, p3, p4 = math.random(2 * math.pi),  math.random(2 * math.pi),  math.random(2 * math.pi),  math.random(2 * math.pi)


f1=3.001
f2=2
f3=3
f4=2
d1=0.004
d2=0.0065
d3=0.008
d4=0.019
p1=0
p2=0
p3=math.pi/2
p4=3*math.pi/2



f1=10
f2=6
f3=1.002
f4=3
d1=0.02
d2=0.0315
d3=0.02
d4=0.02
p1=math.pi/16
p2=3 * math.pi/2
p3=13 * math.pi/16
p4=math.pi

	-- background
    cr:set_source_rgb(hex(colors.base02))
    cr:paint()

	-- line parameters
    -- cr:set_source_rgb(hex(colors.base0D))
	print(hex(colors.base0D))
	print(interpolate(hex(colors.base0D)))

	cr:set_source_rgb(interpolate(hex(colors.base0D)))
	cr.line_width = 2
	cr.line_cap = 'ROUND'

	-- start position
	cr:translate(width/2, height/2)
	-- local y = A3 * math.sin(p3) + A4 * math.sin(p4)
	-- local x = A1 * math.sin(p1) + A2 * math.sin(p2)

	local y = 500 * (math.sin(p3) + math.sin(p4))
	local x = 500 * (math.sin(p1) + math.sin(p2))

	for t=0, 10, 0.01 do


		-- cr:set_source_rgb(interpolate(hex(colors.base0D)), 1)
		-- x = (math.exp(-d1*t) * math.sin(t*f1+p1)) + (math.exp(-d2*t) * math.sin(t* f2 + p2))
		-- y = (math.exp(-d3*t) * math.sin(t*f3+p3)) + (math.exp(-d4*t) * math.sin(t* f4 + p4))

	    cr:move_to(x, y)
		-- x = (A1 * math.sin(t * f1 + p1) * math.exp((-1) * d * t)) + A2 * math.sin(t * f2 + p2) * math.exp((-1) * d * t)
		-- y = (A3 * math.sin(t * f3 + p3) * math.exp((-1) * d * t)) + A4 * math.sin(t * f4 + p4) * math.exp((-1) * d * t)

		x = 500 * (math.exp(-d1*t) * math.sin(t*f1+p1)) + (math.exp(-d2*t) * math.sin(t* f2 + p2))
		y = 500 * (math.exp(-d3*t) * math.sin(t*f3+p3)) + (math.exp(-d4*t) * math.sin(t* f4 + p4))
		cr:line_to(x, y)
		cr:stroke()
	end
end

return M
