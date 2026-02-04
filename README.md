# salesforce-core

O **salesforce-core** é um repositório voltado para aprendizado prático em Salesforce, servindo como um ambiente de estudo contínuo, onde conceitos fundamentais da plataforma são aplicados de forma estruturada e seguindo boas práticas de desenvolvimento.

## Conteúdo
### Apex ⚙️

- Triggers seguindo boas práticas de Trigger Handler Pattern
- Classes Apex para:
  - Regras de negócio
  - Orquestração de lógica
  - Callouts
     - Permission set `Grant Fruityvice Integration Access` para conceder acesso as classes Apex necessárias
     - Named Credential `Fruityvice NC` para alterar o endpoint entre ambientes sem precisar editar o Apex 
- Código bulk-safe, legível e testável
- Classes de teste que não dependem do estado atual da Org

### Lightning Web Components (LWC) 🏔️

- Comunicação com Apex por meio de `@wire` e Apex Imperativo
- Tratamento de erros durante o processamento de dados
- Envio de eventos customizados para comunicação entre componente filho <- componente pai
- Uso de um componente pai orquestrador (c-fruityvice) para gerenciar a exibição dos filhos por meio de uma lógica de etapas

## Visualização do projeto 🧑🏻‍🔬


https://github.com/user-attachments/assets/22d6c0b6-6c90-4d93-b0ce-60152c3a10a9


## Testes 

### Apex ⚙️
- Classe de serviço (callout) com 100% de cobertura
- Validação de regras de negócio e cobertura de edge cases

### LWC 🏔️
- c-load-fruits com 100% de cobertura
  - Validação dos eventos lançados pelo JavaScript
  - Mock da classe Apex @wire
  - Visualização condicional do c-error-panel
- Testes dos demais componentes ainda em desenvolvimento ⌛
