View = require 'views/base/view'

module.exports = class FeatureItemView extends View
  template: require './templates/feature-item'
  tagName: 'div'
  className: 'col-md-4'
