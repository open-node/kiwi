View            = require 'views/base/view'
UserListView    = require 'views/user/list-view'
UserCollection  = require 'models/user-collection'

module.exports = class FeaturePaginationView extends View
  autoRender: true
  template: require './templates/pagination'
  containerMethod: 'html'
  regions:
    clientPagination: '#client-pagination'
    serverPagination: '#server-pagination'

  addedToDOM: ->
    @serverPaginationView = new UserListView
      collection: new UserCollection()
      region: 'serverPagination'
    @serverPaginationView.collection.fetch()

    @clientPaginationView = new UserListView
      collection: new UserCollection()
      region: 'clientPagination'
    @clientPaginationView.isClientPaginate = yes
    @clientPaginationView.collection.fetch('all')
