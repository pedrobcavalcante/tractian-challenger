# Tractian Application

## Descrição

Este projeto é uma aplicação de visualização de árvore para gerenciamento de ativos, que organiza e exibe a hierarquia de ativos de uma empresa, incluindo locais, ativos e componentes. É um sistema robusto para navegação e filtragem de ativos e suas propriedades, como sensores de energia e status crítico.

## Funcionalidades

- **Visualização em Árvore**: Estrutura de árvore dinâmica para representar locais, ativos e componentes.
- **Filtros**:
  - **Busca por Nome**: Permite ao usuário buscar ativos específicos pelo nome.
  - **Filtro por Sensores de Energia**: Exibe apenas ativos com sensores de energia.
  - **Filtro por Status Crítico**: Exibe apenas ativos com status crítico.
  - Quando aplicados, os filtros preservam a hierarquia completa até o ativo filtrado, mantendo os pais visíveis.

## Demonstração

Assista à demonstração do projeto no YouTube: [Clique aqui](https://youtu.be/9_seV0NmoAU)

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

Dado mais tempo, algumas melhorias poderiam ser implementadas:

Otimização de Performance: Melhorias nos filtros para lidar com grandes volumes de dados sem comprometer a performance.
Funcionalidade de Expansão Persistente: Manter a expansão da árvore entre navegações ou atualizações de filtro.
Testes: Cobertura de testes adicionais para garantir a estabilidade e confiabilidade do código.
