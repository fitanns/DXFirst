/**
 * Created by DmytroPinchuk on 19.09.2019.
 */

@IsTest
private class LabelUtilityTest {
    @IsTest
    static void testListLabelsOfObject() {
        Test.startTest();
        List<String> accountLabels = LabelUtility.getLabels('Account');
        Test.stopTest();

        System.assertEquals(false, accountLabels.isEmpty());
    }
}