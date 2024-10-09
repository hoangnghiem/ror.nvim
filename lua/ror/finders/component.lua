local M = {}

function M.find()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local previewers = require("telescope.previewers")
	local conf = require("telescope.config").values
	local root_path = vim.fn.getcwd()
	local components = vim.split(vim.fn.globpath(root_path .. "/app/components", "**/*.{rb,erb}"), "\n")
	local parsed_components = {}
	for _, value in ipairs(components) do
		-- take only the filename without extension
		if value ~= "" then
			local parsed_filename = vim.fn.fnamemodify(value, ":~:.")
			table.insert(parsed_components, parsed_filename)
		end
	end

	local opts = {}
	pickers
		.new(opts, {
			prompt_title = "Components",
			finder = finders.new_table({
				results = parsed_components,
			}),
			previewer = previewers.vim_buffer_cat.new(opts),
			sorter = conf.generic_sorter(opts),
		})
		:find()
end

return M
