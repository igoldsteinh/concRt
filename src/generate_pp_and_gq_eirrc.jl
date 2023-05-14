using DrWatson
using Revise
using JLD2
using FileIO
using CSV
using DataFrames
using Turing
using DifferentialEquations
using LogExpFunctions
using Random
using ForwardDiff
using Optim
using Random
using LineSearches
using wastewater2
using PreallocationTools
## Define closed form solution
include(projectdir("src/closed_soln_eirr_withincid.jl"))
## Load Model
include(projectdir("src/bayes_eirrc_closed.jl"))
## Load extra distributions
include(projectdir("src/distribution_functions.jl"))
## Load extra distributions
include(projectdir("src/helper_functions.jl"))


Logging.disable_logging(Logging.Warn)
function generate_pp_and_gq_eirrc(samples, 
  data, 
  obstimes,
  gamma_sd::Float64 = 0.2,
  gamma_mean::Float64 =log(1/4),
  nu_sd::Float64 = 0.2,
  nu_mean::Float64 = log(1/7),
  eta_sd::Float64 = 0.2,
  eta_mean::Float64 = log(1/18),
  rho_gene_sd::Float64= 1.0,
  rho_gene_mean::Float64 = 0.0,
  tau_sd::Float64 = 1.0,
  tau_mean::Float64 = 0.0,
  I_init_sd::Float64 = 0.05,
  I_init_mean::Float64 = 489.0,
  R1_init_sd::Float64 = 0.05,
  R1_init_mean::Float64 = 2075.0,
  E_init_sd::Float64 = 0.05,
  E_init_mean::Float64 = 225.0,
  lambda_mean::Float64 = 5.685528,
  lambda_sd::Float64 = 2.178852,
  df_shape::Float64 = 2.0,
  df_scale::Float64 = 10.0,
  sigma_rt_sd::Float64 = 0.2,
  sigma_rt_mean::Float64 = log(0.1),
  rt_init_sd::Float64 = 0.1,
  rt_init_mean::Float64 = log(0.88))
  obstimes = convert(Vector{Float64}, obstimes)
    # trying to avoid the stupid situation where we're telling to change at the end of the solver which doesn't make sense
  if maximum(obstimes) % 7 == 0
    param_change_max = maximum(obstimes) - 7
  else 
    param_change_max = maximum(obstimes)
  end 
  param_change_times = collect(7:7.0:param_change_max)
  outs_tmp = dualcache(zeros(6,length(1:obstimes[end])), 10)


  my_model = bayes_eirrc_closed!(
                                 outs_tmp, 
                                 data,
                                 obstimes, 
                                 param_change_times,
                                 gamma_sd,
                                 gamma_mean,
                                 nu_sd,
                                 nu_mean,
                                 eta_sd,
                                 eta_mean,
                                 rho_gene_sd,
                                 rho_gene_mean,
                                 tau_sd,
                                 tau_mean,
                                 I_init_sd,
                                 I_init_mean,
                                 R1_init_sd,
                                 R1_init_mean,
                                 E_init_sd,
                                 E_init_mean,
                                 lambda_mean,
                                 lambda_sd,
                                 df_shape,
                                 df_scale,
                                 sigma_rt_sd,
                                 sigma_rt_mean,
                                 rt_init_sd,
                                 rt_init_mean)


  
  missing_data = repeat([missing], length(data_log_copies))
  
  my_model_forecast_missing = bayes_eirrc_closed!(
                                 outs_tmp, 
                                 missing_data,
                                 obstimes,
                                 param_change_times,
                                 gamma_sd,
                                 gamma_mean,
                                 nu_sd,
                                 nu_mean,
                                 eta_sd,
                                 eta_mean,
                                 rho_gene_sd,
                                 rho_gene_mean,
                                 tau_sd,
                                 tau_mean,
                                 I_init_sd,
                                 I_init_mean,
                                 R1_init_sd,
                                 R1_init_mean,
                                 E_init_sd,
                                 E_init_mean,
                                 lambda_mean,
                                 lambda_sd,
                                 df_shape,
                                 df_scale,
                                 sigma_rt_sd,
                                 sigma_rt_mean,
                                 rt_init_sd,
                                 rt_init_mean)
  
  # remove samples which are NAs                               
  indices_to_keep = .!isnothing.(generated_quantities(my_model, samples));
    
  samples_randn = ChainsCustomIndex(prior_samples, indices_to_keep);


  Random.seed!(seed)
  predictive_randn = predict(my_model_forecast_missing, samples_randn)
  
  Random.seed!(seed)
  gq_randn = get_gq_chains(my_model, samples_randn);
  
  
  samples_df = DataFrame(samples)
  
  results = [predictive_randn, gq_randn, samples_df]
  return(results)
end 