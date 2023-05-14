library(JuliaCall)
# load specify where julia is installed
julia <- julia_setup(JULIA_HOME = "/Users/isaacgoldstein/.juliaup/bin")

# if this is your first time, you need to activate the package environment
# and then install packages
# so that the versions of all packages downloaded are the same as those
# in the paper
# if this is not your first time or
# if you just want to install the package with the latest versions of all packages
# skip this step
julia_command('Pkg.activate(".")')
julia_command('Pkg.instantiate')
julia_library("Optim")
julia_source("src/distribution_functions.jl")

julia_source("src/closed_soln_eirr_withincid.jl")
julia_exists("power")
julia_source("src/wastewater2.jl")
julia_eval('using Pkg; Pkg.add("StatsBase")')
