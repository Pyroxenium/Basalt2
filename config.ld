-- Projektname, erscheint in der Dokumentation als Titel
project = "Basalt2"

-- Der Haupttitel der Dokumentation
title = "Basalt2 Documentation"

-- Beschreibung des Projekts
description = "A powerful UI Framework for ComputerCraft"

-- Ausgabeverzeichnis für die generierte Dokumentation
dir = "docs"

-- Stil der Dokumentation (!pale, !minimal, etc.)
style = "!pale"

-- Ausgabeformat (markdown oder html)
format = "markdown"

-- Wo nach Lua-Dateien gesucht werden soll
file = "src"

-- Auch private Funktionen dokumentieren
all = true

-- Vorlagen für fehlende Dokumentation generieren
template = true

-- Quellcode in der Dokumentation anzeigen
pretty = true

-- Zusätzliche README-Dateien einbinden
topics = {"README.md"}

-- Eigene Sections für die Dokumentation definieren
sections = {
    "Classes",
    "Methods",
    "Events"
}

-- Ignoriere bestimmte Dateien/Ordner
ignore = {
    "src/tests",
    "src/examples"
}

-- Custom Tags definieren
new_type("event", "Events", false, "param")
