
 -- Java run command.
 -- Runs Java program and outputs all print statements to a console
 -- below the the code(attached to nvim). 
vim.api.nvim_create_user_command("JavaRun", function()
    print("java run called")
    local file = vim.fn.expand("%:p") -- full path to current file
    local classpath = "out"
    local pkg_class = "org.example.App"

  -- Compile the Java file
    os.execute("javac -d " .. classpath .. " " .. file)

  -- Run the compiled class
    vim.cmd("belowright split | terminal java -cp " .. classpath .. " " .. pkg_class)
end, {})


