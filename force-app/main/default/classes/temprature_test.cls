@isTest
public class temprature_test {
    @isTest static void testTaskPriority() {
        String pri = Temperature_Converter.getTaskPriority('NY');
        System.assertEquals('Normal', pri);
    }
}