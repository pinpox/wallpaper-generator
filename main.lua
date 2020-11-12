
local lgi = require 'lgi'
local cairo = lgi.cairo

-- Set output size, e.g. your screen resolution
width = 1920
height = 1080

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


generators = require("wp-gen")

-- Iterate through all generators and create .png files from them
for name, gen in pairs(generators) do

	-- Create drawing surface and run generator
	local surface = cairo.RecordingSurface(cairo.Content.COLOR,
	cairo.Rectangle { x = 0, y = 0, width = width, height = height })
	local cr = cairo.Context(surface)

	-- gen(cr, colors, width, height)

	-- Create PNG file
	surface:write_to_png('generator-' .. name .. '.png')
end
