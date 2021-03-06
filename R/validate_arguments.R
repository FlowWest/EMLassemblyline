#' Validate arguments of EMLassemblyline functions
#'
#' @description
#'     Validate input arguments to `EMLassemblyline` functions.
#'
#' @usage
#'     validate_arguments(
#'       fun.name, 
#'       fun.args
#'     )
#'
#' @param fun.name
#'     (character) Function name passed to `validate_x` with 
#'     `as.character(match.call()[[1]])`.
#' @param fun.args
#'     (named list) Function arguments and values passed to `validate_x` with 
#'     `as.list(environment())`.
#'     
#' @details
#'     Validation checks are function specific.    
#'

validate_arguments <- function(fun.name, fun.args){
  
  # Parameterize --------------------------------------------------------------
  
  use_i <- sapply(fun.args, function(X) identical(X, quote(expr=)))
  fun.args[use_i] <- list(NULL)
  
  # Call from define_catvars() ------------------------------------------------
  
  if (fun.name == 'define_catvars'){
    
    # If not using x ...
    
    if (is.null(fun.args$x)){
      
      # Get attribute file names and data file names
      
      files <- list.files(fun.args$path)
      use_i <- stringr::str_detect(string = files,
                                   pattern = "^attributes")
      if (sum(use_i) == 0){
        stop('There are no attributes.txt files in your dataset working directory. Please fix this.')
      }
      
      attribute_files <- files[use_i]
      table_names_base <- stringr::str_sub(string = attribute_files,
                                           start = 12,
                                           end = nchar(attribute_files)-4)
      data_files <- list.files(fun.args$data.path)
      use_i <- stringr::str_detect(string = data_files,
                                   pattern = stringr::str_c("^", table_names_base, collapse = "|"))
      table_names <- data_files[use_i]
      data_files <- table_names
      
      # Send warning if data table name is repeated more than once
      
      if (length(unique(tools::file_path_sans_ext(data_files))) != length(data_files)){
        stop('Duplicate data file names exist in this directory. Please remove duplicates, even if they are a different file type.')
      }
    
    # If using x ...
      
    } else if (!is.null(fun.args$x)){
      
      # Get attribute file names and data file names
      
      files <- names(fun.args$x$template)
      use_i <- stringr::str_detect(string = files,
                                   pattern = "^attributes")
      if (sum(use_i) == 0){
        stop('There are no attributes.txt files in your dataset working directory. Please fix this.')
      }
      
      attribute_files <- files[use_i]
      
      table_names_base <- stringr::str_sub(string = attribute_files,
                                           start = 12,
                                           end = nchar(attribute_files)-4)
      
      data_files <- names(fun.args$x$data.table)
      
      use_i <- stringr::str_detect(string = data_files,
                                   pattern = stringr::str_c("^", table_names_base, collapse = "|"))
      
      table_names <- data_files[use_i]
      data_files <- table_names
      
      # Send warning if data table name is repeated more than once
      
      if (length(unique(tools::file_path_sans_ext(data_files))) != length(data_files)){
        stop('Duplicate data file names exist in this directory. Please remove duplicates, even if they are a different file type.')
      }
      
    }

  }
  
  # Call from extract_geocoverage() -------------------------------------------
  
  if (fun.name == 'extract_geocoverage'){
    
    # Handle deprecated arguments
    
    if (!is.null(fun.args$data.file)){
      fun.args$data.table <- fun.args$data.file
    }

    # data.table
    
    if (is.null(fun.args$data.table)){
      stop('Input argument "data.table" is missing! Specify the data file containing the geographic coordinates.')
    }
    
    # lat.col
    
    if (is.null(fun.args$lat.col)){
      stop('Input argument "lat.col" is missing! Specify latitude column name.')
    }
    
    # lon.col
    
    if (is.null(fun.args$lon.col)){
      stop('Input argument "lon.col" is missing! Specify longitude column name.')
    }
    
    # site.col
    
    if (is.null(fun.args$site.col)){
      stop('Input argument "site.col" is missing! Specify site column name.')
    }

  }
  
  # Call from import_templates() ----------------------------------------------
  
  if (fun.name == 'import_templates'){
    
    # Handle deprecated arguments
    
    if (!is.null(fun.args$data.files)){
      fun.args$data.table <- fun.args$data.files
    }

    # license
    
    if (is.null(fun.args$license)){
      stop('Input argument "license" is missing')
    }
    
    license.low <- tolower(fun.args$license)
    
    if (!stringr::str_detect(license.low, "^cc0$|^ccby$")){
      stop('Invalid value entered for the "license" argument. Please choose "CC0" or "CCBY".')
    }
    
    # data.table
    
    if (!is.null(fun.args$data.table)){
      
      # Validate table names
      
      data_files <- suppressWarnings(
        EDIutils::validate_file_names(
          path = fun.args$data.path, 
          data.files = fun.args$data.table
        )
      )

    }
    
  }
  
  # Call from make_eml() ------------------------------------------------------
  
  if (fun.name == 'make_eml'){
    
    # Handle deprecated arguments
    
    if (!is.null(fun.args$affiliation)){
      fun.args$user.domain <- fun.args$affiliation
    }
    
    if (!is.null(fun.args$data.files)){
      fun.args$data.table <- fun.args$data.files
    }
    
    if (!is.null(fun.args$data.files.description)){
      fun.args$data.table.description <- fun.args$data.files.description
    }
    
    if (!is.null(fun.args$data.files.quote.character)){
      fun.args$data.table.quote.character <- fun.args$data.files.quote.character
    }
    
    if (!is.null(fun.args$data.files.url)){
      fun.args$data.url <- fun.args$data.files.url
    }
    
    if (!is.null(fun.args$zip.dir)){
      fun.args$other.entity <- fun.args$zip.dir
    }
    
    if (!is.null(fun.args$zip.dir.description)){
      fun.args$other.entity.description <- fun.args$zip.dir.description
    }
    
    # dataset.title
    
    if (is.null(fun.args$dataset.title)){
      stop('Input argument "dataset.title" is missing.', call. = F)
    }

    # data.table.description
    
    if (!is.null(fun.args$data.table)){
      if (is.null(fun.args$data.table.description)){
        stop('Input argument "data.table.description" is missing.', call. = F)
      }
    }

    # temporal.coverage
    
    if (is.null(fun.args$temporal.coverage)){
      stop('Input argument "temporal.coverage" is missing.', call. = F)
    }
    
    if (length(fun.args$temporal.coverage) != 2){
      stop('The argument "temporal.coverage" requires both a begin date and end date. Please fix this.', call. = F)
    }
    
    # geographic.coordinates and geographic.description
    
    if (!is.null(fun.args$geographic.coordinates) & is.null(fun.args$geographic.description)){
      stop('Input argument "geographic.description" is missing.', call. = F)
    }
    
    if (is.null(fun.args$geographic.coordinates) & !is.null(fun.args$geographic.description)){
      stop('Input argument "geographic.coordinates" is missing.', call. = F)
    }

    # maintenance.description
    
    if (is.null(fun.args$maintenance.description)){
      stop('Input argument "maintenance.description" is missing. Indicate whether data collection is "ongoing" or "completed" for your dataset.', call. = F)
    }

    # user.id and user.domain
    
    if (!is.null(fun.args$user.id) & is.null(fun.args$user.domain)){
      stop('Input argument "user.domain" is missing. Add one.', call. = F)
    }
    
    if (!is.null(fun.args$user.domain) & is.null(fun.args$user.id)){
      stop('Input argument "user.id" is missing. Add one.', call. = F)
    }
    
    if ((!is.null(fun.args$user.id)) & (!is.null(fun.args$user.domain))){
      if (length(fun.args$user.id) != length(fun.args$user.domain)){
        stop('The number of values listed in arguments "user.id" and "user.domain" do not match. Each user.id must have a corresponding user.domain', call. = F)
      }
      if (sum(sum(fun.args$user.domain == 'LTER'), sum(fun.args$user.domain == 'EDI')) != length(fun.args$user.domain)){
        warning('Input argument "user.domain" is not "EDI" or "LTER". If not creating a data package for EDI, then ignore this message. A default value "someuserdomain" will be used.', call. = F)
      }
    }
    
    # path, data.path, and eml.path
    
    if (is.null(fun.args$x)){
      EDIutils::validate_path(fun.args$path)
    }

    EDIutils::validate_path(fun.args$data.path)  
    
    if (isTRUE(fun.args$write.file)){
      EDIutils::validate_path(fun.args$eml.path)
    }
    
    # data.table
    
    if (!is.null(fun.args$data.table)){
      
      table_names <- suppressWarnings(
        EDIutils::validate_file_names(
          path = fun.args$data.path, 
          data.files = fun.args$data.table
        )
      )

    }
    
    # data.table.name
    
    if (!is.null(fun.args$data.table.name)) {
      if (all(fun.args$data.table %in% fun.args$data.table.name)) {
        warning(
          paste0(
            "Defaulting argument 'data.table.name' to 'data.table'. Consider ",
            "providing a brief descriptive name for your file(s)."
          ),
          call. = FALSE
        )
      }
    }
    
    # data.table.description
    
    if (!is.null(fun.args$data.table)){
      if (length(fun.args$data.table.description) != length(fun.args$data.table)){
        stop('The number of descriptions listed in the argument "data.table.description" does not match the number of files listed in the argument "data.table". These must match.', call. = F)
      }
    }
    
    # data.table.quote.character
    
    if (!is.null(fun.args$data.table)){
      if (!is.null(fun.args$data.table.quote.character)){
        if (length(fun.args$data.table.quote.character) != length(fun.args$data.table)){
          stop('The number of quote characters listed in the argument "data.table.quote.character" does not match the number of files listed in the argument "data.table". These must match.', call. = F)
        }
      }
    }
    
    # data.table.url
    
    if (!is.null(fun.args$data.table.url)) {
      if (length(fun.args$data.table.url) != length(fun.args$data.table)) {
        stop('The number of URLs listed in the argument "data.table.url" does not match the number of files listed in the argument "data.table". These must match.', call. = F)
      }
    }
    
    # other.entity and other.entity.description
    
    if ((!is.null(fun.args$other.entity)) & (is.null(fun.args$other.entity.description))){
      stop('The argument "other.entity.description" is missing and "other.entity" is present. Add a description for your zip directory.', call. = F)
    }
    
    if ((!is.null(fun.args$other.entity.description)) & (is.null(fun.args$other.entity))){
      stop('The argument "other.entity" is missing and "other.entity.description" is present. Add the zip directories you are describing.', call. = F)
    }
    
    if ((!is.null(fun.args$other.entity.description)) & (!is.null(fun.args$other.entity))){
      if ((length(fun.args$other.entity)) != (length(fun.args$other.entity.description))){
        stop('The number of other.entity and other.entity.descriptions must match.', call. = F)
      }
    }
    
    # other.entity.name
    
    if (!is.null(fun.args$other.entity.name)) {
      if (all(fun.args$other.entity %in% fun.args$other.entity.name)) {
        warning(
          paste0(
            "Defaulting argument 'other.entity.name' to 'other.entity'. Consider ",
            "providing a brief descriptive name for your file(s)."
          ),
          call. = FALSE
        )
      }
    }
    
    # other.entity.url
    
    if (!is.null(fun.args$other.entity.url)) {
      if (length(fun.args$other.entity.url) != length(fun.args$other.entity)) {
        stop('The number of URLs listed in the argument "other.entity.url" does not match the number of files listed in the argument "other.entity". These must match.', call. = F)
      }
    }
    
    # package.id
    
    if (!is.null(fun.args$package.id)){
      if (!isTRUE(stringr::str_detect(fun.args$package.id, '[:alpha:]\\.[:digit:]+\\.[:digit:]'))){
        warning('Input argument "package.id" is not valid for EDI. An EDI package ID must consist of a scope, identifier, and revision (e.g. "edi.100.4"). If not creating a data package for EDI, then ignore this message.', call. = F)
      }
    }
    
    # provenance
    
    if (!is.null(fun.args$provenance)){
      use_i <- stringr::str_detect(
        fun.args$provenance, 
        "(^knb-lter-[:alpha:]+\\.[:digit:]+\\.[:digit:]+)|(^[:alpha:]+\\.[:digit:]+\\.[:digit:]+)")
      if (!all(use_i)){
        warning(
          paste0("Unable to generate provenance metadata for unrecognized identifier:\n",
                 paste(fun.args$provenance[!use_i], collapse = ", ")),
          call. = F)
      }
    }

  }
  
  # Call from template_arguments() ------------------------------------------------
  
  if (fun.name == 'template_arguments') {
    
    # path
    
    if (!is.null(fun.args$path)) {
      EDIutils::validate_path(fun.args$path)
      attr_tmp <- read_template_attributes()
      path_files <- list.files(fun.args$path)
      if (!length(path_files) == 0) {
        is_template <- rep(FALSE, length(path_files))
        for (i in 1:length(path_files)){
          is_template[i] <- any(
            stringr::str_detect(path_files[i], attr_tmp$regexpr))
        }
        if (!any(is_template)) {
          stop("No metadata templates found at 'path'.", call. = F)
        }
      } else {
        stop("No metadata templates found at 'path'.", call. = F)
      }
      check_duplicate_templates(fun.args$path)
    }
    
    # data.path
    
    if (!is.null(fun.args$data.path)){
      EDIutils::validate_path(fun.args$data.path)
    }
    
    # data.table
    
    if (!is.null(fun.args$data.table)){
      output <- suppressWarnings(
        EDIutils::validate_file_names(
          path = fun.args$data.path,
          data.files = fun.args$data.table
        )
      )
    }
    
    # other.entity
    
    if (!is.null(fun.args$other.entity)){
      output <- suppressWarnings(
        EDIutils::validate_file_names(
          path = fun.args$data.path,
          data.files = fun.args$other.entity
        )
      )
    }
    
  }
  
  # Call from template_categorical_variables() -------------------------------------
  
  if (fun.name == 'template_categorical_variables'){
    
    # If not using x ...
    
    if (is.null(fun.args$x)){
      
      # Get attribute file names and data file names
      
      files <- list.files(fun.args$path)
      use_i <- stringr::str_detect(string = files,
                                   pattern = "^attributes")
      if (sum(use_i) == 0){
        stop('There are no attributes.txt files in your dataset working directory. Please fix this.', call. = F)
      }
      
      attribute_files <- files[use_i]
      table_names_base <- stringr::str_sub(string = attribute_files,
                                           start = 12,
                                           end = nchar(attribute_files)-4)
      data_files <- list.files(fun.args$data.path)
      use_i <- stringr::str_detect(string = data_files,
                                   pattern = stringr::str_c("^", table_names_base, collapse = "|"))
      table_names <- data_files[use_i]
      data_files <- table_names
      
      # Send warning if data table name is repeated more than once
      
      if (length(unique(tools::file_path_sans_ext(data_files))) != length(data_files)){
        stop('Duplicate data file names exist in this directory. Please remove duplicates, even if they are a different file type.', call. = F)
      }
      
      # If using x ...
      
    } else if (!is.null(fun.args$x)){
      
      # Get attribute file names and data file names
      
      files <- names(fun.args$x$template)
      use_i <- stringr::str_detect(string = files,
                                   pattern = "^attributes")
      if (sum(use_i) == 0){
        stop('There are no attributes.txt files in your dataset working directory. Please fix this.', call. = F)
      }
      
      attribute_files <- files[use_i]
      
      table_names_base <- stringr::str_sub(string = attribute_files,
                                           start = 12,
                                           end = nchar(attribute_files)-4)
      
      data_files <- names(fun.args$x$data.table)
      
      use_i <- stringr::str_detect(string = data_files,
                                   pattern = stringr::str_c("^", table_names_base, collapse = "|"))
      
      table_names <- data_files[use_i]
      data_files <- table_names
      
      # Send warning if data table name is repeated more than once
      
      if (length(unique(tools::file_path_sans_ext(data_files))) != length(data_files)){
        stop('Duplicate data file names exist in this directory. Please remove duplicates, even if they are a different file type.', call. = F)
      }
      
    }

  }
  
  # Call from template_core_metadata() ----------------------------------------
  
  if (fun.name == 'template_core_metadata'){
    
    # license
    
    if (is.null(fun.args$license)){
      stop('Input argument "license" is missing', call. = F)
    }
    
    license.low <- tolower(fun.args$license)
    
    if (!stringr::str_detect(license.low, "^cc0$|^ccby$")){
      stop('Invalid value entered for the "license" argument. Please choose "CC0" or "CCBY".', call. = F)
    }
    
    # file.type
    
    if ((fun.args$file.type != '.txt') & (fun.args$file.type != '.docx') & 
        (fun.args$file.type != '.md')){
      stop(paste0('"', fun.args$file.type, '" is not a valid entry to the "file.type" argument.'), call. = F)
    }
    
  }
  
  # Call from template_geographic_coverage() -------------------------------------
  
  if (fun.name == 'template_geographic_coverage'){

    if (!isTRUE(fun.args$empty)){
      
      # data.table
      
      if (is.null(fun.args$data.table)){
        stop('Input argument "data.table" is missing! Specify the data file containing the geographic coordinates.', call. = F)
      }
      
      # lat.col
      
      if (is.null(fun.args$lat.col)){
        stop('Input argument "lat.col" is missing! Specify latitude column name.', call. = F)
      }
      
      # lon.col
      
      if (is.null(fun.args$lon.col)){
        stop('Input argument "lon.col" is missing! Specify longitude column name.', call. = F)
      }
      
      # site.col
      
      if (is.null(fun.args$site.col)){
        stop('Input argument "site.col" is missing! Specify site column name.', call. = F)
      }
      
      if (is.null(fun.args$x)){
        
        # Validate file name
        
        data_file <- suppressWarnings(
          EDIutils::validate_file_names(
            path = fun.args$data.path, 
            data.files = fun.args$data.table
          )
        )
        
        # Read data table
        
        x <- template_arguments(
          data.path = fun.args$data.path,
          data.table = data_file
        )
        
        x <- x$x
        
        data_read_2_x <- NA_character_
        
      }
      
      df_table <- fun.args$x$data.table[[fun.args$data.table]]$content
      
      # Validate column names
      
      columns <- colnames(df_table)
      columns_in <- c(fun.args$lat.col, fun.args$lon.col, fun.args$site.col)
      use_i <- stringr::str_detect(string = columns,
                                   pattern = stringr::str_c("^", columns_in, "$", collapse = "|"))
      if (sum(use_i) > 0){
        use_i2 <- columns[use_i]
        use_i3 <- columns_in %in% use_i2
        if (sum(use_i) != 3){
          stop(paste("Invalid column names entered: ", paste(columns_in[!use_i3], collapse = ", "), sep = ""), call. = F)
        }
      }
    }

  }
  
  # Call from template_table_attributes() -------------------------------------
  
  if (fun.name == 'template_table_attributes'){
    
    # data.table
    
    if (!is.null(fun.args$data.table)){
      
      # Validate table names
      
      data_files <- suppressWarnings(
        EDIutils::validate_file_names(
          path = fun.args$data.path, 
          data.files = fun.args$data.table
        )
      )

    }
    
  }
  
  # Call from template_taxonomic_coverage() -------------------------------------
  
  if (fun.name == 'template_taxonomic_coverage'){
    
    # taxa.table

    if (is.null(fun.args$taxa.table)){
      stop('Input argument "taxa.table" is missing.', call. = F)
    }
    
    if (is.null(fun.args$x)){
      
      data_files <- suppressWarnings(
        EDIutils::validate_file_names(
          path = fun.args$data.path, 
          data.files = fun.args$taxa.table
        )
      )

    } else if (!is.null(fun.args$x)){
      
      if (!any(fun.args$taxa.table %in% names(fun.args$x$data.table))){
        stop('Input argument "taxa.table" is invalid.', call. = F)

      }
      
    }

    # taxa.col
    
    if (is.null(fun.args$taxa.col)){
      stop('Input argument "taxa.col" is missing.')
    }
    
    if (length(fun.args$taxa.col) != length(fun.args$taxa.table)){
      stop('Each "taxa.table" requires a corresponding "taxa.col".', call. = F)
    }
    
    if (is.null(fun.args$x)){
      
      x <- template_arguments(
        data.path = fun.args$data.path,
        data.table = data_files
      )
      
      for (i in seq_along(fun.args$taxa.table)){
        if (!isTRUE(fun.args$taxa.col[i] %in% colnames(x$x$data.table[[data_files[i]]]$content))){
          stop('Input argument "taxa.col" can not be found in "taxa.table".', call. = F)
        }
      }
      
    } else if (!is.null(fun.args$x)){
      
      for (i in seq_along(fun.args$taxa.table)){
        if (!isTRUE(fun.args$taxa.col[i] %in% colnames(fun.args$x$data.table[[fun.args$taxa.table[i]]]$content))){
          stop('Input argument "taxa.col" can not be found in "taxa.table"', call. = F)
        }
      }
      
    }
    
    # taxa.name.type
    
    if (is.null(fun.args$taxa.name.type)){
      
      stop('Input argument "taxa.name.type" is missing.', call. = F)
      
    } else {
      
      if (!any(tolower(fun.args$taxa.name.type) %in% c('scientific', 'common', 'both'))){
        
        stop('Input argument "taxa.name.type" must be "scientific", "common", or "both".', call. = F)
      }
      
    }
    
    # taxa.authority
    
    if (is.null(fun.args$taxa.authority)){
      stop('Input argument "taxa.authority" is missing.', call. = F)
    }
    
    authorities <- taxonomyCleanr::view_taxa_authorities()
    
    authorities <- authorities[authorities$resolve_sci_taxa == 'supported', ]
    
    use_i <- as.character(fun.args$taxa.authority) %in% as.character(authorities$id)
    
    if (sum(use_i) != length(use_i)){
      stop('Input argument "taxa.authority" contains unsupported authority IDs.', call. = F)
    }
  
  }
  
}
