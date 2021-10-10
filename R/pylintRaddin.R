#' @importFrom rstudioapi hasFun getSourceEditorContext
#' @keywords internal
pylintFile <- function(){
  if(hasFun("getSourceEditorContext")){
    editorContext <- getSourceEditorContext()
  }else{
    stop("This version of RStudio is too old!")
  }
  if(editorContext[["path"]] != ""){
    currentFolder <- dirname(editorContext[["path"]])
    wd <- setwd(currentFolder)
    on.exit(setwd(wd))
    currentFile <- basename(editorContext[["path"]])
  }else{
    tmpdir <- tempdir()
    untitled <- file.path(tmpdir, "untitled")
    writeLines(editorContext[["contents"]], untitled)
    wd <- setwd(tmpdir)
    on.exit(setwd(wd))
    currentFile <- "untitled"
  }
  pylint(currentFile)
}

#' @keywords internal
pylintFolder <- function(){
  if(hasFun("getSourceEditorContext")){
    editorContext <- getSourceEditorContext()
  }else{
    stop("This version of RStudio is too old!")
  }
  if(editorContext[["path"]] != ""){
    currentFolder <- dirname(editorContext[["path"]])
    wd <- setwd(currentFolder)
    on.exit(setwd(wd))
  }else{
    currentFolder <- getwd()
  }
  pylint(currentFolder)
}
