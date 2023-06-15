
#make fixed (non-timevarying) samples
#' make_fixed_samples
#'
#'Create data frame of non-timevarying samples from Turing
#'Created by Damon Bayer
#'
#' @param gq_samples dataframe of samples from Turing
#'
#' @return a dataframe
#' @export
#'
#' @examples
make_fixed_samples <- function(gq_samples) {
  fixed_samples <-
    gq_samples %>%
    tidyr::pivot_longer(-c(iteration, chain)) %>%
    dplyr::select( name, value) %>%
    dplyr::filter(stringr::str_detect(name, "\\[\\d+\\]", negate = T))

  return(fixed_samples)

}
