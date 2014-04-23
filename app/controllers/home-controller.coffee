Controller      = require './base/controller'
Collection      = require 'models/base/collection'
HomePageView    = require 'views/home/home-page-view'
FeatureListView = require 'views/home/feature-list'

features        = require 'data/features'

module.exports = class HomeController extends Controller

  reuseView: ->
    super

    @reuse 'homePageView', HomePageView, {region: 'main'}

  index: ->

    @featureListView = new FeatureListView
      collection: new Collection(features())
      region: 'featureList'

