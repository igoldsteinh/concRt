#' generate_eirrc
#'
#' Call `generate_pp_and_gq_eirrc` in julia to transform output of `fit_eirrc` to useable dataframes
#'
#' Default priors are for scenario 1, and assume the model is being fit to a daily time scale
#'
#' @param samples output from `fit_eirrc`
#' @param data vector: log RNA concentrations
#' @param obstimes vector: times RNA concentrations are observed
#' @param param_change_times vector: times reproduction number is allowed to change
#' @param seed integer: random seed
#' @param gamma_sd float64: standard deviation for normal prior of log gamma
#' @param gamma_mean float64: mean for normal prior of log gamma
#' @param nu_sd float64: standard deviation for normal prior of log nu
#' @param nu_mean float64: mean for normal prior of log nu
#' @param eta_sd float64: standard deviation for normal prior of log eta
#' @param eta_mean float64: mean for normal prior of log eta
#' @param rho_gene_sd float64: standard devation for normal prior of log rho
#' @param rho_gene_mean float64: mean for normal prior of log rho
#' @param tau_sd float64: standard deviation for normal prior of log tau
#' @param tau_mean float64: mean for normal prior of log tau
#' @param I_init_sd float64: standard deviation for normal prior of I_init
#' @param I_init_mean float64: mean for normal prior of I_init
#' @param R1_init_sd float64: standard deviation for normal prior of R1_init
#' @param R1_init_mean float64: mean for normal prior of R1_init
#' @param E_init_sd float64: standard deviation for normal prior of E_init
#' @param E_init_mean float64: mean for normal prior of E_init
#' @param lambda_mean float64: mean for normal prior of logit lambda
#' @param lambda_sd float64: standard deviation for normal prior of logit lambda
#' @param df_shape float64: shape parameter for gamma prior of df
#' @param df_scale float64: scale parameter for gamma prior of df
#' @param sigma_rt_sd float64: standard deviation for normal prior on log sigma rt
#' @param sigma_rt_mean float64: mean for normal prior on log sigma rt
#' @param rt_init_sd float64: standard deviation for normal prior on log rt_init
#' @param rt_init_mean float64: mean for normal prior on log rt_init
#'
#' @return List of three dataframes, posterior predictive, scaled posterior, and un-scaled posterior
#' @export
#'
#' @examples
generate_eirrc <- function(samples,
                           data,
                           obstimes,
                           param_change_times,
                           seed = 1,
                           gamma_sd = 0.2,
                           gamma_mean =log(1/4),
                           nu_sd = 0.2,
                           nu_mean = log(1/7),
                           eta_sd = 0.2,
                           eta_mean = log(1/18),
                           rho_gene_sd = 1.0,
                           rho_gene_mean = 0.0,
                           tau_sd = 1.0,
                           tau_mean = 0.0,
                           I_init_sd = 0.05,
                           I_init_mean = 489.0,
                           R1_init_sd = 0.05,
                           R1_init_mean = 2075.0,
                           E_init_sd = 0.05,
                           E_init_mean = 225.0,
                           lambda_mean = 5.685528,
                           lambda_sd = 2.178852,
                           df_shape = 2.0,
                           df_scale = 10.0,
                           sigma_rt_sd = 0.2,
                           sigma_rt_mean = log(0.1),
                           rt_init_sd = 0.1,
                           rt_init_mean = log(0.88)) {
  JuliaCall::julia_call("generate_pp_and_gq_eirrc",
             samples,
             data,
             obstimes,
             param_change_times,
             seed,
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

}
