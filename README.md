# concRt
This package allows users to generate posterior estimates of the effective reproduction number from RNA concentrations and case counts. 
It is an `R` wrapper for the `Julia` package [concRt.jl](https://github.com/igoldsteinh/concRt.jl) and allows the user to fit the four models described in ``Semiparametric Inference of Effective Reproduction Number
Dynamics from Wastewater Pathogen RNA Concentrations" by calling the `Julia` functions within `R`. 

## Required Installation Steps
To install this package from github, use the following code:
```
# install.packages("remotes")
remotes::install_github("https://github.com/igoldsteinh/concRt")
```
In order to use this package you will need to first install `Julia` (>=1.8.5) and download the associated [Julia package]("https://github.com/igoldsteinh/concRt.jl").
To install `Julia`, download the stable release for your operating system [here](https://julialang.org/downloads/).
To install the `Julia` package, use the following commands inside the `Julia` console
```
import Pkg
Pkg.add(url="https://github.com/igoldsteinh/concRt.jl")
```

## Example usage
```
library(concRt)
library(JuliaCall)
library(ggplot2)
library(tidyr)
library(tibble)
library(dplyr)
library(cowplot)
library(scales)
library(latex2exp)
library(tidybayes)
library(stringr)

# When starting an R session, you must start by calling julia_setup
julia <- julia_setup()
# If this results in an error, you need to provide the explicit path to your julia installation
# for instance: julia <- julia_setup(JULIA_HOME = "/Users/isaacgoldstein/.juliaup/bin")

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
# create dataframes of posterior/posterior predictive draws
posterior_output_eirr <- generate_eirrc(posterior_samples_eirr,
                                        data,
                                        obstimes, 
                                        param_change_times,
                                        seed = seed)

# create quantiles of time-varying parameters
eirr_quantiles <- make_timevarying_quantiles(posterior_output_eirr[[2]])

eirr_rt_quantiles <- eirr_quantiles %>% dplyr::filter(name == "rt_t_values")

max_time <- max(scenario1_genecount_data$time)

# assign inferred weekly Rt to each day of the week
# data was simulated on a daily basis, so daily true Rt values are available
eirr_plot_quantiles <- eirr_rt_quantiles %>%
  mutate(time = time - 1) %>%
  rename("week" = time) %>%
  right_join(scenario1_fullsimdata, by = "week") %>%
  dplyr::select(week,time, new_time, true_rt, value, .lower, .upper, .width,.point, .interval) %>%
  filter(time <= max_time,
         week >= 0)

# theme by Damon Bayer
my_theme <- list(
  scale_fill_brewer(name = "Credible Interval Width",
                    labels = ~percent(as.numeric(.))),
  guides(fill = guide_legend(reverse = TRUE)),
  theme_minimal_grid(),
  theme())

# red dots are true values
# blue bars are credible intervals
# black lines are medians
eirr_scenario1_rt_plot <- eirr_plot_quantiles %>%
  ggplot(aes(time, value, ymin = .lower, ymax = .upper)) +
  geom_lineribbon() +
  geom_point(aes(time, true_rt), color = "coral1") + 
  scale_y_continuous("Rt", label = comma) +
  scale_x_continuous(name = "Time") +
  ylim(c(0,3.5)) +
  ggtitle(stringr::str_c("EIRR (WW)")) +
  my_theme + 
  theme(legend.position = c(0.6, 0.8),
        legend.background = element_rect(fill = "transparent"),
        text = element_text(size = 18)) +
  ylab(TeX('$R_{t}$')) 

eirr_scenario1_rt_plot

```
## Notes on errors
Julia is much more strict about object types than R, a common error when using these functions is that an input value is of the wrong type (for instance float64 when it should be an integer). If you get an error that looks like:
```
Error: Error happens in Julia.
MethodError: no method matching fit_eirrc_closed(::Vector{Float64}, ::Vector{Float64}, ::Vector{Float64}, ::Bool, ::Float64, ::Int64, ::Int64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64, ::Float64)
```
it probably means the types of your inputs are incorrect. Check the function documentation to make sure the inputs are the correct types. 

