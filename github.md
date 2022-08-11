---
layout: post
title: "GitHub"
---

1. [GitHub über die Konsole bedienen](#github-über-die-konsole-bedienen)

2. [Feedback und reviewdog](#feedback-und-reviewdog)

<br/>

## GitHub über die Konsole bedienen

### Installation von Git unter Windows

Unter <https://git-scm.com/download/win> findet ihr den _Installer_. Der Download sollte automatisch starten.

Im Installationsprozess muss nur eine Sache verändert werden.

Im 1. Schritt `Select Components` sollte die `Windows Explorer integration` mit `Git Bash Here` ausgewählt sein. Dies ist standardmäßig der Fall.

Im 2. Schritt `Choosing the default editor used by Git` sollte ein anderer Editor als Vim benutzt werden.

Ihr könnt entweder euren Lieblingseditor aus der Liste auswählen oder den Punkt `Select other editor as Git's default editor`. Als `Location of editor` tragt ihr dann euren Editor ein, oder einfach `C:\Windows\notepad.exe` für den Editor von Windows.

Ab da kann den Standardeinstellungen gefolgt werden, am Ende auf `Install` klicken.

Nach der erfolgreichen Installation nur noch kurz das Häkchen bei `View Release Notes` entfernen und mit `Next` den _Installer_ beenden.

Nun öffnet ihr mit dem Windows Explorer den Ordner, in dem ihr die Bearbeitung der Aufgaben vornehmen wollt.

Mit einem Rechtsklick in dem Ordner könnt ihr nun im Kontextmenü `Git Bash Here` auswählen, es öffnet sich ein Konsolenfenster.

<br/>

### Konfiguration des Nutzers

Damit GitHub euch die Commits, die ihr durchführt, zuordnen kann, solltet ihr einmal euren Namen und eure Mail-Adresse setzen.
Dazu müsst ihr in der Konsole die folgenden beiden Befehle eingeben und jeweils mit der _Eingabe_-Taste bestätigen.
Ihr müsst dabei meinen Namen und meine E-Mail-Adresse natürlich durch eure jeweiligen Informationen ersetzen.
Ihr solltet eine E-Mail-Adresse nutzen, die ihr auch bei GitHub eingetragen habt.
Bitte beachtet, dass die E-Mail-Adresse von Personen eingesehen werden kann, die Zugriff auf eines eurer _Repositories_ haben.

```
git config --global user.name "Jan Christiansen"
```

```
git config --global user.email "jan.christiansen@hs-flensburg.de"
```

Unter [diesem Link](https://docs.github.com/en/free-pro-team@latest/github/setting-up-and-managing-your-github-user-account/setting-your-commit-email-address#setting-your-commit-email-address-in-git) findet ihr bei Interesse noch eine alternative Erklärung und zusätzliche Informationen zu dieser Konfiguration und GitHub.

<br/>

### Git über die Konsole bedienen

Zum Bearbeiten und zur Abgabe der Aufgaben müsst ihr den über GitHub bereitgestellten Source-Code über die Konsole verwalten.  

Damit ihr den Code lokal bearbeiten könnt, müsst ihr das Repo klonen. Ihr benötigt dafür zunächst einen _SSH Key_. Diesen müsst ihr zu eurem GitHub-Account hinzufügen. Eine ausführliche Erklärung zur Generierung eines _SSH Keys_ und dem Hinzufügen des _SSH Keys_ zu eurem GitHub-Account findet ihr [hier](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh).

Anschließend benötigt ihr die URL eures _Repos_.
Diese erhaltet ihr auf der GitHub-Webseite:

![](images/git/step1.png)

Mit Hilfe der URL könnt ihr das _Repository_ über eure Konsole mit `git clone <url>` herunterladen.
Sofern ihr bei der Generierung des _SSH Keys_ eine _Passphrase_ festgelegt habt, müsst ihr diese nun eingeben.

Anschließend wechselt ihr in das heruntergeladene _Repository_ mit `cd <repo-name>`.

![](images/git/step2.png)

Nachdem ihr die Aufgabe bearbeitet habt, könnt ihr mit `git status` alle editierten Dateien sehen.

![](/images/git/step3.png)

Die Dateien, die ihr abgeben wollt, müssen nun jeweils mit `git add <file-path>` selektiert werden.

![](images/git/step4.png)

Zum Überprüfen, ob alle abzugebenen Dateien ausgewählt/hinzugefügt wurden, kann erneut `git status` aufgerufen werden.
Alle in grün geschriebenen Dateien wurden zur Abgabe selektiert.

![](images/git/step5.png)

Vor dem Upload müssen die Dateien "committet" werden.
Einen _Commit_ führt man mit dem Kommando `git commit -m "<commit-message>"` durch.
Der Text `<commit-message>` ist dabei eine Beschreibung der Arbeiten, die ihr durchgeführt habt und die ihr mit dem _Commit_ bei GitHub hochladen wollt.

![](images/git/step6.png)

Die Abgabe / Der Upload der Bearbeitung erfolgt zu guter Letzt mit `git push`.
Mit dem Befehl `git push` werden alle _Commits_, die ihr seit dem letzten `git push` durchgeführt habt, hochgeladen.

![](images/git/step7.png)


Es kann vorkommen, dass der Befehl `git push` nicht erfolgreich ist und ihr zum Beispiel eine Fehlermeldung der folgenden Art erhaltet.

```
To github.com:hsfl-pltp-classroom/test-jan-christiansen.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'git@github.com:hsfl-pltp-classroom/test-jan-christiansen.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

Dies passiert zum Beispiel, wenn ihr parallel mit Hilfe des Web-Interface von GitHub Dateien hochgeladen oder Dateien verändert habt.
Um dieses Problem zu beheben, müsst ihr einmal die Änderungen, die im Repo passiert sind, zu euch auf den Rechner holen.
Dazu müsst ihr den Befehl `git pull` ausführen.
Nach Ausführung des Befehls sollte sich ein Editor öffnen.
Den Editor könnt ihr einfach schließen und die Datei speichern.
Danach sollte eine Nachriht der folgenden Art erscheinen.

```
remote: Enumerating objects: 13, done.
remote: Counting objects: 100% (13/13), done.
remote: Compressing objects: 100% (9/9), done.
remote: Total 10 (delta 3), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (10/10), done.
From github.com:hsfl-pltp-classroom/test-jan-christiansen
   a7a5355..e6dd480  master     -> origin/master
Merge made by the 'recursive' strategy.
 .github/classroom/autograding.json | 14 ++++++++++++++
 .github/workflows/classroom.yml    | 11 +++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 .github/classroom/autograding.json
 create mode 100644 .github/workflows/classroom.yml
```

Jetzt solltet ihr ganz normal mit dem Befehl `git push` fortfahren können.

<br/>


### Commit-Nachrichten schreiben

Wenn man professionell Software entwickelt, sollte man sich etwas Mühe mit den _Commit_-Nachrichten geben.
Wie in vielen anderen Bereichen der Informatik sollten die Nachrichten zumindest erst einmal einheitlich sein.
Ihr sollt euch im Zuge der Veranstaltung gern so gut es geht an die Vorschläge unter [How to Write a Git Commit Message](https://cbea.ms/git-commit/) halten.
Aufgrund der recht kleinen Projekte, die im Rahmen der Vorlesung programmiert werden, reicht es, wenn eurer _Commit_-Nachrichten nur aus einem _Subject_ bestehen.
Das heißt, mögliche Nachrichten wären zum Beispiel `Add first implementation of ArrayList`, `Fix size method` oder `Rename class to ArrayList`. 

  <br/>

## Feedback und reviewdog

### Anmerkungen lesen

Die _Repositories_ mit den Laboraufgaben sind so konfiguriert, dass automatisch geprüft wird, dass ihr euch an bestimmte Programmierregeln haltet.
Diese automatische Überprüfung wird mit dem Tool [Checkstyle](https://checkstyle.sourceforge.io) durchgeführt.
Ein Tool namens [reviewdog](https://github.com/reviewdog/reviewdog) sorgt dann dafür, dass die Anmerkungen, die Checkstyle hat, an den richtigen Stellen eures Codes bei GitHub abgezeigt werden.

Um zu den Anmerkungen zu gelangen, müsst ihr zuerst den Reiter _Pull Request_ wählen.

![](images/reviewdog/step1.png)

Es sollte durch einen _Pull Request_ geben, der Feedback heißt.
Wählt diesen bitte aus.
Falls dieser _Pull Request_ nicht existiert, nehmt bitte Kontakt zu mir auf.
Das rote Kreuz zeigt an, dass noch Fehler gefunden wurden:

![](images/reviewdog/step2.png)

Wenn ihr den _Pull Request_ gewählt habt, könnt ihr oben den Reiter "Files changed" auswählen.

![](images/reviewdog/step3.png)

Ihr seht dann zeilenweise Anmerkungen an eurer Abgabe.

![](images/reviewdog/step4.png)

Wenn ihr eine Lösung hochgeladen habt, schaue ich mir die Lösung in der entsprechenden Laborzeit an und schreibe Kommentare.
Diese Kommentare findet ihr ebenfalls unter _Files Changed_ des _Pull Requests_.

![](images/reviewdog/step5.png)

