## apex-triggers

Este repositório tem como objetivo demonstrar o uso de Apex Triggers com delegação de lógica para uma classe handler, seguindo boas práticas básicas da plataforma Salesforce, com foco em bulkification, governor limits, trigger context variables e testes unitários.

## Funcionalidades Implementadas 
#### AccountTrigger
- Trigger associada ao objeto Account, escutando os eventos **before insert**, **after insert** e **before delete**. Age como ponto de entrada, repassando a lógica de negócio para a classe handler.

#### AccountHandler
- Classe Apex que centraliza a lógica de negócio relacionada à Account, disponibilizando os métodos utilizados na trigger:
  - `handleBeforeInsert` Valida se o campo Phone está preenchido, caso não esteja, impede a inserção utilizando addError.
  - `handleAfterInsert`  Cria automaticamente uma Task para cada Account inserida.
  - `handleBeforeDelete` Impede a exclusão de Accounts que possuam Contacts relacionados. O bloqueio é dado via addError, informando os IDs dos contatos associados.

## Testes Unitários 
A classe AccountHandlerTest valida os principais cenários do handler de Account. Os cenários incluem: 
- Inserção de Accounts válidas.
- Erro ao inserir Accounts sem Phone.
- Bloqueio de exclusão de Accounts com Contacts relacionados.

Os testes utilizam @testSetup para criar dados base e executam DML para acionamento da trigger, realizando validação com asserções `System.assert`.
