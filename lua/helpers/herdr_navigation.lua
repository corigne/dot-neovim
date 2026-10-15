local M = {}

local function config_path(root)
	return vim.fs.joinpath(root, "editor", "nvim.lua")
end

function M.find_config()
	local override = vim.env.HERDR_VIM_NAVIGATION
	if override and override ~= "" then
		local path = config_path(vim.fn.expand(override))
		if (vim.uv or vim.loop).fs_stat(path) then
			return path
		end

		error("HERDR_VIM_NAVIGATION does not contain editor/nvim.lua: " .. override)
	end

	local home = (vim.uv or vim.loop).os_homedir()
	if not home then
		return nil
	end

	local roots = vim.fs.find("vim-herdr-navigation", {
		path = home,
		type = "directory",
		limit = 1,
	})
	local path = roots[1] and config_path(roots[1]) or nil

	if path and (vim.uv or vim.loop).fs_stat(path) then
		return path
	end

	return nil
end

return M
