#' @importFrom rstudioapi hasFun getSourceEditorContext
#' @keywords internal
pylintFile <- function(){
  if(hasFun("getSourceEditorContext")){
    editorContext <- getSourceEditorContext()
  }else{
    stop("This version of RStudio is too old!")
  }
  contents <- paste0(editorContext[["contents"]], collapse = "\n")

}

#' @keywords internal
pylintFolder <- function(){

}
