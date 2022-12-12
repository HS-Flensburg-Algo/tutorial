---
layout: post
title: "Programmierregeln"
---

1. [Name einer Regel](#name-einer-regel)

2. [Regeln](#regeln)

    1. [AvoidLoopBreak](#avoidloopbreak)

    2. [FinalParameters](#finalparameters)

    3. [LocalTypeInference](#localtypeinference)

    4. [PreferExpressions](#preferexpressions)

    5. [ReduceScope](#reducescope)

    6. [ThisConsistency](#thisconsistency)

    7. [UseElse](#useelse)

    8. [VariableDeclarationUsageDistance](#variabledeclarationusagedistance)


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
Wenn man dagegen bei einer der Methoden eine andere Implementierung wählt, erwarten Lesende, dass dieser Unterschied einen inhaltlichen Grund hat.


### AvoidLoopBreak

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

Um die Variante mit `break` zu implementieren, benötigt man eine zusätzliche boolesche Variable, die das Ergebnis der Schleife an die Anweisung nach der Schleife weiterreicht.
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


### FinalParameters

Diese Regel prüft, dass Parameter von Methoden und Konstruktoren als [`final`](http://hs-flensburg-algo.github.io/basics.html#final) deklariert sind.
Grundsätzlich können die Parameter von Methoden in Java verändert werden.
Das heißt, wir können zum Beispiel die folgende Methode implementieren.

```java
static int method(int arg) {
   arg = 23;
   ...
   return arg;
}
```

Das Ändern des Parameters auf einen anderen Wert kann in der restlichen Methoden sehr verwirrend sein, da man normalerweise davon ausgeht, dass in der Variable `arg` das Argument steht, das beim Aufruf der Methode übergeben wird.
Um das Verändern der Parameter zu verhindern, gibt es in einigen Java-Projekten die Konvention, dass alle Parameter als [`final`](http://hs-flensburg-algo.github.io/basics.html#final) deklariert werden müssen.
Auf diese Weise erhalten wir einen Kompilierfehler, wenn wir versuchen eine Methode `method` zu verwenden.

Diese Regel wird erst in einer späteren Laboraufgabe aktiviert, um zu Beginn des Semesters den Code nicht zu überfrachten.


### LocalTypeInference

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


### PreferExpressions

Bei der Programmierung in einer imperativen Programmiersprachen hat man häufig die Wahl zwischen einem Programmierstil, der eher anweisungsorientiert ist und einem Stil, der eher ausdrucksorientiert ist.
Diese Regel soll dafür sorgen, dass in bestimmten Fällen der ausdrucksorientierte Stil verwendet wird.
Wir betrachten dazu die folgende Java-Methode.

```java
static int addAndInc(int arg1, int arg2) {
    int result = 0;
    result = result + arg1;
    result = result + arg2;
    result++;
    return result;
}
```

Diese Methode addiert zwei Zahlen und erhöht das Ergebnis am Ende noch um `1`.
Während diese Implementierung das gewünschte Ergebnis berechnet, ist sie durch die Verwendung von Anweisungen unnötig kompliziert.
Die gleiche Methode kann durch die Verwendung von Ausdrücken auch wie folgt implementiert werden.

```java
static int addAndInc(int arg1, int arg2) {
    return arg1 + arg2 + 1;
}
```


### ReduceScope

Mit dem englischen Begriff [_Scope_](https://hs-flensburg-algo.github.io/basics.html#sichtbarkeit-von-variablen) bezeichnet man den Bereich, in dem eine Variable sichtbar ist.
In dem Bereich, in dem eine Variable sichtbar ist, kann sie grundsätzlich gelesen und geschrieben werden.
Man sollte den Bereich, in dem eine Variable sichtbar ist, möglichst klein halten.
Das verhindert, dass die Variable aus Versehen gelesen oder geschrieben wird.
Daher sollte eine Variable erst in dem Block definiert werden, in dem sie auch verwendet wird.
Wir betrachten zum Beispiel die folgende Methode.

```java
static void main(String[] args) {
    int x = 1;
    if (args.length == 0) {
        ...
    } else {
        ...
    }
    ...
}
```

Falls die Variable `x` hier nur in einem der Zweige der `if`-Anweisung verwendet wird, sollte die Variable auch in dem entsprechenden Zweig deklariert sein.
Falls die Variable in der `if`-Anweisung gar nicht verwendet wird, sollte die Variable erst nach der `if`-Anweisung deklariert sein.
In beiden Fällen verkleinern wir den Bereich, in dem die Variable sichtbar ist.

In einer `if`-Anweisung, die ein `else if` nutzt, kann die Anmerkung etwas verwirrend sein.
Wir betrachten einmal das folgende Beispiel.

```java
static void main(String[] args) {
    int x = 1;
    if (args.length == 0) {
        ...
    } else if (arg.length == 1) {
        return x;
    } else {
        return x + 1;
    }
    ...
}
```

Hier erhalten wir eine Anmerkung, dass wir den Scope von `x` reduzieren können, da die Variable `x` in den Fällen `arg.length == 1` und im `else`-Fall verwendet wird, die Variable wird aber nicht im Fall `args.length == 0` verwendet.
Es stellt sich bei diesem Beispiel allerdings die Frage, wie wir die Deklaration der Variable `x` nur in diesen beiden Fälle sichtbar machen.
Um diese Anmerkung umzusetzen, muss man wissen, dass die `else if`-Konstruktion nur eine Kurzform von zwei geschachtelten `if`-Anweisungen ist.
Wir können die obige Methode auch wie folgt definieren.

```java
static void main(String[] args) {
    int x = 1;
    if (args.length == 0) {
        ...
    } else {
        if (arg.length == 1) {
            return x;
        } else {
            return x + 1;
        }
    }
    ...
}
```

Das `else if` ist nur eine Kurzform, die es erlaubt, die Einrückung der zweiten `if`-Anweisung zu verhindern.
In dieser Variante der Methode können wir jetzt einfach den Scope der Variable `x` verringern.

Die Tatsache, dass die Variable `x` gar nicht in allen Fällen verwendet wird, ist auch ein Zeichen dafür, dass die drei Fälle gar nicht auf der gleichen Ebene sein sollten.
Manchmal sind zwei geschachtelte `if`-Anweisungen sinnvoller, da sie ausdrücken, dass zwei Bedingungen überprüft werden, die unterschiedliche Eigenschaften erfüllen.


### ThisConsistency

Diese Regel erzwingt, dass man das `this`-Schlüsselwort für alle Instanzvariablen verwendet oder für keine.
Hierbei handelt es sich um ein Beispiel für konsistenten Code.
Wenn `this` bei einer Instanzvariable verwendet wird, bei einer anderen aber nicht, erwarten Lesende, dass es einen inhaltlichen Grund für diesen Unterschied gibt.


### UseElse

Diese Regel schlägt in zwei Fällen an.
Im ersten Fall sorgt sie dafür, dass bei einer `if`-Anweisung ein `else` verwendet wird, wenn die `if`-Anweisung die Methode verlässt.
Wir betrachten einmal das folgende Beispiel.

```java
static int min(int x, int y) {
    if (x < y) {
        return x;
    }
    return y;
}
```

Wenn wir diesen Code betrachten, wissen wir, dass die Methode niemals den Code im `then`-Zweig der `if`-Anweisung (also `return x`) **und** den Code nach der `if`-Anweisung (also `return y`) ausführen wird.
Stattdessen wir die Methode nur **entweder** den Code im `then`-Zweig der `if`-Anweisung (also `return x`) **oder** den Code nach der `if`-Anweisung (also `return y`) ausführen.
Das heißt, wir konstruieren in diesem Beispiel zwei unabhängige Code-Pfade.
Diese Information ist aber in der Definition der Methode sehr implizit.
Bei komplexeren Methoden ist diese Tatsache sehr schnell schlecht zu erkennen.
Mit diesem Umstand geht einher, dass wir nicht direkt sehen, dass im Code nach der `if`-Anweisung immer `x >= y` gilt.
Man nennt Eigenschaften wie "in diesem Stück Code gilt immer `x >= y`" Invarianten und diese sind bei der Programmierung sehr wichtig.
Diese Invariante ist für die Korrektheit des Codes, der nach der `if`-Anweisung folgt, unerlässlich.

Daher sollte man bei Methoden, die im `then`-Zweig einer `if`-Anweisung die Methode verlassen, ein `else` nutzen.
Das heißt, wir sollten die Methode `min` stattdessen wie folgt definieren.

```java
static int min(int x, int y) {
    if (x < y) {
        return x;
    } else {
        return y;
    }
}
```

Bei dieser Variante ist für den Leser sofort offensichtlich, dass die Methode zwei logische Pfade hat, die voneinander unabhängig sind.
Wir sehen sofort, dass der Code entweder den einen Pfad oder den anderen Pfad nehmen wird.

Diese Regel schlägt außerdem an, wenn nach einer `if`-Anweisung, welche die Methode verlässt, weitere Anweisungen folgen.
Wir betrachten einmal das folgende Beispiel.

```java
static int min(int x, int y) {
    int result;
    if (x < y) {
        return x;
    } else {
        result = y;
    }
    return result;
}
```

In diesem Beispiel wird nun, wie von der Regel gewünscht, ein `else` verwendet, um die beiden Code-Pfade klar voneinander zu trennen.
In diesem Beispiel werden nun allerdings nach der `if`-Anweisung weitere Anweisungen ausgeführt, in diesem Fall das `return result`.
Falls die Bedingung `x < y` erfüllt ist, werden die Anweisungen nach der `if`-Anweisung, also hier `return result` nie ausgeführt.
Daher sollten auf die `if`-Anweisung keine weiteren Anweisungen folgen.
Stattdessen sollten wir den Code, der nach der `if`-Anweisung folgt, in den `else`-Zweig der `if`-Anweisung verschieben.
Das heißt, wir erhalten die folgende Definition.


```java
static int min(int x, int y) {
    int result;
    if (x < y) {
        return x;
    } else {
        result = y;
        return result;
    }
}
```

Nach dieser Änderung des Codes können andere Regeln angewendet werden, um die Struktur weiter zu verbessern.
Zum Beispiel wird die Variable `result` in diesem Beispiel jetzt nur noch im `else`-Zweig der `if`-Anweisung genutzt und sollte somit auch dort deklariert werden.


### VariableDeclarationUsageDistance

Diese Regel überprüft den Abstand zwischen der Deklaration einer Variable und ihrer ersten Verwendung.
Hinweis: Variablendeklarationen und -initialisierungen werden bei der Berechnung nicht mitgezählt.

Der Geltungsbereich (_Scope_) für Variablen sollte möglichst klein gewählt werden, um Nebeneffekte durch z.B. Methodenaufrufe auszuschließen, also letztlich sicherzustellen, dass der zugewiesene Wert sich nicht verändert bis zur Verwendung der Variable.
Wenn es nicht möglich ist, den Abstand zwischen Deklaration und Verwendung zu verringern, kann eine Variable alternativ als [`final`](http://hs-flensburg-algo.github.io/basics.html#final) deklariert werden.
Diese Deklaration verhindert ebenfalls, dass die Variable ungewollt verändert wird.
