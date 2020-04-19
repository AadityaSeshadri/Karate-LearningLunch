function() {    
   var config = {
    baseUrl: 'http://ilex-test-fe-lb-317145507.ap-southeast-1.elb.amazonaws.com',
    //baseUrl: 'http://localhost:8080',
    contact: '/api/v1/usernetworks/contacts/',
    group: '/api/v1/usernetworks/groups',
    IOI:'/api/trade/v1/buyinterests/',
    SEC:'/api/trade/v1/sellorder/',
    Listing:'/api/trade/v1/listings',
    GetResponseCode: '200',
    PostResponseCode: '201',
    PutResponseCode: '200',
    DeleteResponseCode: '200',
    ActivateTranche: '/api/v1/tranches/activate/',
    DeActivateTranche: '/api/v1/tranches/deactivate/',
    SearchActiveTrench: '/api/v1/tranches/search'
};
   return config;
}


