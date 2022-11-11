---
layout: post
title: "Programmierregeln"
---

1. [Name einer Regel](#name-einer-regel)

2. [Regeln](#regeln)

   1. [`AvoidLoopBreak`](#avoidloopbreak)

   2. [`LocalTypeInference`](#localtypeinference)

   3. [`ThisConsistency`](#thisconsistency)

   4. [`VariableDeclarationUsageDistance`](#variabledeclarationusagedistance)


<br/>

## Name einer Regel

![Namen finden](images/feedback/linter/checks/check-name.png) 
Die Stil-Anmerkungen des Linters beinhalten neben der kurzen Beschreibung auch Informationen darüber, in welcher Datei der Verstoß gefunden wurde, und vor allem, gegen welche Regel verstoßen wurde.
Im Folgenden gibt es eine Auflistung einiger Regeln, die in den Laboren zum Einsatz kommen.


## Regeln

Bei Programmierregeln gibt es keine Kategorien wie richtig und falsch.
Man kann auch gute Programme schreiben, die sich nicht an die folgenden Regeln halten.
Außerdem hängt die Lesbarkeit von Programmen auch sehr von der Erfahrung der Lesenden ab.
Viele dieser Regeln sorgen aber dafür, dass die Programme eine einfachere Struktur erhalten.
Am Ende sollen die Regeln auch dafür sorgen, dass Programmierer*innen sich bewusst werden, dass es verschiedene Möglichkeiten gibt, ein Programm zu schreiben und man beim Programmieren reflektieren sollte, welche der Möglichkeiten am besten geeignet ist, um ein gut lesbares und wartbares Programm zu schreiben.
Grundsätzlich sollte man immer Konsistenz anstreben.
Das heißt, wenn es zweimal eine ähnliche Methode gibt, sollten diese auch ähnlich implementiert sein.
Wenn man dagegen bei einer der Methoden eine andere Implementierung wählt, erwarten Lesende, dass dieser Unterschied einen inhaltichen Grund hat.


### `AvoidLoopBreak`

Diese Regel verbietet die Verwendung von `return` und `break` zum Beenden einer Schleife.
Hier soll kurz dargestellt werden, warum diese Konstrukte verboten werden.
Dazu betrachten wir eine Methode, die in einem Array einen Wert sucht.
Wir starten mit einer Implementierung, die `return` nutzt.

```java
static boolean contains1(int[] array, int v) {
    for (int i = 0; i < array.length; i++) {
        if (array[i] == v) {
            return true;
        }
    }
    return false;
}
```

Die Verwendung von `return` sorgt dafür, dass man eine Code-Zeile nicht mehr getrennt betrachten kann, sondern immer den Kontext benötigt, in dem sie verwendet wird.
Wenn man ein Programm der folgenden Form liest, wobei `stmt` eine beliebige Anweisung ist, würde man erwarten, dass dieses Programm `stmt` ausführt und dann `false` zurückliefert.

```java
stmt
return false;
```

Dies in der Methode `contains1` aber nicht der Fall.
Die Anweisung `return false` wird hier nur ausgeführt, falls die Schleife nicht zuvor die Methode verlassen hat.
Anders ausgedrückt wird der Code, der ggf. nach einer Schleife folgt, nicht immer ausführt.
Diese Eigenschaft ist relativ fehleranfällig, da man sie nur an dem `return`, das irgendwo in der Schleife vorkommt, identifizieren kann.

Aus dieser Argumentation folgt, dass die folgende Implementierung in einer imperativen Sprache zu bevorzugen ist.

```java
static boolean contains2(int[] array, int v) {
    boolean found = false;
    for (int i = 0; i < array.length; i++) {
        if (array[i] == v) {
            found = true;
            break;
        }
    }
    return found;
}
```

Nehmen wir zum Beispiel einmal an, wir wollen ein Refactoring durchführen und die Methode zu einer Methode `notContains` abändern.
In der Variante `contains2` reicht es aus, die Zeile `return found` durch `return !found` zu ersetzen.
Bei der Variante `contains1` reicht es aber keineswegs aus, die Zeile `return false` durch `return true` zu ersetzen, wie man in einer komplexen Methode vielleicht erwarten würde.

Um die Variante mit `break` zu implemetieren, benötigt man eine zusätzliche boolesche Variable, die das Ergebnis der Schleife an die Anweisung nach der Schleife weiterreicht.
Da wir diese Variable in der verbesserten Variante auf jeden Fall benötigen, können wir auch gleich die folgende Implementierung nutzen.

```java
static boolean contains3(int[] array, int v) {
    boolean found = false;
    for (int i = 0; i < array.length && !found; i++) {
        if (array[i] == v) {
            found = true;
        }
    }
    return found;
}
```

Bei dieser Implementierung sehen wir in der Schleifenbedingung bereits, wann die Schleife beendet wird.
Das heißt, wir müssen nicht mehr in den Code des Schleifenrumpfes schauen, wann die Schleife abbricht, sondern können diese Information an der Stelle ablesen, an der wir sie auch erwarten würden, im Schleifenkopf.

Anders ausgedrückt, würde man normalerweise auch nicht auf die Idee kommen, die folgende Implementierung zu nutzen.

```java
static boolean contains4(int[] array, int v) {
   for (int i = 0;; i++) {
      if (i >= array.length) {
         return false;
      }
      if (array[i] == v) {
         return true;
      }
    }
    return false;
}
```

Hier wird die Abbruchbedingung der Schleife gar nicht mehr im Schleifenkopf definiert sondern lediglich im Code des Rumpfes.
Bei dieser Variante muss man bei komplexeren Methode ggf. viel Code danach überprüfen, ob ein `return` verwendet wird, um den restlichen Code zu verstehen.


### `LocalTypeInference`

Java stellt seit Version 10 eine lokale Typinferenz zur Verfügung.
Statt eine Zeile der Form

```java
int i = 23;
```

zu schreiben, ist es daher möglich

```java
var i = 23;
```

zu nutzen.
Der Java-Compiler ist in der Lage aus dem Wert, der der Variable zugewiesen wird, abzuleiten, welchen Typ die Variable hat.

Im Kontext einer Lehrveranstaltung kann es durchaus sinnvoll sein, die Typen von Variablen immer zu annotieren.
Dies hilft noch einmal darüber nachzudenken, welche Art von Wert überhaupt in einer Variable stehen kann.
Auf der anderen Seite haben statisch getypte Programmiersprachen manchmal einen schlechten Ruf, da man in Sprachen wie Java sehr viele Typen angeben muss.
So erscheint eine Zeile der Form

```java
ArrayList<Integer> list = new ArrayList<Integer>();
```

zu Recht sehr redundant.
An sich ist es in statisch getypen Sprachen aber gar nicht notwendig, so viel Typinformation anzugeben.
Die Sprache Java ist schlichtweg ein schlechtes Beispiel.
In anderen statisch getypten Programmiersprachen sind durch das Konzept einer Typinferenz gar keine Typangaben notwendig.

Um zu illustrieren, dass statisch getypte Sprachen gar nicht so viele Typangaben erfordern müssen, wird dieses Sprachfeature in der Vorlesung, wo möglich, verwendet.


### `ThisConsistency`

Diese Regel erzwingt, dass man das `this`-Schlüsselwort für alle Instanzvariablen verwendet oder für keine.
Hierbei handelt es sich um ein Beispiel für konsistenten Code.
Wenn `this` bei einer Instanzvariable verwendet wird, bei einer anderen aber nicht, erwarten Lesende, dass es einen inhaltichen Grund für diesen Unterschied gibt.


### `VariableDeclarationUsageDistance`

Diese Regel überprüft den Abstand zwischen der Deklaration einer Variable und ihrer ersten Verwendung.
Hinweis: Variablendeklarationen und -initialisierungen werden bei der Berechnung nicht mitgezählt.

Der Geltungsbereich (engl.: scope) für Variablen sollte möglichst klein gewählt werden, um Nebeneffekte durch z.B. Methodenaufrufe auszuschließen, also letztlich sicherzustellen, dass der zugewiesene Wert sich nicht verändert bis zur Verwendung der Variable.
Wenn es nicht möglich ist, den Abstand zwischen Deklaration und Verwendung zu verringern, kann eine Variable alternativ als [`final`](http://hs-flensburg-algo.github.io/basics.html#final) deklariert werden.
Diese Deklaration verhindert ebenfalls, dass die Variable ungewollt verändert wird.
