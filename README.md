<!-- Images Badges -->
[swift-image]: https://img.shields.io/badge/Swift-5.2-orange.svg?style=flat
[xcode-image]: https://img.shields.io/badge/xcode-11.3-orange
[cocoapods-image]: https://img.shields.io/badge/CocoaPods-1.10-orange

<!-- Images -->
[app-running-image]: ./assets/images/app-running.gif
[comics-list-image]: ./assets/images/comics-list.png
[configuration-image]: ./assets/images/configuration.png
[heroes-details-image]: ./assets/images/heroes-details.png
[heroes-list-image]: ./assets/images/heroes-list.png
[home-image]: ./assets/images/home.png
[registration-image]: ./assets/images/registration.png
[unit-tests-image]: ./assets/images/unit-tests-coverage.png
[clean-architecture-image]: ./assets/images/clean-architecture.png
[main-components-image]: ./assets/images/main-components.png
[fastlane-image]: ./assets/images/fastlane.png
[google-analytics-image]: ./assets/images/google-analytics.png

<!-- URLs -->
[xcode-url]: https://developer.apple.com/xcode/
[swift-url]: https://swift.org/
[mac-url]: https://www.apple.com/br/macos/catalina/
[cocoapods-url]: https://cocoapods.org
[firebase-url]: https://firebase.google.com
[firebase-pod-url]: https://firebase.google.com/docs/ios/setup
[alamofire-url]: https://cocoapods.org/pods/Alamofire 
[kingfisher-url]: https://cocoapods.org/pods/Kingfisher
[swiftyjson-url]: https://cocoapods.org/pods/SwiftyJSON
[santander-mobile-coders-url]: https://www.becas-santander.com/pt/program/santander-coders-mobile-2020
[digital-house-url]: https://www.digitalhouse.com/br/
[curso-ios-url]: https://www.digitalhouse.com/br/curso/desenvolvimento-mobile-ios
[marvel-api-url]: https://developer.marvel.com/
[clean-architecture-url]: https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html
[fastlane-url]: https://fastlane.tools/
[android-url]: https://www.android.com/
[ios-url]: https://www.apple.com/ios/ios-14/
[bitrise-url]: https://www.bitrise.io/
[google-analytics-url]: https://firebase.google.com/products-release

# Digital House | Projeto Integrador | Heroes

[![Swift][swift-image]][swift-url]
[![Xcode][xcode-image]][xcode-url]
[![CocoaPods][cocoapods-image]][cocoapods-url]

Projeto Integrador para obter o Certificado de Conclusão do curso de [Desenvolvimento Mobile iOS/Swift][curso-ios-url] pela [Digital House][digital-house-url] em parceria com o [Santander Mobile Coders][santander-mobile-coders-url].

Este projeto utiliza a API da [Marvel][marvel-api-url] como base. Dessa forma, a utilização deve estar em conformidade com os Termos de Uso dela.

# Tópicos

- [Tópicos](#tópicos)
- [Requerimentos](#requerimentos)
  - [Swift](#swift)
  - [Xcode](#xcode)
  - [CocoaPods](#cocoapods)
  - [Fastlane](#fastlane)
  - [macOS](#macos)
- [Descrição](#descrição)
- [Funcionalidades Previstas](#funcionalidades-previstas)
- [Imagens do Projeto](#imagens-do-projeto)
  - [Aplicativo Rodando](#aplicativo-rodando)
  - [Tela Inicial](#tela-inicial)
  - [Cadastro](#cadastro)
  - [Lista de Heróis](#lista-de-heróis)
  - [Detalhes de Herói](#detalhes-de-herói)
  - [Lista de Revistas](#lista-de-revistas)
  - [Configuração](#configuração)
  - [Testes Unitários](#testes-unitários)
  - [Execução do Fastlane](#execução-do-fastlane)
  - [Relatório do Google Analytics](#relatório-do-google-analytics)
- [Requisitos do Projeto](#requisitos-do-projeto)
- [Como Executar o Projeto](#como-executar-o-projeto)
  - [Etapas](#etapas)
- [Estrutura de Arquivos](#estrutura-de-arquivos)
- [Padrões de Projeto](#padrões-de-projeto)
  - [Princípios Utilizados](#princípios-utilizados)
    - [Separation of Concerns](#separation-of-concerns)
    - [Don't Repeat Yourself](#don't-repeat-yourself)
    - [SOLID](#solid)
      - [Single Responsibility Principle](#single-responsibility-principle)
      - [Open/Closed Principle](#open/closed-principle)
      - [Liskov Substitution Principle](#liskov-substitution-principle)
      - [Interface Segregation Principle](#interface-segregation-principle)
      - [Dependency Inversion Principle](#dependency-inversion-principle)
    - [Protocol Oriented Programming](#protocol-oriented-programming)
    - [Refatoração](#refatoração)
  - [Elementos Principais](#elementos-principais)
    - [Model](#model)
    - [View](#view)
    - [ViewModel](#viewmodel)
    - [Service](#service)
    - [Repository](#repository)
    - [Data Access Object](#data-access-object)
    - [ModelParser](#modelparser)

# Requerimentos

Para utilizar a aplicação é necessário atender os seguintes requisitos:

- Swift 5 ou superior
- Xcode 11.3 ou superior
- CocoaPods 1.10 ou superior
- macOS 10.14 (Mojave) ou superior
- RAM 8GB ou superior
- HD 128GB ou superior

## Swift

Swift é uma linguagem de programação orientada a objetos, com tipagem forte e permite o desenvolvimento utilizado múltiplos paradigmas.
Mais informações podem ser obtidas clicando no seguinte link [Swift][swift-url].

## Xcode

É uma Ferramenta de Desenvolvimento Integrado ou IDE na sigla em inglês.
É a ferramenta sugerida pela Apple que é detentora da marca e da linguagem.

Mais informações, clique no link [Xcode][xcode-url].

## CocoaPods

É um gerenciador de dependências para bibliotecas escritas em Objective-C e Swift. É um dos gerenciadores mais populares para Desenvolvimento iOS/Swift, se não, o mais popular.

Para obter mais informações a respeito do CocoaPods, basta clicar neste link: [CocoaPods][cocoapods-url].

As bibliotecas utilizadas até o momento são:

- Firebase
- Alamofire
- Kingfisher
- SwiftyJSON

### Firebase

Firebase é um serviço Serverless para hospedagem de sites estáticos, banco de dados em tempo real, banco de dados offline, autenticação de usuários, entre outros. A empresa responsável pelo [Firebase][firebase-url] é o Google.

A biblioteca utiliza os serviços de autenticação de usuários e banco de dados Firestore.

Para obter mais informações, clique em [pod Firebase][firebase-pod-url].

### Crashlytics and Google Analytics

São serviços do Google integrados ao [Firebase][firebase-url] e permitem monitorar o uso do aplicativo em tempo real, engajamento e aderência do público-alvo, além de acompanhar casos de falhas sistêmicas no dispositivo móvel.

É possível obter mais detalhes no indo clicando [aqui][google-analytics-url].

### Alamofire

Alamofire é uma biblioteca de requisições HTTP para iOS/Swift. É uma das mais utilizadas por desenvolvedores, pois facilita o gerenciamento de requisições HTTP, parsing de JSON, entre outros.

Acaso queira saber mais, clique em [Alamofire][alamofire-url].

### KingFisher

KingFisher é uma biblioteca de carregamento de imagens, caching, entre outras funcionalidades para iOS/Swift.

Cliquem [aqui][kingfisher-url] para saber mais.

### SwiftyJSON

SwiftyJSON é uma biblioteca para serialização e desserialização Swift com foco em parsing de JSON.

Para obter mais informações, clique em [SwiftyJSON][swiftyjson-url].

## Fastlane

É uma ferramenta de automação de testes, deploys, screenshots, entre outros. É uma das mais utilizadas para Desenvolvimento Mobile [iOS][ios-url] e [Android][android-url].

É ideal para projetos de médio e grande porte, já que permite a automação e criação de pipeline de deploys.

Para saber mais detalhes, clique em [Fastlane][fastlane-url].

## Bitrise

É um serviço de computação em nuvem para gerenciamento de pipelines de CD/CI (Continuous Development/Continuous Integration).

Foi utilizado para acompanhar e controlar a evolução de funcionalidades por intermédio de entregas contínuas.

Para obter mais informações e planos disponíveis, por favor, vá ao site do [Bitrise][bitrise-url].

## macOS

É o sistema operacional utilizado para o desenvolvimento de aplicativos mobile iOS.

É possível obter mais informações clicando no seguinte hyperlink [macOS][mac-url].

[Voltar ao menu](#tópicos)

# Descrição

Este projeto visa criar um aplicativo [iOS 13+][ios-url] para aficionados em super-heróis, principalmente da Marvel, onde poderão compartilhar heróis favoritos e revistas, inicialmente.

# Funcionalidades Previstas

As funcionalidades previstas para o projeto são:

- Gereciamento de heróis
- Gerenciamento de revistas
- Compartilhamento de heróis e revistas
- Salvar heróis e revistas como favoritos
- Armazenamento offline
- Login social usando Facebook e Google
- Entre outros

[Voltar ao menu](#tópicos)

# Imagens do Projeto

As imagens abaixo mostram um pouco a respeito do aplicativo em funcionamento.

## Aplicativo Rodando

Amostra do aplicativo em execução.

![Aplicativo em Execução][app-running-image]

[Voltar ao menu](#tópicos)

## Tela Inicial

Tela de início da aplicação. Permite o login social por meio do Facebook e do Google. Além disso, é possível navegar para o cadastro de usuário.

![Tela Inicial][home-image]

[Voltar ao menu](#tópicos)

## Cadastro

Permite o cadastro de usuário por meio de e-mail e senha mediante o aceite dos Termos de Uso.

![Cadastro][registration-image]

[Voltar ao menu](#tópicos)

## Lista de Heróis

Lista de todos os heróis disponíveis. É possível favoritar ou compartilhar, além de busca por termo.

![Lista de Heróis][heroes-list-image]

[Voltar ao menu](#tópicos)

## Detalhes de Herói

Permite visualizar os detalhes do heróis e as revistas relacionadas. É possível favoritá-lo ou compartilhá-lo.

![Detalhes de Herói][heroes-details-image]

[Voltar ao menu](#tópicos)

## Lista de Revistas

Mostra todas as revistas disponíveis. É possível compartilhar, filtrar e favoritar revistas.

![Lista de Revistas][comics-list-image]

[Voltar ao menu](#tópicos)

## Configuração

Permite configurar os dados da conta, tais como: troca de senha exclusão de conta.

![Configuração][configuration-image]

[Voltar ao menu](#tópicos)

## Testes Unitários

Abaixo mostra a cobertura atual dos testes unitários da aplicação.

![Testes Unitários][unit-tests-image]

[Voltar ao menu](#tópicos)

## Execução do Fastlane

A imagem a seguir mostra a execução do Fastlane após uma execução com êxito.

![Fastlane][fastlane-image]

[Voltar ao menu](#tópicos)

## Relatório do Google Analytics

A imagem abaixo é referente ao monitoramento de uso do Google Analytics.

![Google Analytics][google-analytics-image]

[Voltar ao menu](#tópicos)

# Requisitos do Projeto

Para obter o Certificado de Conclusão, é necessário implementar o projeto atendendo os seguintes requisitos:

- <span style="color: green;">&check;</span> Deve possuir um design em todas as telas utilizando auto layout;
- <span style="color: green;">&check;</span> Aplicação do POO.
- <span style="color: green;">&check;</span> Deve possuir navegação entre telas (Navigation e Modal);
- <span style="color: green;">&check;</span> Tratativas de erros;
- <span style="color: green;">&check;</span> Deve consumir uma API;
- <span style="color: green;">&check;</span> Deve funcionar em modo offline;
- <span style="color: green;">&check;</span> A arquitetura deve ser MVVM;
- <span style="color: red;">&cross;</span> O código precisa estar comentado;
- <span style="color: green;">&check;</span> Testes Unitários;
- <span style="color: green;">&check;</span> O app deve conter, pelo menos, os seguintes componentes do UIKit: (UITextField, 
UIButton, UILabel, UICollectionView e UITableView).
- <span style="color: red;">&cross;</span> O app deve possuir as seguintes features:
    - <span style="color: red;">&cross;</span> Tela de carregamento;
    - <span style="color: green;">&check;</span> Tela de login (Facebook e Google são obrigatórios);
    - <span style="color: red;">&cross;</span> Tela inicial que deve conter um resumo das funcionalidades do app;
    - <span style="color: green;">&check;</span> Tela de descrição do item;
    - <span style="color: green;">&check;</span> Tela de listagem de características;
    - <span style="color: green;">&check;</span> Opções para compartilhamento em redes sociais;
- <span style="color: green;">&check;</span> Todo o trabalho deve ser feito utilizando o GitFlow;
- <span style="color: red;">&cross;</span> Ao final, o ReadMe deve estar atualizado com screenshots das telas do app e descrição detalhada das funcionalidades.

[Voltar ao menu](#tópicos)

# Como Executar o Projeto

Para executar o projeto, é necessário realizar algumas etapas para que o projeto possa ser compilado com êxito.

## Etapas

Para começar o projeto, você deve clonar o projeto com o seguinte comando:

```bash
git clone https://github.com/marivaldosena/hero.es.git heroes
```

Com este comando, o git irá criar um diretório chamado *heroes*. Nele, será possível visualizar três arquivos:

- README.md - Descrição do projeto
- assets - Arquivos de apoio, tais como: arquivos JSON, imagens para README, etc
- hero.es - Projeto iOS

No terminal, digite:

```bash
cd hero.es
```

Ao entrar neste diretório, você verá os seguintes arquivos:

- Podfile - Arquivo para configuração e download de bibliotecas do CocoaPods
- hero_es - Bundle do aplicativo móvel a ser executado
- hero_es.xcodeproj - Arquivo de configuração do projeto utilizado pelo Xcode
- hero_esTests - Teste unitários da aplicação

Para iniciar o projeto, digite:

```bash
pod install
```

Os arquivos gerados pelo comando *pod install* são:

- Podfile.lock - Arquivo de bloqueio de versão que serve para otimizar o download e atualização de novas bibliotecas
- Pods - Diretório contendo as bibliotecas do CocoaPods
- hero_es.xcworkspace - Novo arquivo de configuração do espaço de trabalho do Xcode. É este arquivo que deve ser aberto para desenvolvimento

Para executar o projeto, digite:

```bash
open hero_es.xcworkspace
```

[Voltar ao menu](#tópicos)

# Estrutura de Arquivos

O projeto possui uma estrutura de arquivos baseada em funcionalidades gerais. Entre os principais diretórios, podemos citar:

- Main - Este é o Entry Point da aplicação
- Shared - Funcionalidades compartilhadas por toda a aplicação, tais como: DBManager para gerenciar o banco de dados local e UIKitUtils para as relacionadas com a Interface Gráfica
- NomeDaFeature - Funcionalidade que estamos trabalhando
- hero_es.xcdatamodeld - Arquivo do Core Data para persistência de dados local
- AppDelegate.swift - Configuração da aplicação

[Voltar ao menu](#tópicos)

# Padrões de Projeto

Este projeto segue o padrão baseado em [Clean Architecture][clean-architecture-url], ou seja, procura dividir o projeto de acordo com suas responsabilidades. Dessa forma, a parte visual fica separada da lógica de negócios que está separada da que é responsável pelo consumo de APIs externas. Com isso, conseguimos ganhar maior autonomia, já que cada parte está desacoplada da outra.

![Clean Architecture][clean-architecture-image]

## Princípios Utilizados

Os princípios utilizados são diretrizes de como deve ser o desenvolvimento. No entanto, estas diretrizes não detalham como devemos implementar, mas o que devemos ter em mente ao desenvolver.

### Separation of Concerns

Separation of Concerns (SoC) diz respeito a separação das interfaces dentro do projeto, isto é, cada camada é responsável por um papel diferente.

Neste caso, há uma camada apenas para lidar com banco de dados que está separada da camada visual que está apartada das regras de negócio. Este princípio serve para permitir que uma alteração não afete negativamente outra camada.

### Don't Repeat Yourself

Este princípio diz respeito a evitar a duplicação de código, pois é uma má prática de desenvolvimento. Dessa forma, aumentamos a consistência da base de código, já que as alterações serão realizadas em apenas um lugar.

### SOLID

É a diretriz para que o desenvolvimento seja escalável, de fácil manutenção e com melhor reaproveitamento de código. Esta diretriz (acrônimo) contém os princípios que serão detalhados a seguir.

#### Single Responsibility Principle

Este princípio nos diz que devemos fazer que nossas classes e métodos desempenhem apenas uma função e esta função seja bem realizada.

#### Open/Closed Principle

Diz respeito a um funcionalidade (classe e/ou método) que é fechado para alteração, mas aberto para extensão, ou seja, que possa ser especializado por intermédio de polimorfismo e/ou herança.

#### Liskov Substitution Principle

O princípio de Liskov diz respeito a possibilidade de utilizar os sub-tipos, isto é, os tipos especializados de uma classe sem que haja necessidade de alteração da lógica e/ou execução.

O exemplo desta utilização é quando aceitamos uma classe base e podemos utilizar as instâncias de suas sub-classes no lugar dela.

#### Interface Segregation Principle

Concerne a utilização de contratos específicos de execução por intermédio de interfaces que requerem a implementação de poucos métodos. Este princípio permite que classes distintas possam implementar uma mesma interface e manter a consistência da execução, além de permitir a aglutinação de diversas interfaces.

#### Dependency Inversion Principle

Este princípio reforça que devemos trabalhar encima de abstrações e não tipos concretos, ou seja, não precisamos entender os detalhes para utilizar determinada funcionalidade. Dessa forma, podemos alterar a implementação concreta em tempo de execução.

### Protocol Oriented Programming

Protocol Oriented Programming ou Programação Orientada a Protocolos (POP) é um paradigma de programação criado e recomendado pela Apple para o Desenvolvimento iOS com linguagem Swift.

Protocolos e extensões possuem diversas aplicações dentro do mundo iOS. Os principais benefícios são:

- Maior consistência de desenvolvimento, já que devemos atender a um protocolo
- Maior flexibilidade, pois protocolos e extensões podem ser utilizados por classes e structs distintas e não relacionadas
- Facilidade de testes unitários

### Refatoração

Diz respeito a melhoria contínua de código por meio de alterações que visam simplificar e tornar flexível o desenvolvimento.

[Voltar ao menu](#tópicos)

## Elementos Principais

O padrão de desenvolvimento utilizado é o MVVM (Model-View-ViewModel) que permite separar de forma mais eficaz a View do Model.
Este projeto é dividido em alguns elementos principais conforme abaixo.

![Componentes Principais][main-components-image]

### Model

É responsável pela estrutura de dados e representa uma entidade e/ou tipo básico lógico. Ele está no cerne do sistema na camada de Domain e não sabe da existência das outras camadas. No entanto, todas as outras camadas trabalham com o Model como dados básicos.
Neste caso, ele também atua como um DTO (Data Transfer Object).

### View

Representa a parte gráfica da aplicação e é responsável pela interação com o usuário. Não sabe da existência do Model e trabalha com o ViewModel como interface entre ele e os dados que devem ser apresentados na tela.

### ViewModel

É o intermediário entre a View e Model. É responsável pela tradução dos dados recebidos pela View e altera o Model de acordo. Também atua com o tratamento dos dados que devem ser apresentados à View.
Com seu uso é possível facilitar a implementação de testes unitários, já que é um representante fiel do que será apresentado à View.

### Service

Contém as regras de negócios e é responsável pelo consumo de APIs externas, tais como: Rest, bases de dados locais, entre outros.
É possível utilizar um serviço por mais de um ViewModel. Ele também efetua a comunicação entre ViewModels.

### Repository

É responsável pela interface entre service e os DAOs (Data Acess Objects), ou seja, abstrai a comunicação com as bases de dados locais.

### Data Access Object

É o componente responsável pela abstração e persistência de dados em bases locais. É aconselhável utilizar um DAO (Data Access Object) para cada entidade e store (base de dados).

### ModelParser

É responsável pela conversão entre as entidades e models. O ModelParser abstrai a tradução de um JSON, Entity do CoreData ou Realm para o Model e vice-versa. Dessa forma, repositories podem utilizar os Models sem se preocuparem com as implementações de baixo nível.

[Voltar ao menu](#tópicos)
