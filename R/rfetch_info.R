#' Collect system information for rfetch
#'
#' @return A named list with system information (user, host, OS, etc.).
#' @examples
#' # Get system information
#' info <- rfetch_info()
#' str(info)
#' @export
rfetch_info <- function() {
  # get RStudio version
  if (exists("RStudio.Version")) {
    rstudio_version <- try(RStudio.Version(), silent = TRUE)
    if (!inherits(rstudio_version, "try-error")) {
      rstu_ver <- paste(rstudio_version$release_name, rstudio_version$version)
    } else {
      rstu_ver <- "Not in RStudio"
    }
  } else {
    rstu_ver <- "Not in RStudio"
  }
  
  list(
    user     = Sys.info()[["user"]],
    host     = Sys.info()[["nodename"]],
    os       = paste(Sys.info()[c("sysname", "release")], collapse = " "),
    RStu_ver = rstu_ver,
    r_ver    = paste(R.version$major, R.version$minor, sep = "."),
    packages = length(utils::installed.packages()[,1])
  )
}
