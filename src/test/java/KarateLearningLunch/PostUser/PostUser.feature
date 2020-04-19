Feature:IOI
#http://dummy.restapiexample.com/
Background:
  * url baseUrl+PostUser
  * configure retry = { count: 5, interval: 0 }

  @Execute
  Scenario Outline: Create New User - Test Data from csv
    When request {"name":<Name>,"salary":<Salary>,"age":<Age>}
    And method post
    Then match response ==
    """
     {
        "status": "success",
        "data":
        {
            "name": <Name>,
            "salary": <Salary>,
            "age": <Age>,
            "id": #number
        }
     }
    """
    And status 200
    Examples:
      | read('PostUser.csv') |


