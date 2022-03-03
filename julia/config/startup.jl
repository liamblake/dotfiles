# Load some useful packages
using Pkg

try
	using Revise
catch e
	@warn "Error initialising Revise" exception = (e, catch_backtrace())
end

# If Julia is started in a directory
# TODO: Add a custom flag to overwrite this
if isfile("Project.toml") && isfile("Manifest.toml")
    Pkg.activate(".")
end
