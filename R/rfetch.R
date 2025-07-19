#' Print a coloured "fetch" banner
#'
#' @param info       Named list as produced by [rfetch_info()]. If `NULL`, the function calls `rfetch_info()` internally.
#' @param logo       Character vector of ASCII lines to prepend.
#' @param theme      Name of a registered theme for this display only (doesn't change default).
#' @param label_col  ANSI colour code for labels for this display only.
#' @param value_col  ANSI colour code for values for this display only.
#' @param fields     Character vector of field names for this display only.
#' @return Invisibly returns the printed character vector.
#'
#' @examples
#' # print the "fetch" banne with current default theme
#' rfetch()
#' 
#' # temporary mono theme
#' rfetch(theme = "Mono")
#' 
#' # temporary red labels
#' rfetch(label_col = "31")
#' 
#' # set mono as default
#' rfetch_theme(name = "Mono")
#' 
#' # now uses mono by default
#' rfetch()
#' 
#' @export


rfetch <- function(info = NULL, logo = NULL, theme = NULL, label_col = NULL, value_col = NULL, logo_col = NULL) {
  
  # get system info
  if (is.null(info)) {
    info <- rfetch_info()
  }

  # get theme
  .rfetch_env <- get(".rfetch_env", envir = asNamespace("rfetch"))

  # get palette
  pal <- get_display_palette(.rfetch_env, theme, label_col, value_col, logo_col)

  # setup palette
  label_color <- paste0("\033[", pal$label, "m")
  value_color <- paste0("\033[", pal$value, "m")
  logo_color <- paste0("\033[", pal$logo, "m")
  reset_color <- "\033[0m"

  lbl <- function(x) paste(label_color, x, reset_color)
  val <- function(x) paste(value_color, x, reset_color)
  logo_fn <- function(x) paste(logo_color, x, reset_color)

  # setup logo
  if (is.null(logo)) {
    # default R logo
    default_logo <- c(
      " :@@@@@@@@@@%%#+-    ",
      ":@@@@@@@@@@@@@@@#   ",
      ":@@@@@=   .+@@@@@+  ",
      ":@@@@@-     @@@@@*  ",
      ":@@@@@=   .+@@@@%.  ",
      ":@@@@@@@@@@@@@#=.   ",
      ":@@@@@@@@@@@@@#-    ",
      ":@@@@@=  .=@@@@@#   ",
      ":@@@@@-    .%@@@@%. ",
      ":@@@@@-     .%@@@@%.",
      ":@@@@@-      .%@@@@#"
    )
    
    #  default logo
    logo_lines <- default_logo
    
    # try to get specific RStudio logo
    rstudio_version <- try(if (exists("RStudio.Version")) RStudio.Version() else stop(), silent = TRUE)
    
    if (!inherits(rstudio_version, "try-error")) {
      logo_file <- paste0("./logo/", rstudio_version$release_name, ".txt")
      if (file.exists(logo_file)) {
        logo_lines <- readLines(logo_file, warn = FALSE)
      }
    }
  } else {
    logo_lines <- logo
  }

  # force every logo line to be exactly 25 characters and apply color
  logo_lines <- substr(logo_lines, 1, 25)
  logo_lines <- format(logo_lines, width = 25, justify = "left")
  logo_lines <- sapply(logo_lines, logo_fn, USE.NAMES = FALSE)

  # setup info fields
  display_fields <- c("user", "host", "os", "RStu_ver", "r_ver", "packages", "theme")

  field_labels <- c(
    user     = " User:",
    host     = "Host:",
    os       = "OS:",
    RStu_ver = "RStudio:",
    r_ver    = "R:",
    packages = "Packages:",
    theme    = "Theme:"
  )

  # build info lines
  info_lines <- character(length(display_fields))

  for (i in seq_along(display_fields)) {
    field <- display_fields[i]
    if (field == "theme") {
      current_theme <- if (is.null(.rfetch_env$current_theme)) "Default" else .rfetch_env$current_theme
      label <- field_labels[field]
      value <- current_theme
      info_lines[i] <- paste0(lbl(label), val(value))
    } else if (field %in% names(info)) {
      label <- field_labels[field]
      value <- info[[field]]
      info_lines[i] <- paste0(lbl(label), val(value))
    } else {
      info_lines[i] <- ""
    }
  }

  # pad to match logo length
  n_logo <- length(logo_lines)
  if (length(info_lines) < n_logo) {
    info_lines <- c(info_lines, rep("", n_logo - length(info_lines)))
    }

  # add color palette display
  theme_names <- c("Default", "Mono", "Rainbow", "Matrix", "Fire", "Ocean", "Sunset", "Forest", "Vintage", "Neon", "Minimal", "Pastel")
  
  line1 <- paste0(
    paste0("\033[", .rfetch_env$themes[["Default"]]$label, "m███\033[0m"),
    paste0("\033[", .rfetch_env$themes[["Mono"]]$label,    "m███\033[0m"),
    paste0("\033[", .rfetch_env$themes[["Rainbow"]]$label, "m███\033[0m"),
    paste0("\033[", .rfetch_env$themes[["Matrix"]]$label,  "m███\033[0m"),
    paste0("\033[", .rfetch_env$themes[["Fire"]]$label,    "m███\033[0m"),
    paste0("\033[", .rfetch_env$themes[["Ocean"]]$label,   "m███\033[0m")
  )

  line2 <- paste0(
    paste0("\033[", .rfetch_env$themes[["Sunset"]]$label,  "m███\033[0m"),
    paste0("\033[", .rfetch_env$themes[["Forest"]]$label,  "m███\033[0m"),
    paste0("\033[", .rfetch_env$themes[["Vintage"]]$label, "m███\033[0m"),
    paste0("\033[", .rfetch_env$themes[["Neon"]]$label,    "m███\033[0m"),
    paste0("\033[", .rfetch_env$themes[["Minimal"]]$label, "m███\033[0m"),
    paste0("\033[", .rfetch_env$themes[["Pastel"]]$label,  "m███\033[0m")
  )
  
  info_lines <- c(info_lines, line1, line2)

  # combine and output
  lines <- paste(logo_lines, info_lines)
  cat(paste0(lines, "\n"))

  invisible(lines)
}

# setup palette function
get_display_palette <- function(.rfetch_env, theme, label_col, value_col, logo_col) {
  
  # use specified theme
  if (!is.null(theme)) {
    if (!theme %in% names(.rfetch_env$themes)) {
      stop("Theme '", theme, "' not found.", call. = FALSE)
    }
    return(.rfetch_env$themes[[theme]])
  }
  
  # get current theme as base
  current_theme <- if (is.null(.rfetch_env$current_theme)) "Default" else .rfetch_env$current_theme
  current_pal <- .rfetch_env$themes[[current_theme]]
  
  # use custom colors if specified
  if (!is.null(label_col) || !is.null(value_col) || !is.null(logo_col)) {
    return(list(
      label = if (is.null(label_col)) current_pal$label else label_col,
      value = if (is.null(value_col)) current_pal$value else value_col,
      logo  = if (is.null(logo_col))  current_pal$logo  else logo_col
    ))
  }
  
  # return current theme
  return(current_pal)
}


