Chaplin     = require 'chaplin'
SiteView    = require 'views/site-view'
HeaderView  = require 'views/home/header-view'

module.exports = class Controller extends Chaplin.Controller
  # Reusabilities persist stuff between controllers.
  # You may also persist models etc.
  beforeAction: ->
    @reuseView()


  # 重复使用view
  reuseView: ->
    @reuse 'site', SiteView
    @reuse 'header', HeaderView, region: 'header'
