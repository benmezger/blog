+++
title = "Mantendo sua privacidade"
author = ["Ben Mezger"]
date = 2016-12-09T19:20:00-02:00
publishDate = 2016-12-11
tags = ["private", "guide", "services"]
categories = ["blog"]
draft = false
+++

> ❗️\*Observação:\* Esse guia provavelmente se encontra defasado

O intuido desse guia manter uma coleção de guias, links e pensamentos sobre a
privacidade e segurança online. Nós temos em foco criar ferramentas
antifascistas, contra regimes autoritários para ajudar comunidades, organizações
e ativistas.

Andamos observando que muitos grupos antifascistas/ativistas, usam ferramentas
como o Facebook, WhatsApp e outros para organizar seus protestos, se comunicar
com amigos e familiares, porém, essas ferramentas de comunicação são apenas uma
arma contra sua privacidade e não estão no seu lado.

No atual governo brasileiro (governo de Michel Temer), muitos protestos estão
acontecendo, e a comunicação entre os manifestantes estão sendo cada vez mais
vigiadas pela polícia/governo brasileiro (também por governos
[externos](https://en.wikipedia.org/wiki/Five%5FEyes)), impossibilitando uma luta \***\*democrática\*\*** e sem interferência externa.

Sabemos que cada vez mais, ativistas estão sendo oprimidos, censurados e
vigiados pelo estado e sua polícia burguesa, com isso, esperamos que essa wiki
ajude você a escapar dessa repressão.

> ❗️\*Observação:\* O trabalho desta pagina ainda está em andamento.❗️

## Introdução {#introdução}

Esta página, tem propósito de apresentar ferramentas de comunicação
criptográfica para manifestantes e grupos se comunicarem sem que o estado,
polícia ou terceiros modifiquem o conteúdo da conversa ou interceptam a conversa
em tempo real.

## Critérios de escolhas {#critérios-de-escolhas}

Existem diferentes meios de comunicação online, porém, os meios de comunicação
oferecidos devem seguir o seguinte critério: 1. O código da ferramenta é _open
source_ (código aberto) e esta disponível para avaliar e corrigir erros. 2. A
criptografia usada é segura e bem testada. 3. Sua aplicação e criptografia
passaram por uma auditoria de segurança. 4. O serviço não salva dados do usuário
em seus servidores (ou salva apenas aqueles necessários para a aplicação
funcionar).

## Chat em tempo real {#chat-em-tempo-real}

- [Signal](https://whispersystems.org/) &#x2013; Android/iOS/Google Chrome

  - Comunicação em grupo ou 1:1.
  - Possibilita verificar a [privacidade](https://whispersystems.org/blog/safety-number-updates/) da sua conversa.
  - Código do protocolo/aplicação se encontra [aqui](https://github.com/whispersystems/).
  - [Auditoria](https://eprint.iacr.org/2016/1013.pdf) do protocolo criptográfico teve bons resultados.
  - Tem suporte para Desktop.
  - Mantem o [mínimo](https://whispersystems.org/bigbrother/eastern-virginia-grand-jury/) possível de informação sobre você nos seus servidores, isto
    é:
    - O dia e hora que você se registrou no serviço.
    - O dia da última vez que você se conectou no serviço deles.
  - Tem suporte para ligação criptográfada.

- [Jabber](https://list.jabber.at/) + OTR/mpOTR &#x2013;
  Linux/BSD/Windows/Android/iOS

  - Comunicação em grupo ou 1:1.
  - Dificil de censurar, pois existem diferentes servidores disponiveis.
  - Para uma comunicação mais segura, use
    [OTR](https://otr.cypherpunks.ca/Protocol-v3-4.1.1.html) ou [mpOTR](https://www.cypherpunks.ca/~iang/pubs/mpotr.pdf) para comunicação em grupo.

    - OTR possibilita verificação de identidade.

  - Possui diferentes [clientes](https://otr.im/clients.html) para diferentes plataformas.

- [Cryptocat](https://crypto.cat/) &#x2013; OSX/Windows/Linux

  - Código da criptografia/aplicação se encontra [aqui](https://github.com/cryptocat/cryptocat)
  - **TODO** ~~Auditoria da criptografia usada foi feita na versão antiga.~~
  - Overview da criptografia pode ser encontrado [aqui](https://crypto.cat/security.html).
  - Usa o protocolo Double Ratchet + forward-secure ratchet.
  - Não suporta (atualmente) conversa em grupo.
  - Necessita apenas de um usuário + senha.

- [Riot](https://riot.im/) &#x2013; Web/Android/iOS
  - Comunicação em grupo ou 1:1.
  - Utiliza o protocolo [matrix](http://matrix.org/).
  - Encriptação _end-to-end_ usando o protocolo [Olm](https://matrix.org/docs/spec/olm.html) e [Megolm](https://matrix.org/docs/spec/megolm.html).
  - Possui clientes para Android, iOS e Web.
  - Permite se comunicar com outros serviços de chat como Slack e IRC.
  - Necessita apenas de um usuário e senha.

## Serviços de email {#serviços-de-email-1}

- [Riseup.net](https://riseup.net) - [sobre](https://riseup.net/en/about-us)
  Um serviço anticapitalista, que oferece diferentes serviços seguros para
  indivíduos ou grupos se comunicarem seguramente.
  - Necessita de dois códigos de convite.
  - Oferece diferentes serviços como lista de email, VPN, Pad (editor de texto)
    e outros.
  - Mantém [transparência](https://riseup.net/en/canary) com seus usuários e depende de doações para manter o
    serviço no ar.
  - Seus [princípios políticos](https://riseup.net/en/about-us/politics) incluem igualdade, democracia, paz,
    interdependência e outros.
  - Mantem uma [lista](https://riseup.net/en/about-us/projects) de projetos que ele trabalha.

## Anonimato/privacidade online {#anonimatoprivacidade-online}

- Use o [Tor](https://www.torproject.org/) para navegar na Internet com segurança e privacidade.
  - Como o Tor
    [funciona](https://www.torproject.org/about/overview.html.en).
  - [Especificações](https://www.torproject.org/docs/documentation.html.en#DesignDoc)(técnicas) de como o Tor funciona.
  - [7 coisas](https://www.eff.org/deeplinks/2014/07/7-things-you-should-know-about-tor) que você deve saber sobre o Tor.
  - [Tor e HTTPS](https://www.eff.org/pages/tor-and-https).
  - Uma [apresentação](https://www.youtube.com/watch?v=eQ2OZKitRwc) de como algumas pessoas foram pegas usando o Tor.

---
