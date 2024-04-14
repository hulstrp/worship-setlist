if Config.Inventory ~= "qs-inventory" then
    return
end


function GiveItemWithMetadata(source, item, count, metadata)
    -- source: Player source
    -- item: Name of the item to deliver
    -- count: Quantity of the item to deliver
    -- slot: Choose a specific slot or use nil to use the last empty
    -- metadata: Insert the metadata you want to give to the item, valid number and string
    exports['qs-inventory']:AddItem(source, item, count, nil, metadata)
end
