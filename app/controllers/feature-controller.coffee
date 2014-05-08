_               = require 'underscore'

Controller      = require './base/controller'
Model           = require 'models/base/model'
FeaturePageView = require 'views/feature/page-view'
i18n            = require 'lib/i18n'

features        = require 'data/features'

module.exports = class FeatureController extends Controller

  reuseView: ->
    super

    @reuse 'featurePageView', FeaturePageView, {region: 'main'}

  index: (params, route, options) ->
    feature = _.find(features(), (x) -> params.feature is x.key)
    return ui.showError(i18n.t('Page not found')) if not feature

    @featureDetailView = new (require("views/feature/#{params.feature}-view"))
      model: new Model feature
      region: 'featureDetail'
