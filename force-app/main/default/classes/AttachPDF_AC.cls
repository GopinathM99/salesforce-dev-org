public with sharing class AttachPDF_AC implements Queueable, Database.AllowsCallouts {
    Set<Id> accountIdSet = new Set<Id>();

    public AttachPDF_AC(Set<Id> accountIdSet) {
        this.accountIdSet.addAll(accountIdSet);
    }

    public void execute(QueueableContext context){
        PageReference pdfPage;

        Attachment attachmentPDF;
        List<Attachment> attachmentPDFList = new List<Attachment>();

        for(Id accId: accountIdSet){
            pdfPage = Page.AttachPDF_VF;
            pdfPage.getParameters().put('Id', accId);
            Blob pdf = pdfPage.getContentAsPdf();
            attachmentPDF = new Attachment();
            attachmentPDF.parentId = accId;
            attachmentPDF.Name = accId + '.pdf';
            attachmentPDF.body = pdf;
            attachmentPDFList.add(attachmentPDF);
        }

        if(attachmentPDFList.size() > 0){
            try {
                insert attachmentPDFList;
            }
            catch(Exception e){
                system.debug('exception occured' + e.getMessage());
            }
        }
        
    }
}