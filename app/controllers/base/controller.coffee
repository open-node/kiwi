Chaplin       = require 'chaplin'
SiteView      = require 'views/site-view'
HeaderView    = require 'views/home/header-view'
UserInfoView  = require 'views/home/user-info-view'
User          = require 'models/user'
config        = require '../../config'

module.exports = class Controller extends Chaplin.Controller
  # Reusabilities persist stuff between controllers.
  # You may also persist models etc.
  beforeAction: ->
    config.user = new User() unless config.user
    @reuseView()

  # 重复使用view
  reuseView: ->
    @reuse 'site', SiteView
    @reuse 'header', HeaderView, region: 'header'
    @reuse 'userInfo', UserInfoView, {region: 'userInfo', model: config.user}
