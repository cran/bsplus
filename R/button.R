#' Button
#'
#' This function makes it a little easier to make Bootstrap-friendly buttons;
#' it wraps [`htmltools::tags`][`htmltools::builder`] for buttons.
#'
#' @param label character (HTML), button label
#' @param button_type character, one of the standard Bootstrap types
#' @param button_size character, size of the button
#' @param ... attributes (named arguments) and children (unnamed arguments)
#'   of the button, passed to
#'
#' @return Object with S3 class, `shiny.tag`, `<button/>`.
#' @examples
#' bs_button("Click me", button_type = "primary", button_size = "small")
#' @seealso <https://getbootstrap.com/docs/3.3/css/#buttons>
#' @export
#'
bs_button <- function(
  label,
  button_type = c("default", "primary", "success", "info", "warning", "danger"),
  button_size = c("default", "large", "small", "extra-small"),
  ...
){

  button_type <- match.arg(button_type)
  button_size <- match.arg(button_size)

  class_button_size <-
    list(
      default = NULL,
      large = "btn-lg",
      small = "btn-sm",
      `extra-small` = "btn-xs"
    )

  htmltools::tags$button(
    label,
    class =
      paste(
        c(
          "btn",
          paste("btn", button_type, sep = "-"),
          class_button_size[[button_size]]
        ),
        collapse = " "
      ),
    ...
  )

}
