local M = {}

-- Check if timing is enabled via nvim +timing or +profile args
local function is_timing_enabled()
	for _, arg in ipairs(vim.v.argv) do
		if arg == "+timing" or arg == "+profile" then
			return true
		end
	end
	return false
end

local timing_enabled = is_timing_enabled()
local load_times = {}

--- Wrapper for require() that optionally reports load time
--- Usage: require_with_timing('module_name')
--- Enable timing with: nvim +timing <file>
function M.require_with_timing(module_name)
	local start_time = timing_enabled and vim.loop.hrtime() or nil

	local success, module = pcall(require, module_name)

	if timing_enabled and start_time then
		local end_time = vim.loop.hrtime()
		local elapsed_ms = (end_time - start_time) / 1000000 -- Convert nanoseconds to milliseconds
		load_times[module_name] = elapsed_ms
		print(string.format("[TIMING] %s: %.2fms", module_name, elapsed_ms))
	end

	if not success then
		vim.notify(string.format("Failed to load module: %s\nError: %s", module_name, module), vim.log.levels.ERROR)
		return nil
	end

	return module
end

--- Load multiple modules with optional timing
--- Supports two formats:
---   1. Simple list: M.load_modules({'plugins', 'core', 'keymap'})
---   2. Structured: M.load_modules({core = {...}, optional = {{modules = {...}, condition = ...}}})
function M.load_modules(modules)
	if type(modules) ~= "table" then
		vim.notify("load_modules expects a table of module names", vim.log.levels.ERROR)
		return
	end

	-- Handle structured module format with core and optional keys
	if modules.core or modules.optional then
		if modules.core then
			for _, module_name in ipairs(modules.core) do
				M.require_with_timing(module_name)
			end
		end

		if modules.optional then
			for _, optional_config in ipairs(modules.optional) do
				if optional_config.condition then
					for _, module_name in ipairs(optional_config.modules) do
						M.require_with_timing(module_name)
					end
				end
			end
		end

		if timing_enabled then
			M.print_timing_summary()
		end
		return
	end

	-- Handle simple list format: {'module1', 'module2', ...}
	for _, module_name in ipairs(modules) do
		M.require_with_timing(module_name)
	end

	if timing_enabled then
		M.print_timing_summary()
	end
end

--- Print a summary of load times
function M.print_timing_summary()
	if vim.tbl_isempty(load_times) then
		return
	end

	print("\n" .. string.rep("=", 50))
	print("MODULE LOAD TIME SUMMARY")
	print(string.rep("=", 50))

	local total_time = 0
	for module_name, elapsed_ms in pairs(load_times) do
		total_time = total_time + elapsed_ms
	end

	-- Sort by load time (descending)
	local sorted = {}
	for module_name, elapsed_ms in pairs(load_times) do
		table.insert(sorted, { name = module_name, time = elapsed_ms })
	end
	table.sort(sorted, function(a, b)
		return a.time > b.time
	end)

	for _, entry in ipairs(sorted) do
		local percentage = (entry.time / total_time) * 100
		print(string.format("  %-30s %8.2fms (%5.1f%%)", entry.name, entry.time, percentage))
	end

	print(string.rep("=", 50))
	print(string.format("Total load time: %.2fms\n", total_time))
end

return M
