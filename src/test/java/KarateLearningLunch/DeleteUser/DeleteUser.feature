Feature:IOI
#http://dummy.restapiexample.com/
  Background:
    * url baseUrl+DeleteUser
    * configure retry = { count: 5, interval: 0 }
    * def ExistingUserId = '719'

  @Execute
  Scenario: Delete User
    When path ExistingUserId
    And method delete
    And status 200



