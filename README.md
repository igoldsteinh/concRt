# testpackage

## Required Installation Steps
In order to use this package you will need to first install julia (>=1.8.5).
Instructions for installing julia directly are found [here](https://julialang.org/downloads/).
It is also possible to install julia via the [JuliaCall R Library](https://github.com/Non-Contradiction/JuliaCall#installation).

Once you have installed julia, you must install the julia package tied to this R package. 
To install the package through JuliaCall, you can use this command `julia_install_package_if_needed("https://github.com/igoldsteinh/testpackage.jl")`. 
Alternatively, from julia itself, simply type `]` to activate `pkg`, then type `add https://github.com/igoldsteinh/testpackage.jl`. 

