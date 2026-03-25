-- ~/.config/yazi/plugins/kdeconnect-send.yazi/main.lua

-- Function to run a command and get its output (Corrected Args Handling)
local function run_command(cmd_args)
	ya.dbg("[kdeconnect-send] Running command: ", table.concat(cmd_args, " "))

	-- Separate the command from the arguments
	local command_name = cmd_args[1]
	local arguments = {}
	for i = 2, #cmd_args do
		table.insert(arguments, cmd_args[i])
	end
	ya.dbg("[kdeconnect-send] Command Name: ", command_name)
	ya.dbg("[kdeconnect-send] Arguments Table: ", arguments)

	-- Build the command correctly
	local cmd_builder = Command(command_name)
	for _, arg_value in ipairs(arguments) do
		cmd_builder:arg(arg_value)
	end

	local child, err = cmd_builder:stdout(Command.PIPED):stderr(Command.PIPED):spawn()

	if err then
		ya.err("[kdeconnect-send] Spawn error: ", err)
		return nil, err
	end
	local output, wait_err = child:wait_with_output()
	ya.dbg("[kdeconnect-send] wait_with_output finished.")
	if wait_err then
		ya.err("[kdeconnect-send] Wait error received: ", wait_err)
		return nil, wait_err
	end
	if not output then
		ya.err("[kdeconnect-send] Wait finished but output object is nil.")
		return nil, Error("Command wait returned nil output")
	end
	ya.dbg("[kdeconnect-send] Command Status Success: ", output.status.success)
	ya.dbg("[kdeconnect-send] Command Status Code: ", output.status.code)
	ya.dbg("[kdeconnect-send] Command Stdout: ", output.stdout or "nil")
	ya.dbg("[kdeconnect-send] Command Stderr: ", output.stderr or "nil")

	-- Note: The check for "0 devices found" might need adjustment depending on the output format of 'kdeconnect-cli -a'
	if output.stderr and output.stderr:match("^0 devices found") then
		ya.dbg("[kdeconnect-send] Command reported 0 devices found in stderr. Returning empty.")
		return "", nil
	end
	-- Also check stdout for potential "no devices" messages if -a uses stdout differently
	if output.stdout and output.stdout:match("no available devices found") then -- Example check, adjust if needed
		ya.dbg("[kdeconnect-send] Command reported no available devices in stdout. Returning empty.")
		return "", nil
	end

	if not output.status.success then
		local error_msg = "Command failed with code "
			.. tostring(output.status.code or "unknown")
			.. ": "
			.. command_name
		if output.stderr and #output.stderr > 0 then
			error_msg = error_msg .. "\nStderr: " .. output.stderr
		end
		if output.stdout and #output.stdout > 0 then
			error_msg = error_msg .. "\nStdout: " .. output.stdout
		end
		ya.err("[kdeconnect-send] Command execution failed: ", error_msg)
		return nil, Error(error_msg)
	end
	return output.stdout, nil
end

-- Helper function to check if a URL exists in the values of the selected map
local function isSelected(url_to_check, selected_map)
	if not url_to_check or not selected_map then
		return false
	end
	local url_str_to_check = tostring(url_to_check) -- Compare string representations for consistency
	for _, selected_url in pairs(selected_map) do
		if selected_url and tostring(selected_url) == url_str_to_check then
			return true
		end
	end
	return false
end

local get_selection_details = ya.sync(function()
	ya.dbg("[kdeconnect-send] Entering get_selection_details sync block (Using cha via current.files)")
	local selected_map = cx.active.selected
	local current_files = cx.active.current.files

	if not selected_map or not current_files then
		ya.err("[kdeconnect-send] cx.active.selected or cx.active.current.files is nil!")
		return {}, false -- Return empty if essential data is missing
	end

	-- Check if selection is empty early to potentially save iteration
	local selection_empty = true
	for _ in pairs(selected_map) do
		selection_empty = false
		break
	end
	if selection_empty then
		local hovered_file = cx.active.current.hovered -- Use the hovered file under cursor
		if hovered_file then
			ya.dbg(
				"[kdeconnect-send] Nothing was selected. Will now use the hovered file under cursor: ",
				tostring(hovered_file.url)
			)
			-- For safety, only treat as a regular file when cha.is_dir is explicitly false.
			-- If cha is missing or is_dir is nil/true, treat as a (potential) directory.
			if hovered_file.cha and hovered_file.cha.is_dir == false then
				return { tostring(hovered_file.url) }, false -- Regular file hovered
			else
				return {}, true -- Directory or indeterminate entry: mark directory_selected
			end
		end
		return {}, false
	end

	local regular_files = {}
	local directory_selected = false

	local success, err = pcall(function()
		-- Iterate through the files in the current view
		for i = 1, #current_files do
			local file = current_files[i] -- Access fs::File object by index [cite: 15]

			if file and file.url and file.cha then
				-- Check if this file's URL is in the selected map
				if isSelected(file.url, selected_map) then
					ya.dbg("[kdeconnect-send] File is selected: ", tostring(file.url))

					-- Now check its cha.is_dir property
					if file.cha.is_dir == true then
						ya.dbg("[kdeconnect-send] Selected item is a directory (cha.is_dir): ", tostring(file.url))
						directory_selected = true
						-- Optional: If finding one directory is enough, you could break the loop here
						-- if you primarily care about blocking directory sends.
						-- break
					elseif file.cha.is_dir == false then
						-- It's selected and not a directory, assume regular file
						ya.dbg(
							"[kdeconnect-send] Selected item is a regular file (cha.is_dir is false): ",
							tostring(file.url)
						)
						table.insert(regular_files, tostring(file.url))
					else
						-- cha.is_dir might be nil (e.g., dummy file)
						ya.warn(
							"[kdeconnect-send] file.cha.is_dir is nil for selected file: ",
							tostring(file.url),
							". Treating as potential directory."
						)
						directory_selected = true -- Treat indeterminate as directory for safety
					end
				end
			elseif file and file.url then
				-- File exists but cha doesn't? Check if it's selected anyway.
				if isSelected(file.url, selected_map) then
					ya.warn(
						"[kdeconnect-send] Selected file is missing 'cha' property: ",
						tostring(file.url),
						". Treating as potential directory."
					)
					directory_selected = true -- Treat files missing 'cha' as directories for safety
				end
			else
				-- Handle cases where file or file.url might be nil within the loop if necessary
				ya.warn("[kdeconnect-send] Encountered nil file or file.url at index: ", i)
			end
		end
	end)

	if not success then
		ya.err("[kdeconnect-send] Error during current_files iteration or isSelected check: ", err)
		return {}, false -- Return empty on error
	end

	-- Add a final check: if directory_selected is true, we might not need the regular_files list depending on use case.
	-- The current implementation returns both.

	ya.dbg(
		"[kdeconnect-send] Exiting get_selection_details sync block. Found regular files: ",
		#regular_files,
		" Directory selected (based on cha): ",
		directory_selected
	)
	return regular_files, directory_selected
end)

local state_option = ya.sync(function(state, attr)
	return state[attr]
end)

return {
	setup = function(state, options)
		state.auto_select_single = options.auto_select_single
	end,

	entry = function(_, job)
		ya.dbg("[kdeconnect-send] Plugin entry point triggered.")

		-- Get configuration option for auto_select_single (default: true)
		local auto_select_single = state_option("auto_select_single")
		if auto_select_single == nil then
			auto_select_single = true
		end
		ya.dbg("[kdeconnect-send] auto_select_single option: ", auto_select_single)

		-- 1. Get selection details (files and directory flag) using Reverted Sync Check
		local selected_files, directory_selected = get_selection_details()

		-- Handle potential errors if get_selection_details couldn't determine selection
		if not selected_files then
			ya.err("[kdeconnect-send] Failed to get selection details.")
			ya.notify({ title = "Plugin Error", content = "Could not read selection.", level = "error", timeout = 5 })
			return
		end

		-- 2. *** REVERTED DIRECTORY CHECK LOGIC ***
		ya.dbg("[kdeconnect-send] Checking directory_selected flag. Value: ", directory_selected)
		if directory_selected then
			ya.dbg("[kdeconnect-send] directory_selected is true (from sync check). Showing error and exiting.")
			ya.notify({
				title = "KDE Connect Send",
				content = "Cannot send directories. Please select regular files only.",
				level = "error",
				timeout = 7,
			})
			return -- Exit if a directory was detected by the sync check
		end
		ya.dbg("[kdeconnect-send] directory_selected is false (from sync check). Proceeding.")

		-- 3. Proceed only if no directory was selected and files exist
		ya.dbg("[kdeconnect-send] Checking number of regular files.")
		local len = #selected_files
		ya.dbg("[kdeconnect-send] Length of selected_files (#): ", len)

		if len == 0 then
			-- This case now means either truly no regular files were selected,
			-- or only directories were selected (and handled above),
			-- or an error occurred in get_selection_details.
			ya.dbg("[kdeconnect-send] Length is 0. No regular files to send.")
			-- Check if directory_selected was false - means no files were selected at all.
			if not directory_selected then
				ya.notify({
					title = "KDE Connect Send",
					content = "No regular files selected.",
					level = "warn",
					timeout = 5,
				})
			end
			return -- Exit cleanly
		end

		-- If we got here, directory_selected is false and len > 0.
		ya.dbg("[kdeconnect-send] Regular files found and no directories detected. Proceeding to device check.")

		-- 4. Get KDE Connect devices (using -a flag)
		ya.dbg("[kdeconnect-send] Attempting to list KDE Connect devices with 'kdeconnect-cli -a'...")
		local devices_output, err = run_command({ "kdeconnect-cli", "-a" }) -- Using -a flag

		if err then
			ya.err("[kdeconnect-send] Failed to list devices command: ", tostring(err), ". Exiting.")
			ya.notify({
				title = "KDE Connect Error",
				content = "Failed to run kdeconnect-cli -a: " .. tostring(err),
				level = "error",
				timeout = 5,
			})
			return
		end

		if not devices_output or devices_output == "" then
			ya.dbg("[kdeconnect-send] No available devices reported by kdeconnect-cli -a. Exiting silently.")
			ya.notify({
				title = "KDE Connect Send",
				content = "No available KDE Connect devices found.",
				level = "warn",
				timeout = 4,
			})
			return
		end

		-- 5. Parse devices (Adjust parsing for '-a' output format if needed)
		-- *** IMPORTANT: The parsing logic below ASSUMES '-a' output is similar to '-l' ***
		local devices = {}
		local device_list_str = "Available Devices:\n"
		local has_reachable = false -- Keep track if *any* device is found
		ya.dbg("[kdeconnect-send] Parsing device list (assuming -a format is like -l)...")
		local pattern = "^%-%s*(.+):%s*([%w_]+)%s*%((.-)%)$" -- Adjust if -a format differs
		for line in devices_output:gmatch("[^\r\n]+") do
			local name, id, status_line = line:match(pattern)
			if id and name and status_line then
				name = name:match("^%s*(.-)%s*$")
				table.insert(devices, { id = id, name = name, status = status_line })
				device_list_str = device_list_str
					.. "- "
					.. name
					.. " (ID: "
					.. id
					.. ") Status: "
					.. status_line
					.. "\n"
				has_reachable = true
			else
				ya.warn("[kdeconnect-send] Could not parse device line with pattern: ", line)
			end
		end

		if not has_reachable then
			ya.dbg(
				"[kdeconnect-send] No devices found after parsing output of 'kdeconnect-cli -a'. Exiting silently. List:\n",
				device_list_str
			)
			return
		end

		-- 6. Select Device (Using ya.which)
		local device_id = nil
		local target_device_name = "Unknown"

		if #devices == 1 and auto_select_single then
			device_id = devices[1].id
			target_device_name = devices[1].name
			ya.dbg(
				"[kdeconnect-send] Only one device found and auto-select-single is true: ",
				target_device_name,
				" (",
				device_id,
				"). Using automatically."
			)
		else
			ya.dbg("[kdeconnect-send] Prompting user with ya.which (multiple devices or auto-select-single is false)...")

			-- Prepare candidates for ya.which
			local device_choices = {}
			for i, device in ipairs(devices) do
				table.insert(device_choices, {
					on = tostring(i),
					desc = string.format("%s (%s) - %s", device.name, device.id, device.status), -- Show status in choice
				})
			end

			-- Add a cancel option
			table.insert(device_choices, { on = "q", desc = "Cancel" })

			-- Prompt the user to choose a device index
			local selected_index = ya.which({
				cands = device_choices,
			})
			ya.dbg("[kdeconnect-send] ya.which returned index: ", selected_index or "nil")

			-- Check if the user cancelled or selected the cancel option ('q')
			if not selected_index or selected_index > #devices then
				ya.warn("[kdeconnect-send] Device selection cancelled by user.")
				ya.notify({ title = "KDE Connect Send", content = "Send cancelled.", level = "info", timeout = 3 })
				return -- *** This return terminates the plugin ***
			end

			-- Get the device ID and name based on the selected index
			device_id = devices[selected_index].id
			target_device_name = devices[selected_index].name
			ya.dbg(
				"[kdeconnect-send] User selected device index ",
				selected_index,
				": ",
				target_device_name,
				" (",
				device_id,
				")"
			)
		end

		-- 7. Proceed with selected device
		ya.dbg(
			"[kdeconnect-send] Proceeding with selected device: ",
			device_id,
			" (",
			target_device_name,
			"). Starting file send loop..."
		)

		-- 8. Send files (Using selected_files list)
		local success_count = 0
		local error_count = 0
		for i, file_path in ipairs(selected_files) do -- Use selected_files here
			ya.dbg(
				"[kdeconnect-send] Sending file ",
				i,
				"/",
				#selected_files, -- Use #selected_files
				": ",
				file_path,
				" to ",
				target_device_name
			)
			local _, send_err = run_command({ "kdeconnect-cli", "--share", file_path, "--device", device_id })
			if send_err then
				error_count = error_count + 1
				ya.err("[kdeconnect-send] Failed to send file ", file_path, " to ", device_id, ": ", tostring(send_err))
				ya.notify({
					title = "KDE Connect Error",
					content = "Failed to send: " .. file_path .. "\n" .. tostring(send_err),
					level = "error",
					timeout = 5,
				})
			else
				success_count = success_count + 1
			end
		end

		-- 9. Final Notification
		local final_message =
			string.format("Sent %d/%d files to %s.", success_count, #selected_files, target_device_name)
		local final_level = "info"
		if error_count > 0 then
			final_message = string.format(
				"Sent %d/%d files to %s. %d failed.",
				success_count,
				#selected_files,
				target_device_name,
				error_count
			)
			final_level = "warn"
		end
		if success_count == 0 and error_count > 0 then
			final_level = "error"
		end
		ya.dbg("[kdeconnect-send] Send process completed. Success: ", success_count, " Failed: ", error_count)
		ya.notify({ title = "KDE Connect Send Complete", content = final_message, level = final_level, timeout = 5 })
		ya.dbg("[kdeconnect-send] Plugin execution finished.")
	end,
}
