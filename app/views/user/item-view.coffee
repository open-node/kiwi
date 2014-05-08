View = require 'views/base/view'

module.exports = class UserItemView extends View
  template: require './templates/item'
  tagName: 'tr'
