# Load some useful packages
using Pkg

try
	using Revise
catch e
	@warn "Error initialising Revise" exception = (e, catch_backtrace())
end

# If Julia is started in a directory
if isfile("Project.toml") && isfile("Manifest.toml")
    Pkg.activate(".")
end

# Include the current project in the prompt
import OhMyREPL as OMR
promptfn() = "(" * splitpath(Base.active_project())[end-1] * ") julia> "
OMR.input_prompt!(promptfn)

# No syntax highlighting
OMR.enable_pass!("SyntaxHighlighter", false)
OMR.enable_pass!("RainbowBrackets", false)

ENV["JULIA_EDITOR"] = "nvim"

