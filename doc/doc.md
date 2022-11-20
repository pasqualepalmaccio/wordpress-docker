# Documentazione Wordpress + Docker in localhost

Questo semplice file yaml contiene il necessario per avviare lo sviluppo di un sito wordpress in locale tramite Docker. Per rendere l'ambiente più familiare e confidenziale ho pensato di utilizzare i volumi di docker per avere accesso dalla macchina host ai files di wordpress e al database. 

Ho inoltre aggiunto il servizio di phpmyadmin per una facile e confidenziale consultazione del database.

## Installazione di Docker

Per prima cosa dobbiamo installare Docker sul nostro sistema operativo. Per farlo ci sono vari modi e variano in base al proprio sistema operativo. Nel mio caso utilizzo Mac OS quindi ho installato Docker Desktop disponibile al link : https://docs.docker.com/engine/install/ . Una volta configurato Docker sulla macchina host è necessario assicurarsi del funzionamento di Docker Compose.

Docker integra Docker Compose v2 disponibile nelle impostazioni di Docker Desktop. In alcuni casi potrebbe non funzionare correttamente, in queste circostanze è possibile rimuovere la spunta dalla Docker Compose v2. 

Per verificare il funzionamento di Docker Compose apriamo un terminale e digitiamo:

<pre><code>docker-compose --version</code></pre>

Oppure nel caso della v2:

<pre><code>docker compose --version</code></pre>

Se l'outpput mostra la versione di Docker Compose significa che siamo pronti per procedere. 

<em>Docker Compose è un tool di docker che, tra le tante funzioni, ci consente di scrivere i nostri servizi docker e le rispettive configurazioni direttamente in un file yaml.</em>

## Avvio del nostro stack WordPress

Questa non è una guida approfondita di Docker e del suo funzionamento. Mi limiterò a dire che il nostro obiettivo è quello di far girare i servizi essenziali per avviare una istanza di WordPress funzionante in locale. 

#### Per i meno esperti...
Docker è uno strumento che permette la creazione di <em>Containers</em> ovvero di creare istanze di microservizi installando solo le parti di kernel essenziali al funzionamento del microservizio stesso. Questo è ciò che differenzia Docker dai più comuni sistemi di virtualizzazione che richiedono l'installazione dell'intero sistema operativo per il funzionamento di un microservizio. 

### Start

L'avvio del nostro stack possiamo farlo semplicemente con il comando: 

<pre><code>docker-compose up -d</code></pre>

Docker in questa fase farà un pull delle immagini dei servizi indicati nel file docker-compose.yaml. 

Terminato il download delle immagini avvierà i nostri servizi. 

### I servizi

Aprendo con un IDE il file docker-compose.yaml notiamo che sono stati definiti i servizi: 

<pre><code>
services:

  db:
    image: mariadb:latest
    volumes:
      - ./data/db:/var/lib/mysql
    restart: always
    
  phpmyadmin:
    image: phpmyadmin:latest
    environment:
     - PMA_ARBITRARY=1
    ports:
      - 8890:80
    links:
      - db

  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    ports:
      - "80:80"
    restart: always
    volumes:
      - ./data/files:/var/www/html

</code></pre>

Ritengo abbastanza intuitivo capire cosa sono e a cosa servono. Se hai difficoltà a comprendere il contenuto di questo file ti consiglio di seguire un breve approfondimento di Docker ed in particolare di Docker Compose. 

#### I Volumi

Come accennato ad inizio della documentazione,ho definito una path <em>data</em> in cui si configurano i volumi dei servizi <em>db</em> e <em>wordpress</em>. 
Se non conosci il funzionamento dei volumi ti consiglio di approfondire sulla doc ufficiale di docker oppure di ignorarlo per questo scopo e fidarti di cosa accade. 
Una volta avviati i servizi questa path si riempirà dei files di WordPress e del Db. 

Questi files resteranno sincronizzati durante tutto il nostro ciclo di sviluppo tra la macchina host ed i containers che ne fanno uso. Insomma immaginate che quei files sono contemporaneamente nel "container" (servizi docker) e nella vostra macchina e non solo incapsulati nei containers. 

### Accesso dal Browser

Se tutti i servizi sono "up" possiamo visitare la pagina <em>localhost</em> dal nostro browser e si avvierà la normale installazione di WordPress.

Da questo momento possiamo sviluppare il nostro sito in locale.

### PhpMyAdmin e Database

Navigando nella pagina: <em>localhost:8890</em> possiamo accedere al tool phpMyAdmin per visualizzare il database di wordpress. 

Le credenziali di accesso sono definite nel docker-compose.yaml in corrispondenza del nodo <em>enviroment</em> del servizio db.

In corrispondenza della voce server basterà indicare il nome del container : <em>db</em>

Questo perchè docker crea una network interna tra i servizi raggiungibili tra loro tramite il <em>name</em>.



