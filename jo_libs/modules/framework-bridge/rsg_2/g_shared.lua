-- local RSGCore = exports["rsg-core"]:GetCoreObject()
-- jo.framework.core = RSGCore

-- function jo.framework:getInventoryItems()
--   local itemsRSG = self.core.Shared.Items
--   local items = {}
--   for id, item in pairs(itemsRSG) do
--     items[id] = {
--       item = id,
--       label = item.label,
--       type = item.type,
--       description = item.description,
--       image = "nui://rsg_inventory/html/images/" .. item.image .. ".png"
--     }
--   end
--   return items
-- end


local RSGCore = exports["rsg-core"]:GetCoreObject()
jo.framework.core = RSGCore

function jo.framework:getInventoryItems()
    local itemsRSG = self.core.Shared.Items or {}
    local items = {}

    for id, item in pairs(itemsRSG) do
        local image = item.image

        -- Fallback if item has no image field
        if not image or image == "" then
            print(("[jo_libs] WARNING: Item '%s' is missing image field. Using default.png"):format(id))
            image = "default.png"
        end

        -- Prevent double .png
        if not image:match("%.png$") then
            image = image .. ".png"
        end

        items[id] = {
            item = id,
            label = item.label or id,
            type = item.type or "item",
            description = item.description or "",
            image = "nui://rsg_inventory/html/images/" .. image
        }
    end

    return items
end
