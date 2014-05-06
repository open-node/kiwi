Application     = require './application'
routes          = require './routes'
i18n            = require 'lib/i18n'
plugin          = require 'lib/plugin'
config          = require './config'

# Initialize the application on DOM ready event.
$ ->
  # i18n L10n support. Initialize at here
  i18n.start i18n.lang()

  # 插件初始化
  # 插件一般都是扩充原生类功能
  # 比如views/base/view、views/base/collection-view
  plugin.init(config.plugin or [])

  new Application {
    title: 'Brunch example application',
    controllerSuffix: '-controller',
    pushState: no,
    routes
  }
