CollectionView  = require 'views/base/collection-view'
ItemView        = require './item-view'

module.exports = class UserListView extends CollectionView
  template: require './templates/list'
  itemView: ItemView
  listSelector: 'tbody'
