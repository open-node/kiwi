View = require '../base/view'

module.exports = class HeaderView extends View
  autoRender: true
  className: 'container'
  tagName: 'div'
  template: require './templates/header'
  regions:
    userInfo: '#header-userinfo'
