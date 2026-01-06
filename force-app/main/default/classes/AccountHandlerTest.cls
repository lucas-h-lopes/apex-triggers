@isTest
private class AccountHandlerTest {
  @testSetup
  static void setup() {
    List<Account> accs = createAccounts(3, true);
    List<Contact> contactList = new List<Contact>();

    insert accs;

    for (Integer x = 0; x < accs.size(); x++) {
      contactList.add(new Contact(lastname = 'Contato novo', AccountId = accs.get(x).id));
    }

    insert contactList;
  }

  @isTest
  static void TestTaskCreationWhenAccountInsert() {
    List<Account> testAccs = createAccounts(3, true);

    Database.SaveResult[] result = Database.insert(testAccs, false);

    for (Database.SaveResult sr : result) {
      System.assert(sr.isSuccess(), 'Deverá inserir com sucesso.');
    }

    List<Task> tasks = [SELECT id, whatid, OwnerId, Status, Subject, ActivityDate, Priority FROM Task WHERE whatid IN :testAccs];
    System.assert(tasks.size() == 3);

    for (Task t : tasks) {
      System.assert(t.Subject == 'Call', 'Subject precisa ser igual a \'Call\'.');
      System.assert(t.whatid != null, 'WhatId precisa estar preenchido.');
      System.assert(t.OwnerId == UserInfo.getUserId(), 'OwnerId precisa corresponder ao usuário que executou a ação.');
      System.assert(t.Status == 'In Progress', 'Status precisa ser igual a \'In Progress\'.');
      System.assert(t.ActivityDate == Date.today().addDays(2), 'ActivityDate precisa ser igual a D+2.');
      System.assert(t.Priority == 'Normal', 'Priority precisa ser igual a \'Normal\'.');
    }
  }

  @isTest
  static void TestAccountNoPhoneErrorWhenInsert() {
    List<Account> accList = createAccounts(3, false);

    Database.SaveResult[] result = Database.insert(accList, false);

    for (Database.SaveResult sr : result) {
      System.assert(!sr.isSuccess(), 'Deverá ter ocorrido um erro na inserção.');
      System.assert(sr.getErrors().size() == 1, 'Deverá existir exatamente 1 erro.');
      System.assert(sr.getErrors()[0].getMessage().contains('O telefone é obrigatório.'), 'Erro deverá ser igual a \'O telefone é obrigatório.\'.');
    }
  }

  @isTest
  static void TestAccountWithContactsErrorWhenDelete() {
    List<Account> accs = [
      SELECT id, (SELECT id FROM Contacts)
      FROM Account
      WHERE id IN (SELECT accountid FROM Contact)
    ];

    System.assert(accs.size() > 0, 'Nenhuma conta retornada.');

    Database.DeleteResult[] result = Database.delete(accs, false);

    for (Database.DeleteResult dr : result) {
      System.assert(!dr.isSuccess(), 'O delete deverá ter falhado.');
      System.assert(dr.getErrors().size() == 1, 'Deverá existir somente 1 erro.');
      System.assert(
        dr.getErrors()[0].getMessage().contains('Uma conta com contatos não pode ser excluída. IDs: '),
        'A mensagem de erro deverá conter \'Uma conta com contatos não pode ser excluída. IDs:.'
      );
    }
  }

  private static List<Account> createAccounts(Integer quantity, Boolean hasPhone) {
    List<Account> accToReturn = new List<Account>();
    for (Integer x = 1; x <= quantity; x++) {
      accToReturn.add(new Account(Name = 'Account 123 #' + x, Phone = hasPhone ? ('123' + x) : null));
    }
    return accToReturn;
  }
}
