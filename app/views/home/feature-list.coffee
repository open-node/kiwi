CollectionView  = require 'views/base/collection-view'
ItemView        = require './feature-item'

module.exports = class FeatureCollectionView extends CollectionView
  itemView: ItemView
  tagName: 'div'
  className: 'row'

