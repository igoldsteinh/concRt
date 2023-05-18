#' fit_eirrc
#'
#'R wrapper for julia function fitting eirrc model to data. Priors default to priors used for scenario 1.
#'
#' @param obs real valued vector of observed RNA concentrations on log scal
#' @param time real valued vector of observation times, corresponds to obs vector
#' @param priors_only boolean if sample from the prior distribution only
#' @param n_samples integer number of desired posterior samples,  model will run 2*n_samples total samples and discard half as burn-in
#' @param n_chains number of chains to run, note you'll need to specify number of threads available separately
#' @param seed set the seed
#' @param gamma_sd real valued sd for gamma prior on log scale
#' @param gamma_mean real valued mean for gamma prior on log scale
#' @param nu_sd real valued sd for nu prior on log scale
#' @param nu_mean real valued mean for nu prior
#' @param eta_sd real valued sd for eta prior on log scale
#' @param eta_mean real valued mean for eta prior on log scale
#' @param rho_gene_sd real valued sd for rho prior on log scale
#' @param rho_gene_mean real valued mean for rho prior on log scale
#' @param tau_sd real valued sd for tau prior on log scale
#' @param tau_mean real valued mean for tau prior on log scale
#' @param I_init_sd real valued sd for initial I
#' @param I_init_mean real valued mean for intial I
#' @param R1_init_sd real valued sd for initial R1
#' @param R1_init_mean real valued mean for initial R1
#' @param E_init_sd real valued sd for initial E
#' @param E_init_mean real valued mean for initial E
#' @param lambda_mean real valued mean for lambda on logit scale
#' @param lambda_sd real valued sd for lambda on logit scale
#' @param df_shape real valued shape for df prior
#' @param df_scale real valued scale for df prior
#' @param sigma_rt_sd real valued sd for sigma rt on log scale
#' @param sigma_rt_mean real valued sd for sigma rt on log scale
#' @param rt_init_sd real valued sd for initial rt on log scale
#' @param rt_init_mean real valued mean for initial rt on log scale
#'
#' @return
#' @export
#'
#' @examples
fit_eirrc <- function(obs,
                      time,
                      priors_only,
                      n_samples,
                      n_chains,
                      seed,
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

  JuliaCall::julia_call("fit_eirrc_closed",
                                  obs,
                                  time,
                                  priors_only,
                                  n_samples,
                                  n_chains,
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
