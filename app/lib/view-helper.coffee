Handlebars = require 'handlebars-runtime'

# Application-specific view helpers
# http://handlebarsjs.com/#helpers
# --------------------------------
_     = require 'underscore'
utils = require './utils'
i18n  = require './i18n'

register = (name, fn) ->
  Handlebars.registerHelper name, fn

# Map helpers
# -----------

# Make 'with' behave a little more mustachey.
register 'with', (context, options) ->
  if not context or Handlebars.Utils.isEmpty context
    options.inverse(this)
  else
    options.fn(context)

# Inverse for 'with'.
register 'without', (context, options) ->
  inverse = options.inverse
  options.inverse = options.fn
  options.fn = inverse
  Handlebars.helpers.with.call(this, context, options)

# Get Chaplin-declared named routes. {{url "likes#show" "105"}}
register 'url', (routeName, params..., options) ->
  utils.reverse routeName, params

register 't', (i18n_key) ->
  args = Array.prototype.slice.call(arguments, 0)
  result = i18n.t i18n_key, args
  # some further escaping
  result = Handlebars.Utils.escapeExpression result
  new Handlebars.SafeString result

register '_utils', (fn, args...) ->
  return if not utils[fn] or not _.isFunction utils[fn]
  result = utils[fn].apply null, args
  result = Handlebars.Utils.escapeExpression result
  new Handlebars.SafeString result

###
#If Equals
#if_eq this compare=that
####
register "if_eq", (context, options) ->
  return options.fn(this)  if context is options.hash.compare
  options.inverse this

register "time", (time, options) ->
  utils.dateFormat(time, 'YYYY-MM-DD HH:mm')

