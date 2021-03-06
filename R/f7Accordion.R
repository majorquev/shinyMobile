#' Create a Framework7 accordion
#'
#' Build a Framework7 accordion
#'
#' @param ... Slot for \link{f7AccordionItem}.
#' @param inputId Optional id to recover the state of the accordion.
#' @param multiCollapse Whether to open multiple items at the same time. FALSE
#' by default.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Accordions",
#'     f7SingleLayout(
#'      navbar = f7Navbar("Accordions"),
#'      f7Accordion(
#'       inputId = "myaccordion1",
#'       f7AccordionItem(
#'        title = "Item 1",
#'        f7Block("Item 1 content"),
#'        open = TRUE
#'       ),
#'       f7AccordionItem(
#'        title = "Item 2",
#'        f7Block("Item 2 content")
#'       )
#'      ),
#'      f7Accordion(
#'       multiCollapse = TRUE,
#'       inputId = "myaccordion2",
#'       f7AccordionItem(
#'        title = "Item 1",
#'        f7Block("Item 1 content")
#'       ),
#'       f7AccordionItem(
#'        title = "Item 2",
#'        f7Block("Item 2 content")
#'       )
#'      )
#'     )
#'   ),
#'   server = function(input, output, session) {
#'    observe({
#'     print(
#'      list(
#'       accordion1 = input$myaccordion1,
#'       accordion2 = input$myaccordion2
#'      )
#'     )
#'    })
#'   }
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Accordion <- function(..., inputId = NULL, multiCollapse = FALSE) {

  accordionTag <- if (multiCollapse) {
    shiny::tags$div(
      class = "list",
      shiny::tags$ul(...)
    )
  } else {
    shiny::tags$div(
      class = "list accordion-list",
      shiny::tags$ul(...)
    )
  }

 accordionTag <- tagAppendAttributes(
   accordionTag,
   id = inputId,
   class = "collapsible"
 )

 shiny::tagList(f7InputsDeps(), accordionTag)

}



#' Create a Framework7 accordion item
#'
#' Build a Framework7 accordion item
#'
#' @param ... Item content such as \link{f7Block} or any f7 element.
#' @param title Item title.
#' @param open Whether the item is open at start. FALSE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7AccordionItem <- function(..., title = NULL, open = FALSE) {

  accordionCl <- "accordion-item"
  if (open) accordionCl <- paste0(accordionCl, " accordion-item-opened")

  # item tag
  shiny::tags$li(
    class = accordionCl,
    shiny::tags$a(
      href = "#",
      class = "item-content item-link",
      shiny::tags$div(
        class = "item-inner",
        shiny::tags$div(class = "item-title", title)
      )
    ),
    shiny::tags$div(
      class = "accordion-item-content",
      ...
    )
  )
}





#' Update a Framework 7 accordion
#'
#' @param inputId Accordion instance.
#' @param selected Index of item to select.
#' @param session Shiny session object
#'
#' @export
#'
#' @importFrom shiny getDefaultReactiveDomain
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "Accordions",
#'      f7SingleLayout(
#'        navbar = f7Navbar("Accordions"),
#'        f7Button(inputId = "go", "Go"),
#'        f7Accordion(
#'          inputId = "myaccordion1",
#'          f7AccordionItem(
#'            title = "Item 1",
#'            f7Block("Item 1 content"),
#'            open = TRUE
#'          ),
#'          f7AccordionItem(
#'            title = "Item 2",
#'            f7Block("Item 2 content")
#'          )
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      observeEvent(input$go, {
#'        updateF7Accordion(inputId = "myaccordion1", selected = 2, session = session)
#'      })
#'
#'      observe({
#'        print(
#'          list(
#'            accordion1_state = input$myaccordion1$state,
#'            accordion1_values = unlist(input$myaccordion1$value)
#'          )
#'        )
#'      })
#'    }
#'  )
#' }
updateF7Accordion <- function(inputId, selected = NULL, session = shiny::getDefaultReactiveDomain()) {
  message <-list(selected = selected)
  session$sendInputMessage(inputId, message)
}
