---
layout: post
title: "Regeln"
---

1. [Bezeichner einer Regel](#bezeichner-einer-regel)

2. [Erklärungen zu Auswahl an Regeln](#erklrungen-zu-auswahl-an-regeln)
   1. [VariableDeclarationUsageDistance](#variabledeclarationusagedistance)

<br/>

## Bezeichner einer Regel

-bild-folgt-  
Die Stil-Anmerkungen des Linters beinhalten neben der kurzen Beschreibung auch Informationen darüber, in welcher Datei
der Verstoß gefunden wurde, und vor allem, gegen welche Regel verstoßen wurde. Im Folgenden gibt es eine Auflistung der
Regeln, die am häufigsten zu Verständnisproblemen geführt haben.

## Erklärungen zu Auswahl an Regeln

### VariableDeclarationUsageDistance

#### offizielle Beschreibung aus Checkstyle

Checks the distance between declaration of variable and its first usage. Note : Variable declaration/initialization
statements are not counted while calculating length.

#### Hintergrund

Der Geltungsbereich (engl.: scope) für Variablen sollte möglichst klein gewählt werden, um Nebeneffekte durch z.B.
Methodenaufrufe auszuschließen, also letztlich sicherzustellen, dass der zugewiesene Wert sich nicht verändert bis zur
Verwendung der Variablen. Eine Alternative ist es dabei, die Variable als `final` zu deklarieren, wenn ein größerer
Abstand von Deklaration zu Verwendung vonnöten ist.

#### final?

`final` ist in Java ein Modifikator, der Einfluss auf die Änderungsmöglichkeiten eines Elements hat.
Als `final` deklarierte Variablen (lokale als auch Instanz-) sind nach der Initialisierung nicht mehr änderbar.
Weitere Elemente, die diesen Modifikator erhalten können, sind:
- Klassen: Unterbindung der Ableitbarkeit der finalen Klassen
- Methoden: können in abgeleiteten Klassen nicht überschrieben werden
- Methodenparameter: analog zu Variablen, nach der Übergabe an Methode nicht mehr veränderbar