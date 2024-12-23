trigger changeShippingAddress on Account (before insert) {

    for(Account acc: Trigger.new){
        if(acc.BillingStreet != null){
            acc.ShippingStreet = acc.BillingStreet;
        }
        if(acc.BillingCity != null){
            acc.ShippingCity = acc.BillingCity;
        }
        if(acc.BillingState != null){
            acc.ShippingState = acc.BillingState;
        }
        if(acc.BillingPostalCode != null){
            acc.ShippingPostalCode = acc.BillingPostalCode;
        }
        if(acc.BillingCountry != null){
            acc.ShippingCountry = acc.BillingCountry;
        }
    }
}