#' Register or retrieve rfetch colour themes
#'
#' @param name        Theme name to set as default. Built‑in: "default", "mono", etc.
#' @param label_col   ANSI colour code for labels (e.g. "36" for cyan) to set as default.
#' @param value_col   ANSI colour code for values to set as default.
#' @param logo_col    ANSI colour code for logo to set as default.
#' @param fields      Character vector of field names to set as default.
#' @param return_pal  Internal flag: if `TRUE`, returns the palette used by [rfetch()].
#' @return Invisibly returns a list of registered themes, or (when
#'         `return_pal = TRUE`) a palette list.
#' @export
#' @examples
#' # set Matrix theme as default
#' rfetch_theme(name = "Matrix")
#' 
#' # create custom theme with labels in red, values in white and logo in green 
#' rfetch_theme(label_col = "31", value_col = "37", logo_col = "32")


rfetch_theme <- function(name = NULL, label_col = NULL, value_col = NULL, logo_col = NULL, fields = NULL, return_pal = FALSE) {

  # get themes
  .rfetch_env <- get(".rfetch_env", envir = asNamespace("rfetch"))

  if (is.null(name) && is.null(label_col) && is.null(value_col) && is.null(logo_col) && is.null(fields)) {
    return(invisible(.rfetch_env$themes))
  }

  # return current palette
  if (return_pal) {
    current_theme <- if (is.null(.rfetch_env$current_theme)) "Default" else .rfetch_env$current_theme
    pal <- .rfetch_env$themes[[current_theme]]

    if (is.null(pal)) {
      stop("Default theme '", current_theme, "' not found.", call. = FALSE)
    }

    return(list(
      label  = paste0("\033[", pal$label, "m"),
      value  = paste0("\033[", pal$value, "m"),
      logo   = paste0("\033[", pal$logo,  "m"),
      reset  = "\033[0m",
      fields = pal$fields
    ))
  }

  # set theme by name
  if (!is.null(name)) {
    if (!name %in% names(.rfetch_env$themes)) {
      available <- paste(names(.rfetch_env$themes), collapse = ", ")
      stop("Theme '", name, "' not found. Available: ", available, call. = FALSE)
    }

    .rfetch_env$current_theme <- name
    cat("Default theme set to:", name, "\n")
  }

  # set custom colors
  if (!is.null(label_col) || !is.null(value_col) || !is.null(logo_col)) {
    current_theme <- if (is.null(.rfetch_env$current_theme)) "Default" else .rfetch_env$current_theme
    current_pal   <- .rfetch_env$themes[[current_theme]]

    .rfetch_env$themes[["Custom"]] <- list(
      label  = if (is.null(label_col)) current_pal$label else label_col,
      value  = if (is.null(value_col)) current_pal$value else value_col,
      logo   = if (is.null(logo_col))  current_pal$logo  else logo_col,
      fields = current_pal$fields
    )

    .rfetch_env$current_theme <- "Custom"
    cat("Default theme set to: Custom\n")
  }

  invisible(.rfetch_env$themes)
}
