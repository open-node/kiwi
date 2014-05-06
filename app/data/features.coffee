i18n = require 'lib/i18n'

module.exports = ->
  [{
    id: 1
    key: 'pagination'
    name: i18n.t '分页'
    desc: i18n.t '分页分为两种，客户端分页，和服务器端分页'
  }, {
    id: 2
    key: 'quick-edit'
    name: i18n.t '快速编辑和添加'
    desc: i18n.t '快速编辑和添加是指在原地快速弹出 popover 之后用户设置完毕后直接添加，讲究的是就地、快速的处理'
  }, {
    id: 3
    key: 'i18n'
    name: i18n.t 'i18n、L10n'
    desc: i18n.t '国际化、本地化如何处理，简而言之就是多语言的处理'
  }, {
    id: 4
    key: 'collection-view'
    name: i18n.t '列表的显示'
    desc: i18n.t '列表的呈现一般对应的api接口也是一个列表的接口，即返回的数据是数组格式，所以只要数据是数组一定有用CollectionView去呈现它, 一定要去继承系统的collection view 基类， require("views/base/collection-view")'
  }, {
    id: 5
    key: 'form-view'
    name: i18n.t '表单'
    desc: i18n.t '表单用来收集用户的输入，一般包含文本输入，按钮，下拉菜单等。凡是遇到表单的都一定要继承系统提供的FormView基类, require("views/base/form-view")'
  }]
