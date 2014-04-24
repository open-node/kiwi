FormView = require 'views/base/form-view'

module.exports = class UserInfoView extends FormView
  template: require './templates/user-info'
  listen:
    "loginStatusChange model": "render"
  events:
    "click .sign-out": "signOut"

  signOut: (e) ->
    e.preventDefault?()
    @model.clear()
    @model.trigger 'loginStatusChange'

  submit: (e) ->
    $cur = $(e.currentTarget || e)
    e.preventDefault?()
    @modelSet($cur)
    @model.set 'id', 1
    @model.trigger 'loginStatusChange'

