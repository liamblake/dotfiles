# Load some useful packages
using Pkg

# If Julia is started in a directory
# TODO: Add a custom flag to overwrite this
if isfile("Project.toml") && isfile("Manifest.toml")
    Pkg.activate(".")
end
