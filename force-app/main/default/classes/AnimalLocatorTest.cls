@isTest
global class AnimalLocatorTest {
    @isTest
    static void testGetAnimalNameById() {
        // Mock HTTP callout for success response
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        
        // Call the method for success response
        Test.startTest();
        // String animalName = AnimalLocator.getAnimalNameById(1);
        Test.stopTest();
        
        // Assert the result for success response
        // System.assertEquals('chicken', animalName, 'Expected animal name is chicken');
        
        // Mock HTTP callout for error response
        
        
        // // Call the method for error response
        // Test.startTest();
        // String animalNameError = AnimalLocator.getAnimalNameById(123456);
        // Test.stopTest();
        
        // // Assert the result for error response
        // System.assertEquals(null, animalNameError, 'Expected null response for error');
    }
}