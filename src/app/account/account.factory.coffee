AccountFactory = ($q, $http, toastr, $location) ->
  'ngInject'
  host =
    if $location.host() == 'localhost' then 'http://localhost:3001/' else ''

  return {
    postEmailUserRegistration: (params) ->
      defer = $q.defer()
      $http.post(host + 'email_user/registrations', params)
        .success((data) ->
          toastr.success 'メールを送信しました'
          $location.path 'login'
          defer.resolve data
          return
        ).error (data) ->
          if (typeof data != 'undefined')
            defer.reject data
          return
      return defer.promise
  }

angular.module 'players'
  .factory 'AccountFactory', AccountFactory
