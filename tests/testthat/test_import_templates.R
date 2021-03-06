context('Import templates')
library(EMLassemblyline)

# File inputs = no data tables ------------------------------------------------

testthat::test_that('File inputs = no data tables', {
  
  # Missing path results in error
  
  expect_error(
    suppressWarnings(
      suppressMessages(
        import_templates(
          license = 'CC0',
          write.file = FALSE
        )
      )
    )
  )
  
  # Missing license results in error
  
  expect_error(
    suppressWarnings(
      suppressMessages(
        import_templates(
          path = system.file(
            '/examples',
            package = 'EMLassemblyline'
          ),
          write.file = FALSE
        )
      ) 
    )
  )
  
  # Unsupported license results in error
  
  expect_error(
    suppressWarnings(
      suppressMessages(
        import_templates(
          path = system.file(
            '/examples',
            package = 'EMLassemblyline'
          ),
          license = 'CCzero',
          write.file = FALSE
        )
      )
    )
  )
  
  # New imports result in messages
  
  expect_message(
    suppressWarnings(
      import_templates(
        path = system.file(
          '/examples',
          package = 'EMLassemblyline'
        ),
        license = 'CC0',
        write.file = FALSE
      )
    )
  )
  
  expect_message(
    suppressWarnings(
      import_templates(
        path = system.file(
          '/examples',
          package = 'EMLassemblyline'
        ),
        license = 'CCBY',
        write.file = FALSE
      ) 
    )
  )
  
  # Attempt to import templates when they already exist results in messages
  
  expect_message(
    suppressWarnings(
      import_templates(
        path = system.file(
          '/examples/templates',
          package = 'EMLassemblyline'
        ),
        license = 'CC0',
        write.file = FALSE
      ) 
    )
  )
  
  # write.file = TRUE writes files to path
  
  expect_message(
    suppressWarnings(
      import_templates(
        path = tempdir(), 
        license = 'CC0',
        write.file = TRUE
      ) 
    )
  )
  
  expect_message(
    suppressWarnings(
      import_templates(
        path = tempdir(), 
        license = 'CCBY',
        write.file = TRUE
      ) 
    )
  )

})


# File inputs = two data tables -----------------------------------------------

testthat::test_that('Test usage with file inputs', {
  
  # Missing path results in error
  
  expect_error(
    suppressMessages(
      suppressWarnings(
        import_templates(
          data.path = system.file(
            '/examples/data',
            package = 'EMLassemblyline'
          ),
          data.table = c(
            'decomp.csv',
            'nitrogen.csv'
          ),
          license = 'CC0',
          write.file = FALSE
        )
      )
    )
  )
  
  # Missing license results in error
  
  expect_error(
    suppressMessages(
      suppressWarnings(
        import_templates(
          path = system.file(
            '/examples',
            package = 'EMLassemblyline'
          ),
          data.path = system.file(
            '/examples/data',
            package = 'EMLassemblyline'
          ),
          data.table = c(
            'decomp.csv',
            'nitrogen.csv'
          ),
          write.file = FALSE
        )
      )
    )
  )
  
  # Unsupported license results in error
  
  expect_error(
    suppressMessages(
      suppressWarnings(
        import_templates(
          path = system.file(
            '/examples',
            package = 'EMLassemblyline'
          ),
          data.path = system.file(
            '/examples/data',
            package = 'EMLassemblyline'
          ),
          data.table = c(
            'decomp.csv',
            'nitrogen.csv'
          ),
          license = 'CCzero',
          write.file = FALSE
        ) 
      )
    )
  )
  
  # Invalid data path results in error
  
  expect_error(
    suppressMessages(
      suppressWarnings(
        import_templates(
          path = system.file(
            '/examples',
            package = 'EMLassemblyline'
          ),
          data.table = c(
            'decomp.csv',
            'nitrogen.csv'
          ),
          license = 'CC0',
          write.file = FALSE
        ) 
      )
    )
  )
  
  # Invalid data tables result in error
  
  expect_error(
    suppressMessages(
      suppressWarnings(
        import_templates(
          path = system.file(
            '/examples',
            package = 'EMLassemblyline'
          ),
          data.path = system.file(
            '/examples/data',
            package = 'EMLassemblyline'
          ),
          data.table = c(
            'decompppp.csv',
            'nitrogennnnn.csv'
          ),
          license = 'CC0',
          write.file = FALSE
        ) 
      )
    )
  )

  # New imports result in messages
  
  expect_message(
    suppressWarnings(
      import_templates(
        path = system.file(
          '/examples',
          package = 'EMLassemblyline'
        ),
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        data.table = c(
          'decomp.csv',
          'nitrogen.csv'
        ),
        license = 'CC0',
        write.file = FALSE
      ) 
    )
  )
  
  # Deprecated argument results in warning
  
  expect_warning(
    suppressMessages(
      import_templates(
        path = system.file(
          '/examples',
          package = 'EMLassemblyline'
        ),
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        data.files = c(
          'decomp.csv',
          'nitrogen.csv'
        ),
        license = 'CC0',
        write.file = FALSE
      ) 
    )
  )

  # Attempt to import templates when they already exist results in messages
  
  expect_message(
    suppressWarnings(
      import_templates(
        path = system.file(
          '/examples/templates',
          package = 'EMLassemblyline'
        ),
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        data.table = c(
          'decomp.csv',
          'nitrogen.csv'
        ),
        license = 'CC0',
        write.file = FALSE
      ) 
    )
  )
  
  # write.file = TRUE writes files to path
  
  expect_message(
    suppressWarnings(
      import_templates(
        path = tempdir(),
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        data.table = c(
          'decomp.csv',
          'nitrogen.csv'
        ),
        license = 'CC0',
        write.file = TRUE
      ) 
    )
  )
  
  # write.file = TRUE does not overwrite existing files
  
  expect_message(
    suppressWarnings(
      import_templates(
        path = tempdir(),
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        data.table = c(
          'decomp.csv',
          'nitrogen.csv'
        ),
        license = 'CC0',
        write.file = TRUE
      ) 
    )
  )
  
})

# x inputs = NULL -------------------------------------------------------------

testthat::test_that('x inputs = NULL', {

  # Make function call

  x <- template_arguments()

  x <- x$x

  # Missing path results in messages

  expect_message(
    suppressWarnings(
      import_templates(
        license = 'CC0',
        x = x,
        write.file = FALSE
      )
    )
  )

  # Missing path results in expected content classes with empty values

  output <- suppressMessages(
    suppressWarnings(
      import_templates(
        license = 'CC0',
        x = x,
        write.file = FALSE
      )
    )
  )

  for (i in 1:length(output$template)){

    expect_equal(
      class(output$template[[i]]$content)[1] %in%
        c('list', 'data.frame', 'list', 'character'),
      TRUE
    )

  }

  # Missing license results in error

  expect_error(
    suppressMessages(
      suppressWarnings(
        import_templates(
          path = system.file(
            '/examples',
            package = 'EMLassemblyline'
          ),
          x = x,
          write.file = FALSE
        )
      )
    )
  )

  # Unsupported license results in error

  expect_error(
    suppressMessages(
      suppressWarnings(
        import_templates(
          path = system.file(
            '/examples',
            package = 'EMLassemblyline'
          ),
          x = x,
          license = 'CCzero',
          write.file = FALSE
        )
      )
    )
  )

  # Valid path results in messages

  expect_message(
    suppressWarnings(
      import_templates(
        path = system.file(
          '/examples',
          package = 'EMLassemblyline'
        ),
        x = x,
        license = 'CC0',
        write.file = FALSE
      )
    )
  )

  # Valid path results in expected content classes with empty values

  output <- suppressMessages(
    suppressWarnings(
      import_templates(
        path = system.file(
          '/examples',
          package = 'EMLassemblyline'
        ),
        license = 'CC0',
        x = x,
        write.file = FALSE
      )
    )
  )

  for (i in 1:length(output$template)){

    expect_equal(
      class(output$template[[i]]$content)[1] %in%
        c('list', 'data.frame', 'list', 'character'),
      TRUE
    )

  }

  # Attempt to import templates when they already exist results in messages

  expect_message(
    suppressWarnings(
      import_templates(
        path = system.file(
          '/examples/templates',
          package = 'EMLassemblyline'
        ),
        x = output,
        license = 'CC0',
        write.file = FALSE
      )
    )
  )

  # CCBY is supported

  expect_message(
    suppressWarnings(
      import_templates(
        path = system.file(
          '/examples',
          package = 'EMLassemblyline'
        ),
        x = x,
        license = 'CCBY',
        write.file = FALSE
      )
    )
  )

})

# x inputs = data tables ------------------------------------------------------

testthat::test_that('x inputs = data tables', {

  # Make function call

  x <- template_arguments(
    data.path = system.file(
      '/examples/data',
      package = 'EMLassemblyline'
    ),
    data.table = c(
      'decomp.csv',
      'nitrogen.csv'
    )
  )

  x <- x$x

  # Missing path and data path results in messages

  expect_message(
    suppressWarnings(
      import_templates(
        license = 'CC0',
        x = x,
        write.file = FALSE
      )
    )
  )

  # Missing path results in messages

  expect_message(
    suppressWarnings(
      import_templates(
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        license = 'CC0',
        x = x,
        write.file = FALSE
      )
    )
  )

  # Missing data path results in messages

  expect_message(
    suppressWarnings(
      import_templates(
        path = system.file(
          '/examples',
          package = 'EMLassemblyline'
        ),
        license = 'CC0',
        x = x,
        write.file = FALSE
      )
    )
  )

  # Missing license results in error

  expect_error(
    suppressMessages(
      suppressWarnings(
        import_templates(
          path = system.file(
            '/examples',
            package = 'EMLassemblyline'
          ),
          x = x,
          write.file = FALSE
        )
      )
    )
  )

  # Unsupported license results in error

  expect_error(
    suppressMessages(
      suppressWarnings(
        import_templates(
          path = system.file(
            '/examples',
            package = 'EMLassemblyline'
          ),
          x = x,
          license = 'CCzero',
          write.file = FALSE
        )
      )
    )
  )

  # Valid data path and data tables results in messages

  expect_message(
    suppressWarnings(
      import_templates(
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        data.table = c(
          'decomp.csv',
          'nitrogen.csv'
        ),
        x = x,
        license = 'CC0',
        write.file = FALSE
      )
    )
  )

  # Deprecated argument results in warning

  expect_warning(
    suppressMessages(
      import_templates(
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        data.files = c(
          'decomp.csv',
          'nitrogen.csv'
        ),
        x = x,
        license = 'CC0',
        write.file = FALSE
      )
    )
  )

  # Valid data path and data tables result in addition of attributes templates
  # with expected names, class, column names, and nrows > 1

  output <- suppressMessages(
    suppressWarnings(
      import_templates(
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        data.table = c(
          'decomp.csv',
          'nitrogen.csv'
        ),
        x = x,
        license = 'CC0',
        write.file = FALSE
      )
    )
  )

  attr_names <- paste0(
    'attributes_',
    stringr::str_remove(
      string = names(output$data.table),
      pattern = '.csv'
    ),
    '.txt'
  )

  for (i in 1:length(attr_names)){

    expect_equal(
      attr_names[i] %in% names(output$template),
      TRUE
    )

    expect_equal(
      class(output$template[[attr_names[i]]]$content),
      'data.frame'
    )

    expect_equal(
      all(
        colnames(output$template[[attr_names[i]]]$content) %in%
          c('attributeName', 'attributeDefinition', 'class', 'unit',
            'dateTimeFormatString', 'missingValueCode',
            'missingValueCodeExplanation')
      ),
      TRUE
    )

    expect_equal(
      nrow(output$template[[attr_names[i]]]$content) > 1,
      TRUE
    )

  }

  # Attempt to import templates when they already exist results in messages

  expect_message(
    suppressWarnings(
      import_templates(
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        data.table = c(
          'decomp.csv',
          'nitrogen.csv'
        ),
        x = output,
        license = 'CC0',
        write.file = FALSE
      )
    )
  )

  # Invalid column names result in error

  input <- x

  colnames(input$data.table$nitrogen.csv$content)[
    colnames(input$data.table$nitrogen.csv$content) == 'stem_mass_density'
    ] <- 'stem.mass.density'

  expect_error(
    suppressMessages(
      suppressWarnings(
        import_templates(
          data.path = system.file(
            '/examples/data',
            package = 'EMLassemblyline'
          ),
          data.table = c(
            'decomp.csv',
            'nitrogen.csv'
          ),
          x = input,
          license = 'CC0',
          write.file = FALSE
        )
      )
    )
  )

})

# x inputs = data tables and templates ----------------------------------------

testthat::test_that('x inputs = data tables and templates', {

  # Make function call

  x <- template_arguments(
    path = system.file(
      '/examples/templates',
      package = 'EMLassemblyline'
    ),
    data.path = system.file(
      '/examples/data',
      package = 'EMLassemblyline'
    ),
    data.table = c(
      'decomp.csv',
      'nitrogen.csv'
    )
  )

  x <- x$x

  # Remove attributes_*txt templates

  x$template$attributes_decomp.txt <- NULL

  x$template$attributes_nitrogen.txt <- NULL

  # Missing path and data path results in messages

  expect_message(
    suppressWarnings(
      import_templates(
        license = 'CC0',
        x = x,
        write.file = FALSE
      )
    )
  )

  # Missing path results in messages

  expect_message(
    suppressWarnings(
      import_templates(
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        license = 'CC0',
        x = x,
        write.file = FALSE
      )
    )
  )

  # Missing data path results in messages

  expect_message(
    suppressWarnings(
      import_templates(
        path = system.file(
          '/examples',
          package = 'EMLassemblyline'
        ),
        license = 'CC0',
        x = x,
        write.file = FALSE
      )
    )
  )

  # Missing license results in error

  expect_error(
    suppressMessages(
      suppressWarnings(
        import_templates(
          path = system.file(
            '/examples',
            package = 'EMLassemblyline'
          ),
          x = x,
          write.file = FALSE
        )
      )
    )
  )

  # Unsupported license results in error

  expect_error(
    suppressMessages(
      suppressWarnings(
        import_templates(
          path = system.file(
            '/examples',
            package = 'EMLassemblyline'
          ),
          x = x,
          license = 'CCzero',
          write.file = FALSE
        )
      )
    )
  )

  # Valid data path and data tables results in messages

  expect_message(
    suppressWarnings(
      import_templates(
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        data.table = c(
          'decomp.csv',
          'nitrogen.csv'
        ),
        x = x,
        license = 'CC0',
        write.file = FALSE
      )
    )
  )

  # Deprecated argument results in warning

  expect_warning(
    suppressMessages(
      import_templates(
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        data.files = c(
          'decomp.csv',
          'nitrogen.csv'
        ),
        x = x,
        license = 'CC0',
        write.file = FALSE
      )
    )
  )

  # Valid data path and data tables result in addition of attributes templates
  # with expected names, class, column names, and nrows > 1

  output <- suppressMessages(
    suppressWarnings(
      import_templates(
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        data.table = c(
          'decomp.csv',
          'nitrogen.csv'
        ),
        x = x,
        license = 'CC0',
        write.file = FALSE
      )
    )
  )

  attr_names <- paste0(
    'attributes_',
    stringr::str_remove(
      string = names(output$data.table),
      pattern = '.csv'
    ),
    '.txt'
  )

  for (i in 1:length(attr_names)){

    expect_equal(
      attr_names[i] %in% names(output$template),
      TRUE
    )

    expect_equal(
      class(output$template[[attr_names[i]]]$content),
      'data.frame'
    )

    expect_equal(
      all(
        colnames(output$template[[attr_names[i]]]$content) %in%
          c('attributeName', 'attributeDefinition', 'class', 'unit',
            'dateTimeFormatString', 'missingValueCode',
            'missingValueCodeExplanation')
      ),
      TRUE
    )

    expect_equal(
      nrow(output$template[[attr_names[i]]]$content) > 1,
      TRUE
    )

  }

  # Attempt to import templates when they already exist results in messages

  expect_message(
    suppressWarnings(
      import_templates(
        data.path = system.file(
          '/examples/data',
          package = 'EMLassemblyline'
        ),
        data.table = c(
          'decomp.csv',
          'nitrogen.csv'
        ),
        x = output,
        license = 'CC0',
        write.file = FALSE
      )
    )
  )

})

