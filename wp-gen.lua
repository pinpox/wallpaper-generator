
local M = {}

-- Luafilesystem allows to iterate over a directory.
local Lfs = require "lfs"

local folderOfThisFile = (...):match("(.-)[^%.]+$")

-- for each filename in the directory
for filename in Lfs.dir (folderOfThisFile .. "generators/" )do
	-- if it is a file
	if Lfs.attributes (folderOfThisFile .. "generators/" .. filename, "mode") == "file" then



		-- transform the filename into a module name
		local name = folderOfThisFile .. "generators/" .. filename
		name = name:sub (1, #name-4)
		name = name:gsub ("/", ".")
		print(name)
		-- and require it
		M[name] = require (name)
	end
end

return M
