# Projeto Integrador – Aplicação Mobile para Gerenciamento de Recarga Veicular

## Sobre o projeto

Este projeto consiste em uma aplicação mobile desenvolvida em Flutter para gerenciamento de eletropostos da UFSM de recarga de veículos elétricos.

O sistema realiza:

* Cadastro e autenticação de usuários
* Login com Google
* Gerenciamento de veículos
* Visualização de carregadores e conectores
* Controle de transações de recarga
* Integração com Mercado Pago
* Comunicação em tempo real via WebSocket
* Leitura de QR Code para identificação de carregadores
* Integração com backend responsável pela comunicação com carregadores via OCPP

O aplicativo foi desenvolvido para funcionar em conjunto com um backend integrado ao sistema OCPP. Também foi utilizado um emulador, visto que os carregadores físicos estão desativados. Os códigos do servidor OCPP e do emulador foram desenvolvidos separadamente por terceiros, externamente à disciplina de Projeto Integrador.

---

## Tecnologias utilizadas

* Flutter
* Dart
* REST API
* WebSocket
* JWT
* Mercado Pago
* Google Sign-In
* Mobile Scanner

---

## Arquitetura do sistema

O projeto segue uma arquitetura baseada em:

* Screens
* Controllers
* Services
* DTOs
* Comunicação REST
* Comunicação em tempo real via WebSocket


---

## Integração com backend e OCPP

Este aplicativo depende da comunicação com um backend externo integrado a um servidor OCPP.

Os códigos do servidor OCPP e do emulador não fazem parte deste repositório e foram desenvolvidos separadamente.

A integração é utilizada para:

* Receber status dos carregadores
* Atualizar estado dos conectores
* Iniciar recargas remotamente
* Sincronizar transações
* Atualizar informações em tempo real
* Monitorar sessões de recarga ativas
