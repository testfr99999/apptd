trigger ClosedOpportunityTrigger on Opportunity (after insert, before update) {
	List<Task> taskList = new List<Task>();

    for(Opportunity opp : Trigger.New) {
        if('Closed Won'.equals(opp.StageName)) {
			Task newTask = new Task();

			newTask.Subject = 'Follow Up Test Task';
			newTask.TaskSubtype = 'Task';
			newTask.OwnerId = UserInfo.getUserId();
			newTask.WhatId = opp.Id;
			
            taskList.add(newTask);
        }
    }

	if(taskList.size()>0) {
		insert taskList;
	}
}