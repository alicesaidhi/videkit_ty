local function quick_insert(src: {[any]: any}, items: {[any]: any}, index: number)

	table.move(src, index, #src, index + #items)
	table.move(items, 1, #items, index, src)

end

local function quick_remove(src: {[any]: any}, start, total)

	local last = start + total
	local total_other = #src - last

	table.move(src, last, #src, start)
	table.move({}, 1, math.max(total_other, total), start + total_other + 1, src)

end

return {
	insert = quick_insert,
	remove = quick_remove
}