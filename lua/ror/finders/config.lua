local M = {}

function M.find()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local previewers = require("telescope.previewers")
	local conf = require("telescope.config").values
	local root_path = vim.fn.getcwd()
	local configs = vim.split(vim.fn.glob(root_path .. "/config/**/*"), "\n")
	local parsed_configs = {}
	for _, value in ipairs(configs) do
		-- take only the filename without extension
		if value ~= "" then
			local parsed_filename = vim.fn.fnamemodify(value, ":~:.")
			table.insert(parsed_configs, parsed_filename)
		end
	end

	local opts = {}
	pickers
		.new(opts, {
			prompt_title = "Configs",
			finder = finders.new_table({
				results = parsed_configs,
			}),
			previewer = previewers.vim_buffer_cat.new(opts),
			sorter = conf.generic_sorter(opts),
		})
		:find()
end

return M
