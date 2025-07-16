#' @keywords internal

"_PACKAGE"  # no exported object


# default themes
.rfetch_env <- local({
  env <- new.env(parent = emptyenv())

  # default fields
  fields <- c("user", "host", "os", "RStu_ver", "r_ver", "packages", "theme")

  # theme definitions: label_color, value_color, logo_color
  theme_configs <- list(
    Default  = c("36", "37", "36"),   # cyan, white, cyan
    Mono     = c("37", "37", "37"),   # white, white, white
    Rainbow  = c("35", "33", "91"),   # magenta, yellow, bright red
    Matrix   = c("32", "92", "32"),   # green, bright green, green
    Fire     = c("31", "93", "31"),   # red, bright yellow, red
    Ocean    = c("34", "96", "34"),   # blue, bright cyan, blue
    Sunset   = c("95", "91", "95"),   # bright magenta, bright red, bright magenta
    Forest   = c("32", "37", "32"),   # green, white, green
    Vintage  = c("33", "90", "33"),   # yellow, dark gray, yellow
    Neon     = c("95", "96", "95"),   # bright magenta, bright cyan, bright magenta
    Minimal  = c("90", "37", "90"),   # dark gray, white, dark gray
    Pastel   = c("94", "97", "94")    # bright blue, bright white, bright blue
  )

  # build themes list
  env$themes <- lapply(theme_configs, function(colors) {
    list(
      label  = colors[1],
      value  = colors[2],
      logo   = colors[3],
      fields = fields
    )
  })

  # set default theme
  env$current_theme <- "Default"

  env # <-- return .rfetch_env
})
