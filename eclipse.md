---
layout: post
title: "Eclipse"
---

1. [Import eines Projektes](#import-eines-projektes)

2. [Ausführen von JUnit-Testfällen](#ausführen-von-junit-testfällen)

3. [Refactorings](#refactorings)

4. [Einstellungen](#einstellungen)

<br/>

## Import eines Projektes

Für jede Aufgabenserie wird ein GitHub-_Repository_ zur Verfügung gestellt.
Um den darin zur Verfügung gestellten Code zu nutzen, kann er wie folgt in Eclipse importiert werden.
Mit einem Rechtsklick im `Package Explorer` oder über die Menüleiste unter `File` und dann `Datei` den Menüpunkt `Import...` auswählen.

![Import-Prozess starten](images/import/screen1.png)


Anschließend wählt ihr die Art in dem das zu importierende Repository vorliegt. In diesem Fall handelt es sich um `Existing Gradle Project.`.

![Import-Typ wählen](images/import/screen2.png)


![Import-Pfad wählen](images/import/screen3.png)


Im nachfolgenden Schritt wählt ihr den Pfad des Ordners für die entsprechende Serie aus.
Der Knopf `Directory...` kann genutzt werden, um das Verzeichnis zu suchen.

![Import erfolgreich abgeschlossen](images/import/screen4.png)


Die Bearbeitung der Aufgaben nehmt ihr im Ordner `/src/main/java/` vor.

![Import erfolgreich abgeschlossen](images/import/screen5.png)


Wenn die Aufgabenstellung Testfälle zur Verfügung stellt, können diese mit einem klickt der rechten Maustaste und den Menüpunkt `Run As JUnit Test` ausgeführt werden.

![Import erfolgreich abgeschlossen](images/import/screen6.png)

 <br/>

## Ausführen von _JUnit_-Testfällen

Um die Tests auszuführen, müsst ihr lediglich die Test-Klasse ausführen.

![Ausführung der Tests](images/junit/screen1.png)

Nach dem Ausführen erhaltet ihr das Testergebnis.
Als Bezeichnung für den Test wird der Methodenname verwendet.
So könnt ihr nachvollziehen, bei welchem Test es vielleicht noch Schwierigkeiten gibt.
In diesem Fall war der Test nicht erfolgreich. (Dies ist zum Einen an dem roten Balken, als auch an dem Icon am Testfall zu erkennen.)
Die Icons an den Testfällen zeigen das Ergebnis für den jeweiligen Test an.
Der obere Balken trifft eine Aussage darüber, ob ALLE Tests erfolgreich waren oder nicht.

![Anzeige des Fehlers](images/junit/screen2.png)


Nachdem alle Fehler behoben wurden und die geprüfte Methode alle Testvoraussetzungen erfüllt, ist folgendes zu sehen:
Das Icon am Testfall zeigt, dass der einzelne Test erfolgreich war.
In diesem Beispiel war `testExpandArray` erfolgreich und `testShiftElements` nicht erfolgreich (siehe jeweils Testfall-Icon).
Es waren somit nicht alle Tests erfolgreich - der rote Balken wird angezeigt.

![Ein Test erfolgreich](images/junit/screen3.png)


Wenn alle Testfälle erfolgreich waren, wird für jeden Testfall das entsprechende Icon angezeigt und der Balken wir grün angezeigt.

![Zwei Tests erfolgreich](images/junit/screen4.png)

<br/>

## Refactorings


### Umbennen mehrerer Vorkommen eines Variablen-/Methoden-/Klassennamens

Um mehrere Vorkommen eines Variablennamens umbenennen zu können, geht ihr am Besten wie folgt vor:
Zuerst markiert ihr eines der Vorkommen.

![Namen markieren](images/functions/rename/screen1.png)


Anschließend klickt ihr mit der rechten Maustaste auf den zu ändernden Namen, wählt `Refactor` und `Rename` aus.

![Aktivieren des Refactoring-Renaming-Modus](images/functions/rename/screen2.png)


Nun ist der Modus zum Umbenennen aktiviert...

![Refactoring-Renaming-Modus aktiviert](images/functions/rename/screen3.png)


... und ihr könnt den bisherigen Namen verändern.

![Verändern eines Namens](images/functions/rename/screen4.png)


Bestätigt abschließend mit _Enter_ den neuen Namen.

![Bestätigen des neuen Namens](images/functions/rename/screen5.png)

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
