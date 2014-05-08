View            = require 'views/base/view'
template        = require './templates/pagination'
utils           = require 'lib/utils'

module.exports = class PaginationView extends View
  autoRender: no
  tagName: 'ul'
  containerMethod: 'html'
  template: template
  events:
    'click li>a': 'changePage'

  initialize: ->
    super
    opt = @model.getAttributes()

    last = Math.ceil opt.total / opt.size
    start = Math.max 1, opt.page - opt.left
    end = Math.min last, start + opt.left + opt.right
    start = Math.max 1, end - opt.left - opt.right

    pages = [start..end]
    @model.set 'prev', opt.page - 1
    @model.set 'next', if opt.page is last then 0 else opt.page + 1
    @model.set 'first', if 1 in pages then 0 else 1
    @model.set 'last', if last in pages then 0 else last

    pages.shift() if 1 not in pages
    pages.pop() if last not in pages
    @model.set 'pages', pages
    @render()

  changePage: (e) ->
    cur = $ e.currentTarget || e
    curPage = @model.get "page"
    page = cur.data "page"
    return if page is undefined or page.length is 0
    page = utils.intval page
    return if curPage is page
    @trigger 'ChangePage', page: page
