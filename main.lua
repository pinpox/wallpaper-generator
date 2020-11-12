#! /usr/bin/env lua

--
-- Sample cairo application, based on http://cairographics.org/generators/
--
-- Renders all generators into separate PNG images
--

local math = require 'math'
local lgi = require 'lgi'
local cairo = lgi.cairo

local dir = arg[0]:sub(1, arg[0]:find('[^%/\\]+$') - 1):gsub('[/\\]$', '')
local imagename = dir .. '/gtk-demo/apple-red.png'

local generators = {}


local function interpolate(r, g, b, step)
	-- print(r)
	-- print(g)
	-- print(b)
	return r, g, b
end

local function hex (hex, alpha)
	local hash,redColor,greenColor,blueColor=hex:match('(.)(..)(..)(..)')
	redColor, greenColor, blueColor = tonumber(redColor, 16)/255, tonumber(greenColor, 16)/255, tonumber(blueColor, 16)/255
	redColor, greenColor, blueColor = math.floor(redColor*100)/100, math.floor(greenColor*100)/100, math.floor(blueColor*100)/100
	if alpha == nil then
		return redColor, greenColor, blueColor
	end
	return redColor, greenColor, blueColor, alpha
end


function generators.harmonograph(cr, colors, width, height)

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

	for t=0, 1000, 0.01 do


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


-- Iterate through all generators and create .png files from them
for name, gen in pairs(generators) do

	-- Set output size, e.g. your screen resolution
	local width = 1920
	local height = 1080

	-- Colors from xresources
	colors = {}
	colors.base00 = "#0b0b14"
	colors.base01 = "#13131a"
	colors.base02 = "#262631"
	colors.base03 = "#3a3a47"
	colors.base04 = "#69697c"
	colors.base05 = "#babac8"
	colors.base06 = "#cfcfdd"
	colors.base07 = "#ffffff"
	colors.base08 = "#ff4040"
	colors.base09 = "#ff9326"
	colors.base0A = "#ffcb65"
	colors.base0B = "#9ceb4f"
	colors.base0C = "#18ffe0"
	colors.base0D = "#31baff"
	colors.base0E = "#9d8cff"
	colors.base0F = "#3f3866"

	-- Create drawing surface and run generator
	-- local surface = cairo.ImageSurface.create('ARGB32', width,height)
	-- local cr = cairo.Context.create(surface)

    local surface = cairo.RecordingSurface(cairo.Content.COLOR,
    cairo.Rectangle { x = 0, y = 0, width = width, height = height })
    local cr = cairo.Context(surface)

	gen(cr, colors, width, height)

	-- Create PNG file
	surface:write_to_png('cairodemo-' .. name .. '.png')
end
