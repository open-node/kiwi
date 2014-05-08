# Application routes.
module.exports = (match) ->
  match '', 'home#index'
  match '!/feature/:feature', 'feature#index'
