# Schema di progettazione app assistenza: #

## Finalità: ##
 
1. **Fornire assitenza rapida al cliente**
1. Fornire informazioni sulla situazione attuale del cliente
1. Fornire periodicamente informazioni riguardo le novità nei servizi e prodotti
1. Fnviare comunicazioni a gruppi specifici di utenti

## Sezioni: ##

1. **Login**
1. **Chat**
1. **t_order**
1. Home
1. Profilo

## Implementazioni: ##

* ### **Login** ###
1. Login attraverso codice cliente
1. Richiesta codice cliente per accesso
1. Selezione del locale
1. Selezione del profilo fra i contatti del locale
1. Creazione di un nuovo profilo

* ### **Chat** ###
1. Invio di messaggi prestabiliti con risposte automatiche personalizzate
1. Collegamento chat con t_order se viene inserito un messaggio non automatico
1. Visualizzazione chat archiviate

* ### **t_order** ###
1. Interfaccia di gestione messaggi provenienti dall'app
1. Divisione per profilo locale
1. Visualizzazione scaduti
1. Apertura intervento
1. Chiusura chat e archiviazione

* ## Profilo ##
1. ...

* ## Home ##
1. ...

* ## Tutorial ##
1. ...

## Altre note: ##

* ### Modalità di interazione chat/utente/tecnico ###
1. L'inizio della chat è stabilito dall'invio di un messaggio non automatico da parte dell'utente
1. La chat viene terminata manualmente dal tecnico
1. Al termine di una conversazione essa viene archiviata e viene mostrata al cliente, per ogni conversazione archiviata l'utente può restituire un feedback

* ### Messaggi chat con risposta automatica ###
1. qual è la mia piva? 1234575443
1. come faccio a cambiare locale? schiaccia sulla app bar e seleziona il locale
1. come cambiare ora? video in base alla cassa
1. numerazione fatture? video in base al software