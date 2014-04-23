Application     = require './application'
routes          = require './routes'
i18n            = require 'lib/i18n'

# Initialize the application on DOM ready event.
$ ->
  # i18n L10n support. Initialize at here
  i18n.start i18n.lang()

  new Application {
    title: 'Brunch example application',
    controllerSuffix: '-controller',
    pushState: no,
    routes
  }
