#! /usr/bin/env lua
local lgi = require 'lgi'
local argparse = require "argparse"
local cairo = lgi.cairo



local parser = argparse("wallpaper-generator", "Generate wallpapers")
parser:argument("generator", "Generator to use. See ./generators for available choices")
parser:option("-o --output", "Output file.", "generated.png")
parser:option("--width", "Width of the image", 1920)
parser:option("--height", "Height of the image", 1080)
parser:option("--base00", "Hex color for base00.", "#0b0b14")
parser:option("--base01", "Hex color for base01.", "#13131a")
parser:option("--base02", "Hex color for base02.", "#262631")
parser:option("--base03", "Hex color for base03.", "#3a3a47")
parser:option("--base04", "Hex color for base04.", "#69697c")
parser:option("--base05", "Hex color for base05.", "#babac8")
parser:option("--base06", "Hex color for base06.", "#cfcfdd")
parser:option("--base07", "Hex color for base07.", "#ffffff")
parser:option("--base08", "Hex color for base08.", "#ff4040")
parser:option("--base09", "Hex color for base09.", "#ff9326")
parser:option("--base0A", "Hex color for base0A.", "#ffcb65")
parser:option("--base0B", "Hex color for base0B.", "#9ceb4f")
parser:option("--base0C", "Hex color for base0C.", "#18ffe0")
parser:option("--base0D", "Hex color for base0D.", "#31baff")
parser:option("--base0E", "Hex color for base0E.", "#9d8cff")
parser:option("--base0F", "Hex color for base0F.", "#3f3866")

local args = parser:parse()

-- Colors from xresources
local palette = {}
palette.base00 = args.base00
palette.base01 = args.base01
palette.base02 = args.base02
palette.base03 = args.base03
palette.base04 = args.base04
palette.base05 = args.base05
palette.base06 = args.base06
palette.base07 = args.base07
palette.base08 = args.base08
palette.base09 = args.base09
palette.base0A = args.base0A
palette.base0B = args.base0B
palette.base0C = args.base0C
palette.base0D = args.base0D
palette.base0E = args.base0E
palette.base0F = args.base0F

local generator = require ("generators/" .. args.generator)

print("Running generator: " .. arg[1])

-- Create drawing surface and context
local surface = cairo.RecordingSurface(cairo.Content.COLOR,
cairo.Rectangle { x = 0, y = 0, width = args.width, height = args.height })
local cr = cairo.Context(surface)

-- Run generator
generator(cr, palette, args.width, args.height)

-- Create PNG file
surface:write_to_png(args.output)
