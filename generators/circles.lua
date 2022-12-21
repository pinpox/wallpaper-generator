local vector = require 'generators.lib.vector'

local function collisionInCircle(circle, circlesTable)
    local ans = false
    local i = 1
    while not ans and i <= #circlesTable do
        local temp = circle.center - circlesTable[i].center
        ans = temp:length() < circlesTable[i].radius
        i = i + 1
    end
    return ans
end

function maxRadiusOthers(circle, circlesTable, margin, max_dim)
    local r = max_dim
    i = 1
    while i <= #circlesTable do
        local temp = circle.center - circlesTable[i].center
        r = math.min(r, temp:length() - circlesTable[i].radius - margin)
        i = i + 1
    end
    return r
end

local function maxRadiusEdges(circle, margin, w, h)
    return math.min(w - 1 - margin - circle.center.x,
                    circle.center.x - margin,
                    circle.center.y - margin,
                    h - 1 - margin - circle.center.y)
end

local function circles(cr, palette, width, height)
    local margin = 5
    local nCircles = 100
    -- Draw background
    local colors = require 'colors'
    cr:set_source_rgb(colors.hex(palette.base02))
    cr:paint()
    --
    local fg_colors =  { palette.base08, palette.base09, palette.base0A,
                         palette.base0B, palette.base0C, palette.base0D, palette.base0E,
                         palette.base0F }
    --
    math.randomseed(os.time())
    local cTable = {}
    local center
    local cercle
    while #cTable < nCircles do
        center = vector.new(math.random(width), math.random(height))
        cercle = {center = center, radius = 1}
        --
        if not collisionInCircle(cercle, cTable) then
            cercle.radius = math.min(maxRadiusOthers(cercle, cTable, margin, math.min(width, height)),
                                     maxRadiusEdges(cercle, margin, width, height))
            if cercle.radius > 0 then
                table.insert(cTable, cercle)
                --
                local col = fg_colors[math.random(#fg_colors)]
                cr:set_source_rgb(colors.hex(col))
                cr:arc(center.x, center.y, cercle.radius, 0, 6.28)
                cr:fill()
            end
        end
    end
end

return circles
