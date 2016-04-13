trigger  ZEBCompetitors_aUPD on Competitors__c (after update) {
    
    set<Id> setCompId = new set<Id>();
    list<Clone_Competitor__c> lstCloneCompetitor = new list<Clone_Competitor__c>();
    
    for(Competitors__c  objCompetitors : trigger.new ){
        setCompId.add(objCompetitors.Id);
    }
    
    lstCloneCompetitor  = [select id,Name,Competitor_Name__c,Competitor_Product__c,End_User_Price__c,Note__c,Reseller_Price__c,Competitors__c from Clone_Competitor__c where Competitors__c in :setCompId ];
    
    for(Competitors__c  objCompetitors :[select id,Name,Competitor_Product__c,End_User_Price__c,Note__c,Reseller_Price__c from Competitors__c where id in :setCompId ])
    {
        for(Clone_Competitor__c objCloneCompetitor : lstCloneCompetitor ){
            if(objCloneCompetitor.Competitors__c == objCompetitors.id ){
                objCloneCompetitor.Name = objCompetitors.Name;
                objCloneCompetitor.Competitor_Name__c = objCompetitors.Name;
                objCloneCompetitor.Competitor_Product__c = objCompetitors.Competitor_Product__c;
                objCloneCompetitor.End_User_Price__c = objCompetitors.End_User_Price__c;
                objCloneCompetitor.Note__c = objCompetitors.Note__c;
                objCloneCompetitor.Reseller_Price__c = objCompetitors.Reseller_Price__c ;
            }
        }
    }
    update lstCloneCompetitor;
}