View = require '../base/view'

module.exports = class FeaturePageView extends View
  autoRender: true
  className: 'home-page'
  template: require './templates/home'
  containerMethod: 'html'
  regions:
    featureDetail: '#feature-detail'
