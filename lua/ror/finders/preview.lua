local M = {}

function M.find()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local previewers = require("telescope.previewers")
	local conf = require("telescope.config").values
	local root_path = vim.fn.getcwd()
	local previews = vim.split(vim.fn.globpath(root_path .. "/app/previews", "**/*.{rb,erb}"), "\n")
	local parsed_previews = {}
	for _, value in ipairs(previews) do
		-- take only the filename without extension
		if value ~= "" then
			local parsed_filename = vim.fn.fnamemodify(value, ":~:.")
			table.insert(parsed_previews, parsed_filename)
		end
	end

	local opts = {}
	pickers
		.new(opts, {
			prompt_title = "Previews",
			finder = finders.new_table({
				results = parsed_previews,
			}),
			previewer = previewers.vim_buffer_cat.new(opts),
			sorter = conf.generic_sorter(opts),
		})
		:find()
end

return M
