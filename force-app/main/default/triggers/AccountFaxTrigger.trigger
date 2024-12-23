trigger AccountFaxTrigger on Account (before insert, before update) {
    for (Account acc : Trigger.new) {
        if (String.isBlank(acc.Fax)) {
            acc.Fax.addError('Fax field is mandatory. Please provide a fax number.');
        }
    }
}