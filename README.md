# WordPress su Docker
<small> Documentazione in <strong>italiano</strong></small>


Questo progetto ha come scopo quello di fornire un boilerplate per lo sviluppo di un sito web realizzato con CMS WordPress in locale. Il progetto può facilmente essere caricato sul tuo server remoto. 

Se hai già installato Docker e Docker Compose ed hai già confidenza con questo strumento puoi semplicemente seguire questi step:

1. Scarica il progetto da github (pull o zip). 

2. Apri un terminale nella cartella del progetto oppure aggiungi il progetto al tuo IDE preferito e avvia un terminale. Esegui il comando 

<pre><code>
docker-compose up -d --build
</code></pre>

oppure se hai a disposizione <em>make</em>
<pre><code>
make start
</code></pre>


1. Visita le pagine: 

<pre><code>
localhost #per avviare l'installazione di WordPress
localhost:8890 #se vuoi consultare il database tramite phpmyadmin
</code></pre>

Infine leggi la documentazione per comprendere meglio il funzionamento di questo boilerplate. 

Consulta la documentazione completa <a href="/doc/Introduzione.md">qui</a>. 