@isTest
public class TaskTriggerHelperTest {

    @isTest(seeAllData=true)
    static void testAfterInsertReviewCommsPauseTask() {
        // Get test user
        User testUser = [SELECT Id, Email FROM User LIMIT 1];

        // Create a Task with the expected subject
        Task t = new Task(
            OwnerId = testUser.Id,
            Subject = 'Review Communications Pause',
            ActivityDate = Date.today() + 2
        );
        insert t;

        // Prepare map like a trigger would provide
        Map<Id, Task> newMap = new Map<Id, Task>{ t.Id => t };

        Test.startTest();
            TaskTriggerHelper.afterInsert(newMap, new Map<Id, Task>());
        Test.stopTest();

        // Assert something to confirm flow reached (e.g., Task inserted)
        Task insertedTask = [SELECT Id, Subject FROM Task WHERE Id = :t.Id];
    }
}