set.seed(1948)
knitr::opts_template$set(
    tikz_settings = list(
        fig.ext = "svg",
        fig.align = "center",
        engine.opts = list(dvisvgm.opts = "--font-format=woff")
    ),
    tikz_settings_fancy = list(
        fig.ext = "svg",
        fig.align = "center",
        engine.opts = list(
            dvisvgm.opts = "--font-format=woff",
            template = "../assets/code/tikz2pdf.tex"
        )
    )
)
disp <- function(df, obs_per_page = 6, custom_callback = NULL, ...) {
    # If length of df is less than obs_per_page, disable pagination
    dom_str <- "tp"
    if (nrow(df) <= obs_per_page) {
        dom_str <- "t"
    }
    return(DT::datatable(
        df,
        extensions = c("FixedColumns", "FixedHeader"),
        options = list(
            pageLength = obs_per_page,
            scrollX = TRUE,
            paging = TRUE,
            dom = dom_str,
            fixedHeader = TRUE,
            filter = FALSE,
            ordering = FALSE,
            language = list(
                "paginate" = list(
                    "previous" = "<i class='bi bi-chevron-left'></i>",
                    "next" = "<i class='bi bi-chevron-right'></i>"
                )
            ),
            callback = custom_callback
        )
        )
    )
}

#library(knitr)
## define a method for objects of the class data.frame
#knit_print.data.frame <- function(x, ...) {
#    #res <- paste(c("", "", disp(x)), collapse = "\n")
#    asis_output(disp(x))
#}
## register the method
#registerS3method("knit_print", "data.frame", knit_print.data.frame)
