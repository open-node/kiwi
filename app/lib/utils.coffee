_       = require 'underscore'
Chaplin = require 'chaplin'
# Application-specific utilities
# ------------------------------

# Delegate to Chaplin’s utils module.
utils = Chaplin.utils.beget Chaplin.utils

_.extend utils,
  time: ->
    moment().unix()

  numberCommas: (nStr) ->
    return "0" if not nStr
    nStr += ""
    x = nStr.split(".")
    x1 = x[0]
    x2 = (if x.length > 1 then "." + x[1] else "")
    rgx = /(\d+)(\d{3})/
    x1 = x1.replace(rgx, "$1" + "," + "$2")  while rgx.test(x1)
    x1 + x2

  intval: (value, mod = 10) ->
    parseInt(value, mod) or 0

  timeZone: _.memoize ->
    try timeZone = config.user.get('time_zone')
    timeZone = moment().zone() / -60 if not timeZone
    timeZone

  dateFormat: (date, format) ->
    return '' if not date
    format = 'YYYY-MM-DD HH:mm:ss' if not _.isString format
    moment(date).utc().add('hours', utils.timeZone()).format format

# Prevent creating new properties and stuff.
Object.seal? utils

module.exports = utils
