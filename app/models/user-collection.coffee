Collection  = require './base/collection'
Model       = require './base/model'
data        = require 'data/users'

module.exports = class Collection extends Collection
  urlPath: ->
    "/users"

  model: Model

  fetch: (isAll = no) ->
    list = data
    @reset(list)
    @trigger 'sync'
