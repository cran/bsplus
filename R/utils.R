.dummy <- function(x) {
  # suppress CRAN note
  methods::as
}

.id <- function(x){
  paste0("#", x)
}

.class <- function(x){
  paste0(".", x)
}

# @param tag htmltools tag
# @param name character, the name of the tag must be in this vector
# @param class an attribute
# @param ... other names args checked as attributes
#
.tag_validate <- function(tag, name = NULL, class = NULL, ...){

  list_attrib <- list(...)

  # ensure we have a shiny tag
  if (!inherits(tag, "shiny.tag")){
    stop("tag is not a shiny.tag - tag must be generated using htmltools or shiny")
  }

  # if a name argument is provided
  if (!is.null(name)){
    # ensure that the name of the tag is among the provided name(s)
    if (!(tag$name) %in% name){
      stop("tag needs to be one of: ", paste(name, collapse = ", "))
    }
  }

  # if class is provided
  if (!is.null(class)){
    class_split <- split_class(class)
    class_observed_split <-
      split_class(htmltools::tagGetAttribute(tag, "class"))
    if (!all(class_split %in% class_observed_split)){
      stop("class is: ", class_observed_split, ", needs to include: ", class_split)
    }
  }

  # for each additional attribute
  fn_validate <- function(name, value, tag){
    value_observed <- htmltools::tagGetAttribute(tag, name)
    if (!identical(value_observed, value)){
      stop("attribute ", name, " is: ", value_observed, ", needs to be: ", value)
    }
  }

  if (length(list_attrib) > 0){
    purrr::walk2(names(list_attrib), list_attrib, fn_validate, tag)
  }

  # make it pipeable (just in case)
  tag
}


# we will be able to get rid of this code
split_class <- function(x) {

  x <- stringr::str_trim(x)
  x <- stringr::str_split(x, " ")

  x[[1]]
}


