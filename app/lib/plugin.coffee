_       = require 'underscore'

# 组合可以扩充的对象
# 所有允许扩充的对象都可以添加进来，让第三方来扩充功能
classes =
  CollectionView: require 'views/base/collection-view'
  View: require 'views/base/view'
  utils: require './utils'

module.exports =
  init: (plugins) ->
    _.each plugins, (plugin) ->
      if not _.isFunction plugin.module
        throw Error 'Plugin module must exports a function'
      plugin.module classes, plugin.options

