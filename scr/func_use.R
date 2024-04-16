if (!require(pacman)) install.packages("pacman")
pacman::p_load(NCmisc, tools, this.path)

func_use <- function(script_file_path) {
  # Determine if the input is a URL
  if (grepl("^http", script_file_path)) {
    # If it's a URL, download the script to a temporary file
    temp_file <- tempfile()
    download.file(script_file_path, destfile = temp_file, mode = "wb")
    script_file_path <- temp_file  # Update script path to the temporary file
  }
  
  # Read and escape the entire script file for Markdown
  script_content <- readLines(script_file_path)
  script_content <- sapply(script_content, function(line) {
    line <- gsub("\\*", "\\*", line)
    line <- gsub("_", "\\_", line)
    line <- gsub("`", "\\`", line)
    return(line)
  })
  
  # Extract and process functions used in the file
  used_functions <- list.functions.in.file(script_file_path)
  all_functions <- unlist(used_functions)
  all_functions <- sapply(all_functions, as.character)
  all_functions <- sort(all_functions)
  functions_to_remove <- c("p_load", "p_unload", "install.packages", "require", "suppressMessages", "rm", "ls")
  all_functions <- all_functions[!all_functions %in% functions_to_remove]
  all_functions <- paste0("`", all_functions, "`")
  function_sentence <- paste("The script uses the following functions: ", paste(all_functions, collapse = ", "), ".", sep="")
  
  # Print the main callout block with nested content
  cat("::: {.callout-tip title=\"Solution\"}\n")
  cat(function_sentence, "\n\n")
  
  # cat("Please find solutions [here](", script_file_path, ").\n", sep="", "\n\n")
  
  # Nested callout block for the script content
  cat("::: {.callout-tip title=\"R script\" appearance=\"minimal\" collapse=\"true\"}\n")
  cat("```r\n", paste(script_content, collapse="\n"), "\n```\n", sep="")
  # cat(":::\n")
  
  cat(":::\n")
  
  cat("::: {.callout-tip title=\"Output of the R script\" appearance=\"minimal\" collapse=\"true\"}\n")
  # Clean up temporary file if one was created
  if (exists("temp_file")) {
    unlink(temp_file)
  }
  
}
  