# concRt
This package allows users to generate posterior estimates of the effective reproduction number from RNA concentrations and case counts. 
It is an R wrapper for the Julia package [concRt.jl](https://github.com/igoldsteinh/concRt.jl) and allows the user to fit the four models described in ``Semiparametric Inference of Effective Reproduction Number
Dynamics from Wastewater Pathogen RNA Concentrations" by calling the Julia functions within R. 

## Required Installation Steps
To install this package from github, use the following code:
```
# install.packages("remotes")
remotes::install_github("https://github.com/igoldsteinh/concRt")
```
In order to use this package you will need to first install Julia (>=1.8.5) and download the associated [Julia package]("https://github.com/igoldsteinh/concRt.jl").
You can do both using the `setup` function provided in this package with the commands
```
library(concRt)
setup(install_julia = TRUE)
```
If you already have julia installed, you can install just the julia package from R using `JuliaCall`
```
JuliaCall::julia_install_package_if_needed("https://github.com/igoldsteinh/concRt.jl")
```
Alternatively, you can install Julia [directly](https://julialang.org/downloads/).
To install the package from Julia itself type `]` to activate `pkg`, then use the command 
```
add https://github.com/igoldsteinh/concRt.jl
```

## Example usage
```
library(concRt)
library(JuliaCall)

# When starting an R session, you must start by calling julia_setup
julia <- julia_setup(JULIA_HOME = "/Users/isaacgoldstein/.juliaup/bin")
# load required julia package 
julia_library("concRt")

# create time series of concentrations
long_dat <- scenario1_genecount_data %>% 
            dplyr::filter(seed == 1) %>% 
            dplyr::select(new_time, log_gene_copies1, log_gene_copies2, log_gene_copies3) %>%             
            tidyr::pivot_longer(-new_time)

data <- long_dat$value

# provide corresponding observation times
obstimes <- long_dat$new_time

# provide times when Rt changes
param_change_times <- c(7.0, 14.0, 21.0, 28.0, 35.0, 42.0, 49.0, 
                        56.0, 63.0, 70.0, 77.0, 84.0, 91.0, 98.0, 
                        105.0, 112.0, 119.0, 126.0)
# choose to sample from prior or posterior
priors_only <- FALSE

# choose number of samples, number of chains, and seed
n_samples <- 25L
n_chains <- 4L
seed <- 1L

posterior_samples_eirr <- fit_eirrc(data, 
                               obstimes, 
                               param_change_times, 
                               priors_only, 
                               n_samples, 
                               n_chains, 
                               seed)
```
## Notes on errors
Julia is much more strict about object types than R, a common error when using these functions is that an input value is of the wrong type (for instance float64 when it should be an integer). If you get an error that looks like:
```
Error: Error happens in Julia.
MethodError: no method matching fit_eirrc_closed(::Vector{Float64}, ::Vector{Float64}, ::Vector{Float64}, ::Bool, ::Float64, ::Int64, ::Int64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64)
```
it probably means the types of your inputs are incorrect. Check the function documentation to make sure the inputs are the correct types. 

