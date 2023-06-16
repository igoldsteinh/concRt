#' setup
#'
#' Use`JuliaCall` to install julia if needed, and install `testpackage.jl` if needed.
#'
#' @param install_julia if TRUE, install julia using `JuliaCall::install_julia`
#'
#' @return NA
#' @export
#'
#' @examples
setup <- function(install_julia = FALSE) {
  if (install_julia == TRUE) {
    JuliaCall::install_julia()
  }
    JuliaCall::julia_install_package_if_needed("https://github.com/igoldsteinh/testpackage.jl")
}
