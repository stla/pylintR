#' <Add Title>
#'
#' <Add Description>
#'
#' @importFrom htmlwidgets createWidget
#' @importFrom utils URLencode
#' @export
pylint <- function(modules, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    message = message
  )

  # create widget
  createWidget(
    name = "pylintR",
    x,
    width = width,
    height = height,
    package = "pylintR",
    elementId = elementId
  )
}

#' @title Shiny bindings for pylintR
#'
#' @description Output and render functions for using 'pylintR' within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height a valid CSS unit (like \code{"100\%"},
#'   \code{"400px"}, \code{"auto"}) or a number, which will be coerced to a
#'   string and have \code{"px"} appended
#' @param expr an expression that generates an output of \code{\link{pylint}}
#' @param env the environment in which to evaluate \code{expr}
#' @param quoted whether \code{expr} is a quoted expression
#'   (with \code{quote()}); this is useful if you want to save an expression
#'   in a variable
#'
#' @importFrom htmlwidgets shinyWidgetOutput
#' @name pylintR-shiny
#'
#' @export
pylintROutput <- function(outputId, width = "100%", height = "400px"){
  shinyWidgetOutput(outputId, "pylintR", width, height, package = "pylintR")
}

#' @rdname pylintR-shiny
#' @importFrom htmlwidgets shinyRenderWidget
#' @export
renderPylintR <- function(expr, env = parent.frame(), quoted = FALSE) {
  if(!quoted){ expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, pylintROutput, env, quoted = TRUE)
}
