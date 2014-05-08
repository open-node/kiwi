Collection  = require './base/collection'
Model       = require './base/model'
utils       = require 'lib/utils'
data        = require 'data/users'

response =
  xhr:
    getResponseHeader: ->
      34

module.exports = class UserCollection extends Collection
  urlPath: ->
    "/users"

  model: Model

  fetch: ->
    startIndex = utils.intval(@options.startIndex)
    maxResults = utils.intval(@options.maxResults or 10)
    if @options.all isnt yes
      list = data[startIndex...startIndex + maxResults]
    else
      list = data
    @reset(list)
    @trigger 'sync', @, @models, response
