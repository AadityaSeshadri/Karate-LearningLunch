Feature:IOI
#http://dummy.restapiexample.com/
  Background:
    * url baseUrl+PutUser
    * configure retry = { count: 5, interval: 0 }
    * def ExistingUserId = '719'

  @Execute
  Scenario Outline: Create New User - Test Data from csv
    When path ExistingUserId
    And request {"name":<Name>,"salary":<Salary>,"age":<Age>}
    And method put
    Then match response ==
    """
    {"status":"success","data":null}
    """
    And status 200
    Examples:
      | read('PutUser.csv') |


