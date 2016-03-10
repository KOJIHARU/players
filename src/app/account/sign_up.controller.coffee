SignUpController = (AccountFactory) ->
  'ngInject'
  vm = this

  vm.clearErrors = () ->
    vm.errors = ''

  vm.submit = () ->
    params = {
      email: vm.email
      password: vm.password
      password_confirmation: vm.password_confirmation
    }
    AccountFactory.postEmailUserRegistration(params).then((res) ->
    ).catch (res) ->
      return

  return

angular.module 'players'
  .controller 'SignUpController', SignUpController
