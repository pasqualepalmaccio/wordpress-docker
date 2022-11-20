# WordPress su Docker

Questo progetto ha come scopo quello di fornire un boilerplate per lo sviluppo di un sito web realizzato con CMS WordPress in locale. Il progetto può facilmente essere caricato sul tuo server remoto. 

Se hai già installato Docker e Docker Compose ed hai già confidenza con questo strumento puoi semplicemente seguire questi step:

Scarica il progetto da github (pull o zip). 
<pre><code>
git pull git@github.com:pasqualepalmaccio/wordpress-docker.git
</code></pre>

Apri un terminale nella cartella del progetto oppure aggiungi il progetto al tuo IDE preferito e avvia un terminale. Esegui nel terminale il comando 

<pre><code>
docker-compose up -d -build
</code></pre>

Visita le pagine: 

<pre><code>
localhost #per aviare l'installazione di WordPress
localhost:8890 #se vuoi consultare il database tramite phpmyadmin
</code></pre>

Infine leggi la documentazione per comprendere meglio il funzionamento di questo boilerplate. 

Consulta la documentazione completa <a href="/doc/Introduzione.md">qui</a>. 