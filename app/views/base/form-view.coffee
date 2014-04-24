_     = require 'underscore'
View  = require "./view"
i18n  = require 'lib/i18n'


module.exports = class FormView extends View
  events:
    "submit form": "submit"

  save: ->
    @model.save()

  submit: (e) =>
    $cur = $(e.currentTarget || e)
    e.preventDefault?()
    @modelSet($cur)
    @submitStart()
    @save()
      .always(@submitEnd)
      .success(@success)
      .error(@error)

  modelSet: ($form) =>
    hash = @getFormVariables($form)
    @model.set hash

  getFormVariables: ($form) ->
    hash = {}
    for item in $form.serializeArray()
      paths = item.name.split('.')
      last = paths.pop()
      parent = hash
      for path in paths
        parent[path] = parent[path] or {}
        parent = parent[path]
      # 应对统一个name对应多个值的情况，需要处理为数组的格式
      parent[last] = [parent[last]] if _.isString parent[last]

      if _.isArray parent[last]
        parent[last].push item.value
      else
        parent[last] = item.value
    hash

  submitStart: =>
    @$(".msg").html('').addClass("hidden")
    @$el.addClass("loading")

  submitEnd: =>
    @$el.removeClass("loading")

  success: (res) =>
    @$(".modal").modal('hide')
    @model.collection?.unshift @model
    @model.collection?.trigger 'newAdd', @model.id

  error: (res) =>
    try
      errors = res.responseJSON.errors
      if errors and _.size(errors) > 0
        _.each errors, (msg, field) =>
          msg = msg.join("<br />") if msg.join
          elem = @$(".field-#{field}").addClass('error')
          msgBox = elem.find(".msg").html(msg).removeClass("hidden").addClass("alert alert-danger")
          elem.find("input:visible:eq(0)").focus()
          @showCommonError("<p>#{field}: #{msg}</p>")
      else
        error = res.responseJSON.message or res.responseJSON.code || i18n.t("unknow error")
        @showCommonError error
    catch e
      @showCommonError i18n.t 'Unknow error'

  showCommonError: (msg) ->
    @$(".common.msg")
      .append(msg)
      .addClass('alert alert-danger')
      .removeClass('hidden')
      .show()
