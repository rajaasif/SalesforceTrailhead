@isTest
public class Test_task_util {
	 @isTest static void testTaskPriority() {
        String pri = task_util.getTaskPriority('NY');
        System.assertEquals('Normal', pri);
    }
}