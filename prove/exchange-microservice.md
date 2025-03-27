# Exchange microservice

<img src = "https://img.shields.io/static/v1?label=level&message=hard&color=red"> <img src = "https://img.shields.io/static/v1?label=&message=web-development&color=informational"> <img src = "https://img.shields.io/static/v1?label=&message=infrastructure&color=informational"> <img src = "https://img.shields.io/static/v1?label=&message=microservices&color=informational">

## Contesto

Viene richiesto di sviluppare una piattaforma che consenta agli utenti autenticati di simulare l'acquisto di dollari in cambio di euro e viceversa.
La piattaforma dovrà prevedere una registrazione degli utenti, la visualizzazione del proprio saldo e dello storico delle transazioni, e la possibilità di eseguire versamenti acquisti e ritiri di denaro.

## Componenti
-  Backend
	- exchange microservice 
	- users microservice
	- api microservice
-  Frontend
	- react webapp

### Backend
Il backend e' costituito da tre microservizi scritti in NodeJS, ed un database Postgres. 

I microservizi devono comunicare tra loro in rete privata via GRPC, esponendo rispettivamente la porta 9000 (exchange) e 9001 (users). L' API invece è l'unico microservizio raggiungibile esternamente ed espone sulla porta 80 gli endpoint necessari al frontend per funzionare. Tutti i microservizi devono essere sviluppati in NodeJs e TypeScript.

Suggeriamo di visionare un semplice esempio di implementazione di [GRPC](https://github.com/polarity-dev/grpc-test)
 
Di seguito sono elencati più nello specifico i vari microservizi; NB. tutte le funzioni successivamente presentate hanno la funzione di chiarire le feature richieste e non sono da considerarsi necessariamente esaustive o immodificabili ma possono e devono adattarsi secondo le esigenze che eventualmente nasceranno durante lo sviluppo:

- **EXCHANGE**: questo servizio si occupa di fare il calcolo di cambio valuta su una quantità data di euro in dollari o viceversa nel momento in cui si riceve la richiesta. Il tasso di cambio aggiornato può essere recuperato da [questo servizio](https://exchangeratesapi.io/) comodamente in formato JSON o meglio ancora, tagliando ogni intermediario e parsando l'xml fornito direttamente dalla [Banca Centrale Europea](https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml?46f0dd7988932599cb1bcac79a10a16a)
L'interfaccia di questo microservizio è quindi molto semplice ed espone una sola funzione GRPC:
	-	`exchange(number value, string from, string to) // ex: exchange(10, "EUR", "USD")`

- **USERS**: questo microservizio si occupa di tutta la parte di registrazione, login e gestione ordini degli utenti. L'interfaccia di questo microservizio deve prevedere le seguenti funzioni GRPC:
	- `signup(string email, string password, string name, string iban)`: questa funzione salva sul DB i dati dell'utente appena registrato. NB. la password dell'utente non deve essere salvata in chiaro sul DB ma deve prima essere hashata per questioni di sicurezza.
	- `login(string email, string password)`: questa funzione rilascia un JWT all'utente che sarà quindi abilitato alla chiamata di endpoint protetti dell'api.
	- `deposit(nubmer value, string symbol)`: permette all'utente di depositare sul suo conto il valore specificato nella valuta specificata
	- `withdraw(number value, string synbol)`: permette all'utente di spostare dalla piattaforma al suo iban la quantità di denaro specificata nella valuta specificata. NB. le due funzioni `deposit` e `withdraw` sono funzioni che simulano unicamente degli spostamenti di denaro limitandosi ad aggiornare dei valori sul DB dell'applicativo
	- `buy(number value, string symbol)`: permette all'utente di comprare con una valuta la quantità specificata di denaro nell'altra valuta disponibile secondo il tasso di cambio recuperato dall'Exchange microservice; per ogni transazione è necessario archiviare in una tabella di DB appositamente strutturata tutte le informazioni riguardo l'operazione
	- `listTransactions(object filter)`: permette all'utente di visualizzare le sue transazioni con la possibilità di filtrarle per date e/o valuta di riferimento
- **API**: questo microservizio è l'unico accessibile direttamente dall'esterno e deve essere sviluppato usando Open Api ed Express [vedi esempio](https://github.com/polarity-dev/open-api-demo). Lo scopo dell'api è quello di ricevere le chiamate dell'esterno e smistarle ai vari microservizi.

### Frontend
E’ richiesto lo sviluppo di una semplice pagina web interattiva che permetta l’interazione con tutte le componenti dell’API (signup, login, acquisto, vendita e visualizzazione ordini). Questa deve essere realizzata in TypeScript con React.

### Infrastruttura
L'intero applicativo deve poter essere testato localmente con Docker e docker-compose.

### NB
- Verrà attentamente valutato l’utilizzo di GIT.
- Obbligatoria la stesura di un README con le istruzioni per lanciare l'intero stack software localmente.
- E' gradita la presenza **di un unico script** di setup dell'ambiente per il testing locale.
- E' gradita la presenza **di un unico script** di avvio dell'ambiente di testing locale.
