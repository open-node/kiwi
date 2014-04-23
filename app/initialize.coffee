Application     = require './application'
routes          = require './routes'
# 很奇怪，此处如果不加载控制器则chaplin的$为undefined
HomeController  = require 'controllers/home-controller'

# Initialize the application on DOM ready event.
$ ->
  new Application {
    title: 'Brunch example application',
    controllerSuffix: '-controller',
    pushState: no,
    routes
  }
