---
layout: post
title: "Regeln"
---

1. [Bezeichner einer Regel](#bezeichner-einer-regel)

2. [Erklärungen zu Auswahl an Regeln](#erklrungen-zu-auswahl-an-regeln)
   1. [VariableDeclarationUsageDistance](#variabledeclarationusagedistance)

<br/>

## Bezeichner einer Regel

![Bezeichner finden](images/feedback/linter/checks/check-name.png) 
Die Stil-Anmerkungen des Linters beinhalten neben der kurzen Beschreibung auch Informationen darüber, in welcher Datei
der Verstoß gefunden wurde, und vor allem, gegen welche Regel verstoßen wurde. Im Folgenden gibt es eine Auflistung der
Regeln, die am häufigsten zu Verständnisproblemen geführt haben.

## Erklärungen zu Regeln

### VariableDeclarationUsageDistance

überprüft den Abstand zwischen der Deklaration einer Variablen und ihrer ersten Verwendung.
Notiz: Variablendeklarationen und -initialisierungen werden bei der Berechnung nicht mitgezählt.

Der Geltungsbereich (engl.: scope) für Variablen sollte möglichst klein gewählt werden, um Nebeneffekte durch z.B.
Methodenaufrufe auszuschließen, also letztlich sicherzustellen, dass der zugewiesene Wert sich nicht verändert bis zur
Verwendung der Variablen. Eine Alternative ist es dabei, die Variable als `final`
([siehe Skript](hs-flensburg-algo.github.io/basics.html)) zu deklarieren, wenn ein größerer Abstand von Deklaration zu
Verwendung vonnöten ist.
