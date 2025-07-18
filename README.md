# Tractian Application

## Descrição

Este projeto é uma aplicação Flutter para visualização e gerenciamento de ativos industriais em estrutura de árvore, seguindo rigorosamente os princípios de Clean Architecture e SOLID. O sistema foi desenhado para ser altamente performático, modular, testável e fácil de manter, atendendo cenários reais de grandes indústrias.

### Principais Diferenciais Técnicos

- **Arquitetura Limpa e Modular**: O projeto está dividido em camadas bem definidas (Domain, Data, Presentation, Infrastructure), facilitando a manutenção, testes e evolução do sistema.
- **Gerenciamento de Estado com GetX**: Utiliza GetX para controle reativo e injeção de dependências, garantindo performance e simplicidade na atualização da UI.
- **Árvore de Ativos Otimizada**: A montagem e filtragem da árvore de ativos é feita de forma eficiente, com preservação do estado de expansão dos nós e uso de cache LRU e persistente para acelerar buscas e filtros.
- **Filtros Hierárquicos Inteligentes**: Os filtros aplicados (nome, energia, crítico, operacional) preservam a hierarquia, exibindo pais e filhos relevantes conforme as regras de negócio.
- **Internacionalização**: Textos e mensagens do app são internacionalizados, facilitando a adaptação para múltiplos idiomas.
- **Performance e Escalabilidade**: Uso de Isolates para processamento pesado, debounce para buscas e otimizações visuais para evitar sobrecarga da UI.
- **Testabilidade**: O código é altamente testável, com separação de responsabilidades e fácil mock de dependências. Os testes seguem o padrão BDD (Dado/Quando/Então).
- **Componentização e Reutilização**: Widgets e serviços são altamente reutilizáveis, evitando duplicidade de código e facilitando a evolução do sistema.
- **Documentação e Logs**: O projeto conta com documentação clara e logs detalhados para facilitar debugging e onboarding de novos desenvolvedores.

### Casos de Uso Atendidos

- Visualização de toda a hierarquia de ativos, locais e componentes de uma empresa.
- Busca e filtragem rápida de ativos por nome, status ou tipo de sensor.
- Preservação do estado visual da árvore mesmo após filtros ou navegação.
- Suporte a múltiplas empresas e grandes volumes de dados.

Este projeto é um exemplo robusto de aplicação Flutter corporativa, pronto para ser expandido e integrado a sistemas industriais reais.

## Funcionalidades

- **Visualização em Árvore**: Estrutura de árvore dinâmica para representar locais, ativos e componentes.
- **Filtros**:
  - **Busca por Nome**: Permite ao usuário buscar ativos específicos pelo nome.
  - **Filtro por Sensores de Energia**: Exibe apenas ativos com sensores de energia.
  - **Filtro por Status Crítico**: Exibe apenas ativos com status crítico.
  - Quando aplicados, os filtros preservam a hierarquia completa até o ativo filtrado, mantendo os pais visíveis.

## Demonstração em Vídeo

Assista à demonstração do projeto no YouTube:
- [Demonstração: Abrindo o app para cada empresa e selecionando filtros](https://youtu.be/9_seV0NmoAU)

O vídeo mostra:
- Abertura do app para diferentes empresas
- Seleção de filtros (nome, energia, crítico, operacional)
- Visualização da árvore de ativos e hierarquia dinâmica

## Endpoints de API

A aplicação se comunica com uma API para obter os dados necessários sobre empresas, localizações e ativos:

- **GET** `/companies` - Retorna todas as empresas
- **GET** `/companies/:companyId/locations` - Retorna todas as localizações de uma empresa
- **GET** `/companies/:companyId/assets` - Retorna todos os ativos de uma empresa

## Estrutura do Projeto

A estrutura do projeto foi organizada seguindo o padrão **Clean Architecture** e os princípios **SOLID**, garantindo separação de responsabilidades, fácil manutenção e testes. Abaixo está um resumo das principais camadas e diretórios:

- **Domain**: Contém entidades, enums e use cases.
- **Data**: Contém modelos, repositórios e fontes de dados.
- **Presentation**: Widgets, controllers e páginas de UI.
- **Infrastructure**: Configurações de rede e outras integrações externas.

## Como Executar o Projeto

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/asset-management-tree-view.git
   ```
2. Instale as dependências:

   ```bash
   flutter pub get
   ```

3. Execute o projeto:

   ```bash
   flutter run
   ```

## Possíveis Melhorias

Se eu tivesse mais tempo, melhoraria os seguintes pontos do projeto:

- **Otimização de Performance**: Refino dos algoritmos de filtragem e renderização para suportar grandes volumes de dados sem perda de performance, incluindo uso de Isolates e cache mais inteligente.
- **Persistência do Estado de Expansão**: Manter o estado de expansão dos nós da árvore mesmo após navegação, atualização de filtros ou reinício do app.
- **Testes Automatizados**: Aumentar a cobertura de testes unitários e de integração, especialmente para os fluxos de filtragem e montagem da árvore.
- **UX e Feedback Visual**: Adicionar feedback visual durante carregamento e aplicação de filtros, além de animações mais suaves.
- **Internacionalização Completa**: Expandir a tradução para todos os textos e mensagens do app.
- **Aprimoramento da Arquitetura**: Modularizar ainda mais os widgets e controllers, e aplicar padrões de injeção de dependência para facilitar manutenção e testes.
- **Documentação Técnica**: Detalhar ainda mais a documentação de arquitetura, decisões técnicas e exemplos de uso da API.
