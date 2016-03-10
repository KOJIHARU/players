MainController = (toastr, $location) ->
  'ngInject'
  vm = this

  if $location.search()['registed'] == 'ok'
    $location.url '/login'
    toastr.success 'アカウント登録が完了しました。ログインしてください'

  return

angular.module 'players'
  .controller('MainController', MainController)
