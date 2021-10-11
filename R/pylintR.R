#' @title Run 'pylint' on a file or a folder
#'
#' @description Run 'pylint' on a file or a folder.
#'
#' @param modules one or more Python files, or a folder containing Python files
#' @return A \code{htmlwidget} object.
#'
#' @importFrom htmlwidgets createWidget
#' @importFrom utils URLencode
#' @export
#'
#' @examples
#' \dontrun{
#' sample_code_file <- system.file("sample_code.py", package = "pylintR")
#' code_lines <- readLines(sample_code_file)
#' nlines <- length(code_lines)
#' # Here is the code:
#' cat(paste0(format(seq_len(nlines), width = 2), ") ", code_lines), sep = "\n")
#' # let's copy this Python file in a temporary folder
#' file_copy <- tempfile(fileext = ".py")
#' file.copy(sample_code_file, file_copy)
#' wd <- setwd(tempdir())
#' # let's lint it with pylint:
#' pylint(basename(file_copy))
#' # restore current directory
#' setwd(wd)
#' }
pylint <- function(modules){

  find_pylint <- Sys.which("pylint") != ""
  if(!find_pylint){
    stop(
      "This package requires 'pylint'. ",
      "Either it is not installed or it is not found."
    )
  }

  HTMLreport <- pylintReport(modules)

  # forward options using x
  x = list(
    html = URLencode(HTMLreport)
  )

  # create widget
  createWidget(
    name = "pylintR",
    x,
    width = NULL,
    height = NULL,
    package = "pylintR",
    elementId = NULL
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
#' @return \code{pylintROutput} returns an output element that can be included
#'   in a Shiny UI definition, and \code{renderPylintR} returns a
#'   \code{shiny.render.function} object that can be included in a Shiny
#'   server definition.
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
renderPylintR <- function(expr, env = parent.frame(), quoted = FALSE){
  if(!quoted){ expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, pylintROutput, env, quoted = TRUE)
}
