Feature:IOI

Background:
  Given url 'http://ilex-test-fe-lb-317145507.ap-southeast-1.elb.amazonaws.com/api/trade/login'
  And request {username: "Buyer@comp.com", password: "password"}
  And method post
  * url baseUrl+IOI
  * print '--------------------->'+url

  @IOI_forthedemo
  Scenario: Clear DB
    * def DeleteDB =
    """
    function()
    {
       var DataStorage = Java.type('Ilex.utils.DbUtils');
       var dS = new DataStorage();
       return dS.DeleteDataTestDB();
    }
    """
    * def ConfirmDB = DeleteDB()
    * print ConfirmDB
    * def GetTableCount =
      """
      function()
      {
         var DataStorage = Java.type('Ilex.utils.DbUtils');
         var dS = new DataStorage();
         return dS.GetTableCount();
      }
      """
    * def Count = GetTableCount()
    * print 'Count After Truncating Database Table----------------->', Count
    * assert temp == '0'


@IOI_forthedemo
Scenario Outline: Create New IOI with Dynamic Status Query Parameter
   # * print path
    Given param action = 'SUBMITTED'
    When request
      """
      {"name":"<IOIName>",
      "goodUntil":null,
      "borrowers":[],
      "industries":["<industryId1>"],
      "countriesOfRisk":["<RiskCountry1>"],
      "purposes":[],
      "facilitiesType":[],
      "currencies":[],
      "minSpread":"<SpreadMin>",
      "maxSpread":"<SpreadMax>",
      "minTicketSize":"<TicketSizeMin>",
      "maxTicketSize":"<TicketSizeMax>",
      "minResidualTenor":"<TenorMin>",
      "maxResidualTenor":"<TenorMax>",
      "transferTypes":[],
      "marketType":"ANY",
      "security":"ANY",
      "seniority":[],
      "greenLoan":"ANY",
      "exportCreditAgency":"ANY",
      "parentCountries":[],
      "investorType":[],
      "filterCompanies":[],
      "directInvitations":[]}
      """
    And method post
    And def IOIID = get[0] response..buyInterestId
    * print '----------IOIID------------->'+IOIID
    Examples:
      | read('IOI.csv') |

  @IOI_forthedemo
  Scenario: IOICreation Count Validation
    * def GetTableCount =
      """
      function()
      {
         var DataStorage = Java.type('Ilex.utils.DbUtils');
         var dS = new DataStorage();
         return dS.GetTableCount();
      }
      """
    * def temp = GetTableCount()
    * print 'Count After Creating IOI----------------->', temp
    * assert temp == '11'

#@IOI
#Scenario Outline: Create IOI and Get IOI
  #Given param action = '<Status>'
  #When request {   "name": <IOIName>,"goodUntil":<IOIExpiry>,"borrowers": [],"industries": [<industryId1>,<industryId2>],"countriesOfRisk": [<RiskCountry1>,<RiskCountry2>],"purposes": [<purpose1>,<purpose2>],"facilitiesType": [<Facilitytype1>,<Facilitytype2>],"minSpread": <SpreadMin>,"maxSpread": <SpreadMax>,"minResidualTenor": <TenorMin>,"maxResidualTenor": <TenorMax>,"minTicketSize": <TicketSizeMin>,"maxTicketSize": <TicketSizeMax>,"currencies": ["<Currency1>","<Currency2>"],"transferTypes": [<TransferType1>,<TransferType2>],"seniority": <Seniority>,"marketType": <marketType>,"security": <security>,"greenLoan": <greenLoan>,"exportCreditAgency": <CreditAgency>,"parentCountries": ["<parentCountries1code>","<parentCountries2code>"],"investorType": [<InvestorType1>,<InvestorType2>],"filterCompanies": [{"companyId": 1}],"directContacts": [],"directGroups":[]}
  #And method post
  #And status <PostExpectedHttpStatus>
  #And def IOIID = karate.jsonPath(response,"$..buyInterestId")
  #* print 'Created IOI ID from Post----------------->',IOIID
  #Then path IOIID
  #And method get
  #* print 'IOI ID In Get----------------->',karate.jsonPath(response,"$..buyInterestId")
  #* match karate.jsonPath(response,"$..buyInterestId") == IOIID
  #Then match response contains {"buyInterestId":'#number',"name":<IOIName>,"goodUntil":<IOIExpiry>,"status":<Status>,"borrowers":[],"industries": [<industryId2>,<industryId1>],"countriesOfRisk": [<RiskCountry1>,<RiskCountry2>],"purposes":[<purpose1>,<purpose2>],"facilitiesType":[<Facilitytype1>,<Facilitytype2>],"minSpread": '<SpreadMin>',"maxSpread": '<SpreadMax>',"minResidualTenor": '<TenorMin>',"maxResidualTenor": '<TenorMax>',"minTicketSize": '<TicketSizeMin>',"maxTicketSize": '<TicketSizeMax>',"currencies": ["<Currency1>","<Currency2>"],"transferTypes":[<TransferType1>,<TransferType2>],"seniority": <Seniority>,"marketType": <marketType>,"security": <security>,"greenLoan": <greenLoan>,"exportCreditAgency": <CreditAgency>,"parentCountries": ["<parentCountries1code>","<parentCountries2code>"],"investorType":[<InvestorType1>,<InvestorType2>],"filterCompanies":[{"companyId":1,"name":ABC Financial Leasing Co Ltd}],"directContacts":[],"directGroups":[]}
  #And status <GetExpectedHttpStatus>
#
  #Examples:
    #| read('IOI.csv') |

#@IOI
#Scenario Outline: Create IOI ,Put, Get IOI
  #Given param action = '<Status>'
  #When request {   "name": <IOIName>,"goodUntil":<IOIExpiry>,"borrowers": [],"industries": [<industryId1>,<industryId2>],"countriesOfRisk": [<RiskCountry1>,<RiskCountry2>],"purposes": [<purpose1>,<purpose2>],"facilitiesType": [<Facilitytype1>,<Facilitytype2>],"minSpread": <SpreadMin>,"maxSpread": <SpreadMax>,"minResidualTenor": <TenorMin>,"maxResidualTenor": <TenorMax>,"minTicketSize": <TicketSizeMin>,"maxTicketSize": <TicketSizeMax>,"currencies": ["<Currency1>","<Currency2>"],"transferTypes": [<TransferType1>,<TransferType2>],"seniority": <Seniority>,"marketType": <marketType>,"security": <security>,"greenLoan": <greenLoan>,"exportCreditAgency": <CreditAgency>,"parentCountries": ["<parentCountries1code>","<parentCountries2code>"],"investorType": [<InvestorType1>,<InvestorType2>],"filterCompanies": [{"companyId": 1}],"directContacts": [],"directGroups":[]}
  #And method post
  #And status <PostExpectedHttpStatus>
  #And def IOIID = response.buyInterestId
  #* print 'Created IOI ID from Post----------------->',IOIID
  #Then path IOIID
  #And param action = '<Status>'
  #Then match response contains {"buyInterestId":'#number',"name":<IOIName>,"goodUntil":<IOIExpiry>,"status":<Status>,"borrowers":[],"industries": [<industryId2>,<industryId1>],"countriesOfRisk": [<RiskCountry1>,<RiskCountry2>],"purposes":[<purpose1>,<purpose2>],"facilitiesType":[<Facilitytype1>,<Facilitytype2>],"minSpread": '<SpreadMin>',"maxSpread": '<SpreadMax>',"minResidualTenor": '<TenorMin>',"maxResidualTenor": '<TenorMax>',"minTicketSize": '<TicketSizeMin>',"maxTicketSize": '<TicketSizeMax>',"currencies": ["<Currency1>","<Currency2>"],"transferTypes":[<TransferType1>,<TransferType2>],"seniority": <Seniority>,"marketType": <marketType>,"security": <security>,"greenLoan": <greenLoan>,"exportCreditAgency": <CreditAgency>,"parentCountries": ["<parentCountries1code>","<parentCountries2code>"],"investorType":[<InvestorType1>,<InvestorType2>],"filterCompanies":[{"companyId":1,"name":null}],"directContacts":[],"directGroups":[]}
  #And param action = '<Status>'
  #And request {"buyInterestId":0,"name":<IOINewName>,"goodUntil":<IOIExpiry>,"status":<Status>,"borrowers":[],"industries": [<industryId2>,<industryId1>],"countriesOfRisk": [<RiskCountry1>,<RiskCountry2>],"purposes":[<purpose1>,<purpose2>],"facilitiesType":[<Facilitytype1>,<Facilitytype2>],"minSpread": '<SpreadMin>',"maxSpread": '<SpreadMax>',"minResidualTenor": '<TenorMin>',"maxResidualTenor": '<TenorMax>',"minTicketSize": '<TicketSizeMin>',"maxTicketSize": '<TicketSizeMax>',"currencies": ["<Currency1>","<Currency2>"],"transferTypes":[<TransferType1>,<TransferType2>],"seniority": <Seniority>,"marketType": <marketType>,"security": <security>,"greenLoan": <greenLoan>,"exportCreditAgency": <CreditAgency>,"parentCountries": ["<parentCountries1code>","<parentCountries2code>"],"investorType":[<InvestorType1>,<InvestorType2>],"filterCompanies":[{"companyId":1,"name":null}],"directContacts":[],"directGroups":[]}
  #And method put
  #And status <PutExpectedHttpStatus>
  #Then match response contains {"buyInterestId":'#number',"name":<IOINewName>,"goodUntil":<IOIExpiry>,"status":<Status>,"borrowers":[],"industries": [<industryId2>,<industryId1>],"countriesOfRisk": [<RiskCountry1>,<RiskCountry2>],"purposes":[<purpose1>,<purpose2>],"facilitiesType":[<Facilitytype1>,<Facilitytype2>],"minSpread": '<SpreadMin>',"maxSpread": '<SpreadMax>',"minResidualTenor": '<TenorMin>',"maxResidualTenor": '<TenorMax>',"minTicketSize": '<TicketSizeMin>',"maxTicketSize": '<TicketSizeMax>',"currencies": ["<Currency1>","<Currency2>"],"transferTypes":[<TransferType1>,<TransferType2>],"seniority": <Seniority>,"marketType": <marketType>,"security": <security>,"greenLoan": <greenLoan>,"exportCreditAgency": <CreditAgency>,"parentCountries": ["<parentCountries1code>","<parentCountries2code>"],"investorType":[<InvestorType1>,<InvestorType2>],"filterCompanies":[{"companyId":1,"name":ABC Financial Leasing Co Ltd}],"directContacts":[],"directGroups":[]}
  #Examples:
    #| read('IOI.csv') |
