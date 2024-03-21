public class SalaryTaskHandler {
    public static void beforeinserthandler(List<Salary__c> newsalaries) {
        List<Id> contactIds = new List<Id>();
        Set<String> selectedYears = new Set<String>();
        Map<Id, Decimal> contactTotalPreviousSalaryMap = new Map<Id, Decimal>();
        
        for(Salary__c salary : newsalaries) {
            contactIds.add(salary.Contact__c);
            selectedYears.add(salary.Select_Year__c);
        }
        
        List<AggregateResult> sums = [SELECT Contact__c, Select_Year__c, SUM(Monthly_Salary__c) totalPreviousSalary 
                                      FROM Salary__c 
                                      WHERE Select_Year__c IN :selectedYears AND Contact__c IN :contactIds 
                                      GROUP BY Contact__c, Select_Year__c];
                                      
        for(AggregateResult result : sums) {
            contactTotalPreviousSalaryMap.put((Id)result.get('Contact__c'), (Decimal)result.get('totalPreviousSalary'));
        }
        List<String> months = new List<String>{ 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec','jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'};
        for(Salary__c salary : newsalaries) {
            Decimal totalYearlySalary;
            Integer remMonths = 12 - months.indexOf(salary.select_month__c);
            Decimal expectedSalary = salary.Monthly_Salary__c * remMonths;
            if(contactIds.contains(salary.Contact__c)) {
                if(contactTotalPreviousSalaryMap.isEmpty()){
                    totalYearlySalary = expectedSalary;
                }  
                else{
                    totalYearlySalary = contactTotalPreviousSalaryMap.get(salary.Contact__c) + expectedSalary;
                } 

                salary.tax_applied__c = calculateTax(totalYearlySalary, remMonths, expectedSalary);
                salary.Salary_To_be_paid__c = salary.Monthly_Salary__c - salary.tax_applied__c;
            }
        }
    }

    public static Decimal calculateTax(Decimal yearlySalary, Integer remMonths, Decimal expectedSalary) {
        Decimal taxApplied = 0;
        
        if(yearlySalary <= 600000) {
            taxApplied = 0;
        } else if(yearlySalary <= 1200000) {
            taxApplied = (expectedSalary * 0.025) / remMonths;
        } else if(yearlySalary <= 2400000) {
            taxApplied = ((expectedSalary * 0.125) + 15000) / remMonths;
        } else if(yearlySalary <= 3600000) {
            taxApplied = ((expectedSalary * 0.225) + 165000) / remMonths;
        } else if(yearlySalary <= 6000000) {
            taxApplied = ((expectedSalary * 0.275) + 435000) / remMonths;
        } else {
            taxApplied = ((expectedSalary * 0.35) + 1095000) / remMonths;
        }
        
        return taxApplied;
    }
}
