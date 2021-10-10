boldify <- function(x){
  sprintf("<span style='font-weight: bold; font-style: italic;'>%s</span>", x)
}

redify <- function(x){
  sprintf("<span style='color: firebrick; font-weight: bold;'>%s</span>", x)
}

greenify <- function(x){
  sprintf("<span style='color: forestgreen; font-weight: bold;'>%s</span>", x)
}

linkify <- function(code){
  sprintf(
    "<a href='http://pylint-messages.wikidot.com/messages:%s'>%s</a>",
    tolower(code), code
  )
}

getANSIreport <- function(pyfile){
  suppressWarnings(
    system2("pylint", c("--output-format=colorized", pyfile), stdout = TRUE)
  )
}

#' @importFrom fansi sgr_to_html
#' @importFrom utils head
#' @noRd
getHTMLreport <- function(ANSIreport){
  sgr_to_html(head(ANSIreport, -4L))
}

getSplittedHTMLreport <- function(HTMLreport){
  strsplit(HTMLreport[-1L], ":")
}

doLine <- function(splittedLine){
  splittedLine[1L] <- boldify(splittedLine[1L])
  splittedLine[2L] <- redify(splittedLine[2L])
  splittedLine[3L] <- greenify(splittedLine[3L])
  splittedLine[4L] <-
    paste0("&nbsp;", linkify(trimws(splittedLine[4L], "left")))
  paste0("<p>", paste0(splittedLine, collapse = ":"), "</p>")
}

doReport <- function(splittedHTMLreport, pyfile){
  lines <- vapply(splittedHTMLreport, doLine, character(1L))
  line1 <- paste0(
    "<h3 style='background-color: #FFFF02; text-align: center;'>***** ",
    pyfile, " *****</h3>"
  )
  lines <- c(line1, lines)
  paste0(lines, collapse = "\n")
}

finalHTML <- function(pyfile){
  ANSIreport <- getANSIreport(pyfile)
  HTMLreport <- getHTMLreport(ANSIreport)
  splittedHTMLreport <- getSplittedHTMLreport(HTMLreport)
  doReport(splittedHTMLreport, pyfile)
}

pylintReport <- function(modules){
  if(dir.exists(modules)){
    pyfiles <- list.files(path = modules, pattern = "\\.py$", full.names = TRUE)
    if(length(pyfiles) == 0L){
      return(sprintf(
        "No 'py' file found in folder '%s'.", modules
      ))
    }
  }else{
    pyfiles <- modules
  }
  reports <- vapply(pyfiles, finalHTML, character(1L))
  paste0(reports, collapse = "\n<br/>\n")
}
