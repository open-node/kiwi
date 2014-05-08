Model         = require './model'
config        = require '../../config'
Chaplin       = require 'chaplin'

module.exports = class Collection extends Chaplin.Collection

  options: {}

  apiRoot: config.apiRoot

  # Use the project base model per default, not Chaplin.Model
  model: Model

  # 存放那些需要附加到借口的参数列表
  attrs: 'startIndex,maxResults,sort,startDate,endDate,filters,primary,secondary'

  url: ->
    "#{@apiRoot}#{@urlPath()}?#{@querystring(@queryParams())}"

  querystring: (params) ->
    params.access_token = localStorage.getItem 'access_token'
    _.map(params, (v, k) -> "#{k}=#{encodeURIComponent v}").join '&'

  fetch: =>
    _this = @
    res = super
    res
      .always(->_this.fetched = yes)
      .error((e)-> _this.trigger 'fetchError', e)
    res

  queryParams: =>
    attrs = @attrs.split ','
    params = {}
    @options = @options || {}
    for key in attrs when config.urlParams[key]
      params[key] = config.urlParams[key]
    for key in attrs when @options[key]
      params[key] = @options[key]
    params

  constructor: ->
    @opt arguments[2]
    super

  opt: (options) ->
    @options = options
