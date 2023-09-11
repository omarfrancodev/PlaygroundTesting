@IsTest
private class AccountWrapperTests {
  @TestSetup
  static void loadTestData() {
    // GIVEN
    Account acct1 = new Account(Name = 'ACME');
    Account acct2 = new Account(Name = 'TEST');
    insert acct1;
    insert acct2;
    List<Opportunity> opps1 = TestFactory.generateOppsForAccount(
      acct1.id,
      1000.00,
      5
    );
    List<Opportunity> opps2 = TestFactory.generateOppsForAccount(
      acct2.id,
      110000.00,
      10
    );
    insert opps1;
    insert opps2;
  }
  @IsTest
  static void testPositiveRoundedAveragePrice() {
    // WHEN
    Account acct = [SELECT Id FROM Account LIMIT 1];
    AccountWrapper acctWrapper = new AccountWrapper(acct);
    // THEN
    Test.startTest();
    Assert.areEqual(
      1000.00,
      acctWrapper.getRoundedAvgPriceOfOpps(),
      'Expected to get 1000.00'
    );
    Test.stopTest();
  }
  @IsTest
  static void isHighPriority() {
    List<Account> accts = [SELECT Id FROM Account LIMIT 2];
    AccountWrapper acctWrapper1 = new AccountWrapper(accts[0]);
    AccountWrapper acctWrapper2 = new AccountWrapper(accts[1]);
    Test.startTest();
    Assert.areEqual(false, acctWrapper1.isHighPriority(), 'Expected to be false');
    Assert.areEqual(true, acctWrapper2.isHighPriority(), 'Expected to be true');
    Test.stopTest();
  }
}
