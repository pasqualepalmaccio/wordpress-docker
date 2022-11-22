# Documentazione Wordpress + Docker in localhost

Questo progetto contiene tutto il necessario per avviare lo sviluppo di un sito <b>WordPress</b> in locale tramite <b>Docker</b>.

<strong>Docker</strong> è un software che consente di eseguire <em>containers</em>. 
I containers sono parti di software isolate e minimali. Pensiamo ad un singolo servizio come <em>mysql</em> o <em>php</em> oppure ancora <em>apache</em> o un set di servizi (ad esempio un intero stack LAMP in un singolo container). 

A differenza delle <em>macchine virutali</em>, docker offre numerosi vantaggi tra cui l'esecuzione di un singolo servizio isolato e facilmente distribuibile. 

## Installazione di Docker

L'installazione di docker nel proprio sistema operativo può essere effettuata in differenti modalità.
Nel mio caso utilizzo Mac OS quindi ho installato Docker Desktop disponibile al link : https://docs.docker.com/engine/install/ . 

Una volta installato e configurato Docker sulla macchina host è necessario assicurarsi del funzionamento di <em>Docker Compose</em>.

<b>Docker Compose</b> è un tool di Docker che consente di scrivere facilmente la configurazione di un container in un file yaml e di eseguire operazioni su di esso. 

<em>Docker Desktop integra Docker Compose v2 disponibile nelle impostazioni. In alcuni casi la v2 potrebbe non funzionare correttamente. In queste circostanze è possibile rimuovere la spunta dalla Docker Compose v2 nelle impostazioni di Docker Dsktop</em>

Per verificare il funzionamento di Docker Compose apriamo un terminale e digitiamo:

<pre><code>docker-compose --version</code></pre>

Nel caso della v2:

<pre><code>docker compose --version</code></pre>

Se l'outpput mostra la versione di Docker Compose significa che siamo pronti per procedere. 

## Avvio dello stack WordPress

L'avvio del nostro stack possiamo farlo semplicemente con il comando: 

<pre><code>docker-compose up -d</code></pre>

<u>Docker in questa fase farà un pull delle immagini dei servizi indicati nel file docker-compose.yaml. se non presenti già nella nostra macchina. </u>

Terminato il download delle immagini avvierà lo stack dei containers. 

Per verificare lo stato dei servizi possiamo lanciare il comando: 
<pre><code>docker-compose ps</code></pre>

### Accesso dal Browser

Se tutti i servizi sono "up" possiamo visitare la pagina <em>localhost</em> dal nostro browser e si avvierà la normale installazione di WordPress.

Da questo momento possiamo sviluppare il nostro sito in locale.

### PhpMyAdmin e Database

Navigando nella pagina: <em>localhost:8890</em> possiamo accedere al tool phpMyAdmin per visualizzare il database di wordpress. 

Le credenziali di accesso sono definite nel file .env

In corrispondenza della voce server basterà indicare il nome del container : <em>db</em>

Questo perchè docker crea una network interna tra i containers <em>name</em>.





