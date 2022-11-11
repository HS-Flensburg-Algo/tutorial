---
layout: post
title: "Programmierregeln"
---

1. [Name einer Regel](#name-einer-regel)

2. [VariableDeclarationUsageDistance](#variabledeclarationusagedistance)

<br/>

## Name einer Regel

![Namen finden](images/feedback/linter/checks/check-name.png) 
Die Stil-Anmerkungen des Linters beinhalten neben der kurzen Beschreibung auch Informationen darüber, in welcher Datei der Verstoß gefunden wurde, und vor allem, gegen welche Regel verstoßen wurde.
Im Folgenden gibt es eine Auflistung einiger Regeln, die in den Laboren zum Einsatz kommen.


## `VariableDeclarationUsageDistance`

Diese Regel überprüft den Abstand zwischen der Deklaration einer Variable und ihrer ersten Verwendung.
Hinweis: Variablendeklarationen und -initialisierungen werden bei der Berechnung nicht mitgezählt.

Der Geltungsbereich (engl.: scope) für Variablen sollte möglichst klein gewählt werden, um Nebeneffekte durch z.B. Methodenaufrufe auszuschließen, also letztlich sicherzustellen, dass der zugewiesene Wert sich nicht verändert bis zur Verwendung der Variable.
Wenn es nicht möglich ist, den Abstand zwischen Deklaration und Verwendung zu verringern, kann eine Variable alternativ als [`final`](http://hs-flensburg-algo.github.io/basics.html#final) deklariert werden.
Diese Deklaration verhindert ebenfalls, dass die Variable ungewollt verändert wird.
