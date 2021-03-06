rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  readfile <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  readfile[, 11] <- suppressWarnings(as.numeric(readfile[, 11]))
  readfile[, 17] <- suppressWarnings(as.numeric(readfile[, 17]))
  readfile[, 23] <- suppressWarnings(as.numeric(readfile[, 23]))
  
  ## Check that state and outcome are valid
  states <- unique(readfile$State)
  conditions <- c("heart attack", "heart failure", "pneumonia")
  if(!state %in% states){
    stop("invalid state")
  }
  if(!outcome %in% conditions){
    stop("invalid outcome")
  }
  subsetbystate <- readfile[grep(state, readfile$State, ignore.case=T), ]
  if (outcome == "heart attack" ) {
    column <- 11 
  }
  if (outcome == "heart failure" ) { 
    column <- 17 }
  if (outcome == "pneumonia" ) { 
    column <- 23 }
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  sort <- subsetbystate[order(subsetbystate[, column], subsetbystate[, 2]), ]
  sort <- na.omit(sort)
  if (num == "best") {
    num <- 1 
  }
  if (num == "worst") {
    num <- nrow(sort) 
  }
  return(sort[num,2])
  
}
