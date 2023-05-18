
#make fixed (non-timevarying) samples
#' make_fixed_samples
#'
#'Create data frame of non-timevarying samples from Turing
#' @param gq_samples dataframe of samples from Turing
#'
#' @return
#' @export
#'
#' @examples
make_fixed_samples <- function(gq_samples) {
  fixed_samples <-
    gq_samples %>%
    pivot_longer(-c(iteration, chain)) %>%
    select( name, value) %>%
    dplyr::filter(stringr::str_detect(name, "\\[\\d+\\]", negate = T))

  return(fixed_samples)

}
