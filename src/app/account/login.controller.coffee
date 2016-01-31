LoginController = () ->
  'ngInject'
  vm = this

  vm.clearErrors = () ->
    vm.errors = ''

  # TODO: 処理は後で書く
  vm.submit = () ->
    params = {
      email: vm.email
      password: vm.password
    }
  return

angular.module 'players'
  .controller 'LoginController', LoginController
