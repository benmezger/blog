+++
title = "Books"
author = ["Ben Mezger"]
date = 2020-04-23T00:00:00-03:00
publishDate = 2020-04-25T00:00:00-03:00
lastmod = 2020-05-30T01:13:31-03:00
categories = ["books"]
type = "docs"
draft = false
[menu.before]
  identifier = "books"
  title = "books"
  weight = 6
  name = "books"
+++

## List {#list}

Reading progress as of <span class="timestamp-wrapper"><span class="timestamp">&lt;2020-05-30 Sat&gt;</span></span>

<div class="table-caption">
  <span class="table-number">Table 1</span>:
  Clock summary at <span class="timestamp-wrapper"><span class="timestamp">[2020-05-30 Sat 00:59]</span></span>
</div>

| Headline                                                             | Time        |         |      |
| -------------------------------------------------------------------- | ----------- | ------- | ---- |
| **Total time**                                                       | **1d 1:05** |         |      |
| &ensp;&ensp;List                                                     |             | 1d 1:05 |      |
| &ensp;&ensp;&ensp;&ensp;The Communist Manifesto                      |             |         | 1:25 |
| &ensp;&ensp;&ensp;&ensp;The Pragmatic Programmer: From&#x2026;       |             |         | 2:48 |
| &ensp;&ensp;&ensp;&ensp;Operating Systems: Internals and&#x2026;     |             |         | 3:24 |
| &ensp;&ensp;&ensp;&ensp;Clean Architecture                           |             |         | 3:28 |
| &ensp;&ensp;&ensp;&ensp;The Great Mental Models: General&#x2026;     |             |         | 5:48 |
| &ensp;&ensp;&ensp;&ensp;Nonviolent Communication: A language&#x2026; |             |         | 8:12 |

### <span class="org-todo todo READING">READING</span> The Communist Manifesto {#the-communist-manifesto}

### <span class="org-todo todo READING">READING</span> The Pragmatic Programmer: From Journeyman to Master {#the-pragmatic-programmer-from-journeyman-to-master}

### <span class="org-todo todo READING">READING</span> Operating Systems: Internals and Design Principles (9th Edition) {#operating-systems-internals-and-design-principles--9th-edition}

#### Exercises {#exercises}

1.1. CPU: Takes care of processing data
Main memory: Volatile memory for storing data and program instructions
Secondary storage: Non-volatile for permantely storing data.
I/O: External peripherals such as USB drive, printer and etc.

1.2. Memory address register (MAR): specifies the memory address for the next
read or write.
Memory buffer register (MBR): contains data to be written to memory or
receives data read from memory.

1.3. Processor-memory: Data may be transferred from processor to memory or from
memory to processor.
Processor-IO: Process may transfer data to I/O module or from I/O module to
processor
Data processing: Processor may perform arithmetic or logical operation
Control: The instruction may specify a different location to fetch the next
instruction from, altering the sequence of execution.

1.4. Interrupts the current execution of the CPU. This allows external
peripherals to process data while the CPU works on something else. When the
data processing is over, the peripheral may trigger an interrupt requesting
CPU attention. A CPU interrupt handler may take care of interrupt or ignore it.

1.5. There are two types of handling interrupts: sequentially or by
priority-policy. In sequential interrupts, if an interrupt happens within the
handler of a current interrupt, the interrupt will be ignored for the moment
by setting a pending interrupt. After it the current interrupt has been
dealt, it then treats the next pending interrupt. Priority-based interrupts
allows one interrupt to be handled by priority. Whiling handling one
interrupt, if another interrupt occurs and the priority is higher than the
current interrupt being dealt, it stores the current context and handles the
higher priority interrupt.

1.6. Cost, speed, size are characteristics that are important

#### Notes {#notes}

<!--list-separator-->

- Program execution

  A program consists of a set of instructions stored in memory. The processor
  fetches one instruction at a time and executes each instruction. The processing
  required for one instruction is called the **instruction cycle**. The instruction
  cycle is composed of three main stages:

  1.  Fetch stage: The process fetches an instruction from memory. Most processor
      hold some type of PC (Program counter) register which points to the next
      instruction in memory. Each time a new instruction has been fetched, the PC
      is incremented to the next instruction. The fetch stage usually consists of the
      following &ldquo;substages&rdquo;
      - Address of PC is copied to the MAR (Memory address register), which either
        stores the memory address from where data will be fetched or the address to
        which data will be sent or stored.

### <span class="org-todo todo READING">READING</span> Clean Architecture {#clean-architecture}

### <span class="org-todo todo NEXT">NEXT</span> Clean Code {#clean-code}

### <span class="org-todo done READ">READ</span> The Great Mental Models: General Thinking Concepts {#the-great-mental-models-general-thinking-concepts}

### <span class="org-todo done READ">READ</span> Nonviolent Communication: A language for life {#nonviolent-communication-a-language-for-life}

## \***\*Mídia\*\*** - Noam Chomsky {#mídia-noam-chomsky}

### Duas concepções diferentes de democracia {#duas-concepções-diferentes-de-democracia}

1.  Uma sociedade democrática é aquela em que o povo dispõe de

condições de participar de maneira significativa na condução de seus
assuntos pessoais e na qual os canais de informação são acessíveis e
livres

1.  O povo deve ser impedido de conduzir seus assuntos pessoais e os

canais de informação devem ser estreita e rigidamente controlados

- Essa é a concepção predominante
- Primeiras revoluções democráticas na Inglaterra do século XVII
  (17) expressam em grande medida esse ponto de vista

### Primeira operação de propaganda governamental {#primeira-operação-de-propaganda-governamental}

#### Governo de [Woodrow Wilson](https://en.wikipedia.org/wiki/Woodrow%5FWilson) {#governo-de-woodrow-wilson}

[[<https://dynalist.io/u/ZQA1dAc7Eut0bwSRwZeMRqQ0>]]

#### Presidente dos Estados Unidos em 1916 {#presidente-dos-estados-unidos-em-1916}

<!--list-separator-->

- Plataforma &ldquo;Paz sem Vitória&rdquo;

   <!--list-separator-->

  - Metade da Primeira Guerra Mundial

### População bastante pacifista e sem motivo algum que justificasse envolvimento em guerra Europeia {#população-bastante-pacifista-e-sem-motivo-algum-que-justificasse-envolvimento-em-guerra-europeia}

### Constituída uma comissão de propaganda governamental {#constituída-uma-comissão-de-propaganda-governamental}

#### [ComissãoCreel](https://en.wikipedia.org/wiki/Committee%5Fon%5FPublic%5FInformation) {#comissãocreel}

<https://dynalist.io/u/7sEyNdz3VqlLWY9GpIypishZ>

<!--list-separator-->

- Committee on Public Information

<!--list-separator-->

- 1917 - 1919

<!--list-separator-->

- Transformou uma população dentro de 6 meses

  Conseguiua dentro de 6 meses transformar uma população pacifista
  em uma população histérica e belicosa que queria destruir tudo que fosse
  alemão

   <!--list-separator-->

  - Efeito importante que levou a outros efeitos

### Após a guerra, forma utilizadas as mesmas técnicas para gerar um Pânico Vermelho {#após-a-guerra-forma-utilizadas-as-mesmas-técnicas-para-gerar-um-pânico-vermelho}

#### Obteve êxito considerável na destruição de sindicatos e na eliminação de problemas perigosos como {#obteve-êxito-considerável-na-destruição-de-sindicatos-e-na-eliminação-de-problemas-perigosos-como}

<!--list-separator-->

- Liberdade de imprensa

<!--list-separator-->

- Liberdade de pensamento político

#### Grande apoio dos lideres empresariais e da mídia {#grande-apoio-dos-lideres-empresariais-e-da-mídia}

<!--list-separator-->

- Ambos organizaram e investiram muito na iniciativa

### Intelectuais progressistas participaram ativamente {#intelectuais-progressistas-participaram-ativamente}

#### Pessoas do circulo de [JohnDewey](https://en.wikipedia.org/wiki/John%5FDewey) {#pessoas-do-circulo-de-johndewey--https-en-dot-wikipedia-dot-org-wiki-john-dewey}

<https://dynalist.io/u/4O4qv1%5Fwmp2T5nHYLMIiMcDD>

## Political thoughts {#political-thoughts}

### Abortion should be legal, safe and rare {#abortion-should-be-legal-safe-and-rare}
