#' generate_seirr
#'
#' Call `generate_pp_and_gq_seirr` in Julia to transform output from `fit_seirr` to useable dataframes
#'
#'Default priors are for scenario 1, and assume the model is being fit to a weekly time scale
#'
#' @param samples output from `fit_seirr`
#' @param data vector: log RNA concentrations
#' @param obstimes vector: times RNA concentrations are observed
#' @param param_change_times vector: times reproduction number is allowed to change
#' @param extra_ode_precision boolean: if TRUE, uses custom ode precisions, otherwise uses DifferentialEquations.jl default values
#' @param priors_only boolean: if true, function produces draws from the joint prior
#' @param n_samples integer: number of posterior samples AFTER burn-in, total will be twice n_samples
#' @param n_chains integer: number of chains
#' @param fit_abs_tol float64: if `extra_ode_precision` TRUE, absolute tolerance for model fitting
#' @param fit_rel_tol float64: if `extra_ode_precision` TRUE, relative tolerance for model fitting
#' @param opt_abs_tol float64: if `extra_ode_precision` TRUE, absolute tolerance for choosing mcmc initial values
#' @param opt_rel_tol float64: if `extra_ode_precision` true, relative tolerance for choosing mcmc initial values
#' @param seed integer: random seed
#' @param popsize integer: population size
#' @param active_pop intger: population size - initial size of R compartment
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
#' @param sigma_R0_sd flaot64: standard deviation for normal prior of log sigma R0
#' @param sigma_R0_mean float64: mean for normal prior of log sigma R0
#' @param S_SEIR1_sd float64: standard deviation for normal prior on logit fraction of `active_pop` initially in S
#' @param S_SEIR1_mean float64: mean for normal prior on logit fraction of `active_pop` initially in S
#' @param I_EIR1_sd float64: standard deviation for normal prior on logit fraction of initial E,I and R1 compartments in the I compartment
#' @param I_EIR1_mean float64: mean for normal prior on logit fraction of initial E,I and R1 compartments in the I compartment
#' @param R1_ER1_sd float64: standard deviation for normal prior on logit fraction of initial E and R1 compartments in the R1 compartment
#' @param R1_ER1_mean float64: mean for normal prior on logit fraction of initial E and R1 compartments in the R1 compartment
#' @param r0_init_sd float64: standard deviation for normal prior of log R0
#' @param r0_init_mean float64: mean for normal prior of log R0
#' @param lambda_mean float64: mean for normal prior of logit lambda
#' @param lambda_sd float64: standard deviation for normal prior of logit lambda
#' @param df_shape float64: shape parameter for gamma prior of df
#' @param df_scale float64: scale parameter for gamma prior of df
#'
#' @return List of three dataframes, posterior predictive, scaled posterior, and un-scaled posterior
#' @export
#'
#' @examples
generate_seirr <- function(samples,
                           data,
                           obstimes,
                           param_change_times,
                           extra_ode_precision,
                           seed = 1,
                           fit_abs_tol = 1e-9,
                           fit_rel_tol = 1e-6,
                           popsize = 100000L,
                           active_pop = 92271L,
                           gamma_sd = 0.2,
                           gamma_mean =log(1/4),
                           nu_sd = 0.2,
                           nu_mean = log(1/7),
                           eta_sd = 0.2,
                           eta_mean = log(1/18),
                           rho_gene_sd =  1.0,
                           rho_gene_mean = 0.0,
                           tau_sd = 1.0,
                           tau_mean = 0.0,
                           sigma_R0_sd = 0.2,
                           sigma_R0_mean = log(0.1),
                           S_SEIR1_sd = 0.05,
                           S_SEIR1_mean = 3.468354,
                           I_EIR1_sd = 0.05,
                           I_EIR1_mean = -1.548302,
                           R1_ER1_sd = 0.05,
                           R1_ER1_mean = 2.221616,
                           r0_init_sd = 0.2,
                           r0_init_mean = log(0.88),
                           lambda_mean = 5.685528,
                           lambda_sd = 2.178852,
                           df_shape = 2.0,
                           df_scale = 10.0) {
  JuliaCall::julia_call("generate_pp_and_gq_seirr",
                        samples,
                        data,
                        obstimes,
                        param_change_times,
                        extra_ode_precision,
                        seed,
                        fit_abs_tol,
                        fit_rel_tol,
                        popsize,
                        active_pop,
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
                        sigma_R0_sd,
                        sigma_R0_mean,
                        S_SEIR1_sd,
                        S_SEIR1_mean,
                        I_EIR1_sd,
                        I_EIR1_mean,
                        R1_ER1_sd,
                        R1_ER1_mean,
                        r0_init_sd,
                        r0_init_mean,
                        lambda_mean,
                        lambda_sd,
                        df_shape,
                        df_scale)

}
