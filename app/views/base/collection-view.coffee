Chaplin = require 'chaplin'
View    = require './view'
Model   = require 'models/base/model'
utils   = require 'lib/utils'

module.exports = class CollectionView extends Chaplin.CollectionView
  # This class doesn’t inherit from the application-specific View class,
  # so we need to borrow the method from the View prototype:
  getTemplateFunction: View::getTemplateFunction

  # 分页使用，当前是第几页
  page: 1
  # 分页使用，每页显示多少条
  pageSize: 10
  # 分页使用，分页的视图
  PaginationView: require('views/pagination-view')
  # 分页左侧间隔多少个
  paginationLeftIntval: 3
  # 分页右侧间隔多少个
  paginationRightIntval: 3
  # 是否客户端分页
  isClientPaginate: no

  listen:
    "sync collection": "handlePagination"

  handlePagination: (collection, models, response) ->
    return if not @PaginationView
    # 记录原始的数据，用于前端检索和分页
    @origModels = models
    # 记录可见的数据，用于前端检索
    @visableModels = models
    @total = @getRecordTotal(response and response.xhr)
    return if not @total or @total <= @pageSize
    @pagination()

  getRecordTotal: (xhr) ->
    return @visableModels.length if @isClientPaginate
    utils.intval xhr.getResponseHeader('X-Content-Record-Total')

  # 客户端分页执行函数
  clientPaginate: ->
    startIndex = (@page - 1) * @pageSize
    @collection.reset @visableModels.slice startIndex, startIndex + @pageSize

  pagination: ->
    @total = @visableModels.length if @isClientPaginate
    options =
      total: @total
      page: @page
      left: @paginationLeftIntval
      right: @paginationRightIntval
      size: @pageSize
    model = new Model options
    @paginationView = new @PaginationView
      model: model
      className: 'pagination'
      container: @$ ".pages"

    @paginationView.on 'ChangePage', @changePage
    @clientPaginate() if @isClientPaginate

  # obj 包含 page 和 size 两项
  changePage: (obj) =>
    @page = obj.page or @page
    @pageSize = obj.size or @pageSize
    return @pagination() if @isClientPaginate
    @collection.options.startIndex = (@page - 1) * @pageSize
    @collection.options.maxResults = @pageSize
    @collection.fetch()

