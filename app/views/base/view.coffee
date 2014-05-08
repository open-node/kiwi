Chaplin = require 'chaplin'
require 'lib/view-helper' # Just load the view helpers, no return value

module.exports = class View extends Chaplin.View
  # Auto-save `template` option passed to any view as `@template`.
  optionNames: Chaplin.View::optionNames.concat ['template']

  # Precompiled templates function initializer.
  getTemplateFunction: ->
    @template

  listen:
    'addedToDOM': 'addedToDOM'

  addedToDOM: ->
    # 需要的时候在派生类重写此方法
    return
