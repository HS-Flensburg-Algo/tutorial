---
layout: post
title: "Eclipse"
---

1. [Import eines Projektes](#import-eines-projektes)

2. [Ausführen von JUnit-Testfällen](#ausführen-von-junit-testfällen)

3. [Refactorings](#refactorings)

4. [Einstellungen](#einstellungen)

5. [Bekannte Probleme](#bekannte-probleme)


<br/>

## Import eines Projektes

Für jede Aufgabenserie wird ein GitHub\-_Repository_ zur Verfügung gestellt.
Um den darin zur Verfügung gestellten Code zu nutzen, kann er wie folgt in Eclipse importiert werden.
Mit einem Rechtsklick im `Package Explorer` oder über die Menüleiste unter `File` und dann `Datei` den Menüpunkt `Import...` auswählen.

![Import-Prozess starten](images/import/screen1.jpg)


Anschließend wählt ihr die Art, in dem das zu importierende Repository vorliegt. In diesem Fall handelt es sich um `Existing Gradle Project.`.

![Import-Typ wählen](images/import/screen2.jpg)


![Import-Pfad wählen](images/import/screen3.jpg)


Im nachfolgenden Schritt wählt ihr den Pfad des Ordners für die entsprechende Serie aus.
Der Knopf `Browse...` kann genutzt werden, um das Verzeichnis zu suchen.

![Import erfolgreich abgeschlossen](images/import/screen4.jpg)


Die Bearbeitung der Aufgaben nehmt ihr im Ordner `/src/main/java/` vor.
Die _Repositories_ enthalten immer ein Paket `de.fuas.algorithms`, in dem die Java-Dateien liegen sollten.

![Import erfolgreich abgeschlossen](images/import/screen5.jpg)


Wenn die Aufgabenstellung Testfälle zur Verfügung stellt, können diese mit einem Klick der rechten Maustaste und den Menüpunkt `Run As JUnit Test` ausgeführt werden.

![Import erfolgreich abgeschlossen](images/import/screen6.jpg)

 <br/>

## Ausführen von _JUnit_-Testfällen

Statt mit dem Rechtsklick, wie zuvor gezeigt, könnt ihr die Tests einer einzelnen Testklasse auch ausführen, indem ihr die Klasse öffnet und auf den _Play_-Knopf drückt.

![Ausführung der Tests](images/junit/screen1.jpg)

Nach dem Ausführen erhaltet ihr das Testergebnis.
Als Bezeichnung für den Test wird der Name der Test-Methode verwendet.
In diesem Fall heißt die Methode zum Beispiel `testArrayComplete`.
So könnt ihr nachvollziehen, bei welchem Test es vielleicht noch Schwierigkeiten gibt.
In diesem Fall war der Test nicht erfolgreich.
Dies ist an dem roten Balken, als auch an dem Icon am Testfall zu erkennen.
Die Icons an den Testfällen zeigen das Ergebnis für den jeweiligen Test an.
Der obige Balken trifft eine Aussage darüber, ob ALLE Tests erfolgreich waren oder nicht.

![Anzeige des Fehlers](images/junit/screen2.jpg)


Nachdem alle Fehler behoben wurden und die geprüfte Methode alle Testvoraussetzungen erfüllt, ist folgendes zu sehen:
Das Icon am Testfall zeigt, dass der einzelne Test erfolgreich war.
In diesem Beispiel war `testArrayComplete` erfolgreich.
Da damit alle Tests in dieser Klasse erfolgreich waren, wird der Balken grün angezeigt.

![Zwei Tests erfolgreich](images/junit/screen3.jpg)

<br/>

## Refactorings


### Umbenennen mehrerer Vorkommen eines Variablen-/Methoden-/Klassennamens

Um mehrere Vorkommen eines Variablennamens umbenennen zu können, geht ihr am besten wie folgt vor:
Zuerst markiert ihr eines der Vorkommen.

![Namen markieren](images/functions/rename/screen1.jpg)


Anschließend klickt ihr mit der rechten Maustaste auf den zu ändernden Namen, wählt `Refactor` und `Rename...` aus.

![Aktivieren des Refactoring-Renaming-Modus](images/functions/rename/screen2.jpg)


Nun ist der Modus zum Umbenennen aktiviert...

![Refactoring-Renaming-Modus aktiviert](images/functions/rename/screen3.jpg)


... und ihr könnt den bisherigen Namen verändern.

![Verändern eines Namens](images/functions/rename/screen4.jpg)

In diesem Modus werden alle Vorkommen der Variable gleichzeitig verändert.
Dieser Weg zum Umbenennen kann euch einige Zeit sparen, da es recht mühsam sein kann, alle Vorkommen einer Variable umzubenennen.
Bestätigt abschließend mit _Enter_ den neuen Namen.

![Bestätigen des neuen Namens](images/functions/rename/screen5.jpg)

<br/>

## Einstellungen

### Einstellungen des Code-Formatters

Über die Menüleiste unter `Window` den Menüpunkt `Preferences` auswählen.[^macos]

[^macos]: Unter MacOS ist der Menüpunkt `Preferences` im Anwendungsmenü zu finden, also unter dem Menüpunkt `Eclipse`.

![Einstellungen aufrufen](images/settings/formatter/screen1.png)


Im Einstellungsfenster navigiert ihr zu dem Punkt `Java`, dann `Code Style` und schließlich `Formatter`.

![Formatter-Einstellungen](images/settings/formatter/screen2.png)


Unter den Einstellungen muss nun ein neues Profil angelegt werden, dazu klickt ihr auf den Button `New...`.

![Neues Profil anlegen](images/settings/formatter/screen3.png)


Im Konfigurationsdialog wählt ihr den Profilnamen `Algorithmen` und als Vorgabeprofil `Eclipse [built-in]`. Da das Profil noch bearbeitet werden muss, bleibt die Option `Open the edit dialog now` ausgewählt.

![Neues Profil einstellen](images/settings/formatter/screen4.png)


In dem neuen Einstellungsfenster wählt ihr nun den Unterpunkt `Indentation`.

![Einrückung anpassen](images/settings/formatter/screen5.png)


Dort ändert ihr die Einstellung `Tab policy` auf `Spaces only`.

![Tab policy konfigurieren](images/settings/formatter/screen6.png)


Die Einstellungen können nun verlassen werden, dabei nicht vergessen die Einstellungen mit einem Klick auf `Apply and Close` anzuwenden.


## Bekannte Probleme

### Verwendung von JDK19

Auf eigenen Geräten kann es beim Verwenden des JDK (Version 19) passieren, dass Eclipse euch im Projekt nach dem Import eine Menge Fehler meldet.
Insbesondere können Java-Standard-Pakete wie `java.util` nicht aufgelöst werden, sind also nicht bekannt.
In diesem Fall kann das folgende Vorgehen eventuell Abhilfe schaffen.

![Beispiel vieler Fehler](images/settings/runtime-environment/screen1.png)


Über die Menüleiste unter `Window` den Menüpunkt `Preferences` auswählen.[^macos]

![Einstellungen aufrufen](images/settings/runtime-environment/screen2.png)


Im Einstellungsfenster navigiert ihr zu dem Punkt `Installed JREs` unter `Java`.

![Installed JREs Einstellungen](images/settings/runtime-environment/screen3.png)


Wählt die `jdk-19` aus und öffnet mit einem Klick auf `Edit...` das Fenster zum Bearbeiten.
Im folgenden Fenster ändert ihr den Eintrag von `JRE name` auf `JavaSE-19`.

![JRE Name anpassen](images/settings/runtime-environment/screen4.png)


Bestätigt die Änderung mit `Finish` und verlasst die Einstellungen mit Klick auf `Apply and Close`.
Im Package Explorer sollte jetzt ein Eintrag `JRE System Library [JavaSE-19]` zu finden sein.
Falls die Fehler immer noch angezeigt werden, dann wählt über das Kontextmenü des Projekts (Rechtsklick)
unter dem Punkt `Gradle` die Aktion `Refresh Gradle Project` oder versucht Eclipse neu zu starten `File -> Restart`

![Gradle Projekt aktualisieren](images/settings/runtime-environment/screen5.png)
