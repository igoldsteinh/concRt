#' make_timevarying_quantiles
#'
#'Make dataframe of 50,80 and 95 percent quantiles of time-varying parameters from Turing model.
#'The point estimate is the median.
#' @param gq_samples
#'
#' @return
#' @export
#'
#' @examples
make_timevarying_quantiles <- function(gq_samples) {
  timevarying_quantiles <-
    gq_samples %>%
    pivot_longer(-c(iteration, chain)) %>%
    select( name, value) %>%
    dplyr::filter(str_detect(name, "\\[\\d+\\]")) %>%
    dplyr::mutate(time = name %>%
             stringr::str_extract("(?<=\\[)\\d+(?=\\])") %>%
             as.numeric(),
           name = name %>%
             stringr::str_extract("^.+(?=\\[)") %>%
             stringr::str_remove("data_")) %>%
    dplyr::group_by(name, time) %>%
    tidybayes::median_qi(.width = c(0.5, 0.8, 0.95)) %>%
    dplyr::left_join(.,tibble(time = 0:max(.$time)))

  return(timevarying_quantiles)

}
