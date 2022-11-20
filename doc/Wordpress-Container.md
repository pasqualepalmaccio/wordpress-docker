# Uno sguardo al container Wordpress

Il container WordPress è quello ufficiale presente nel Doccker Hub al link: https://hub.docker.com/_/wordpress. 

Il container è uno stack composto da <b>apache</b> e <b>php</b> utili a far girare il CMS.

In questo progetto mi sono limitato a personalizzare la configurazione di alcuni parametri di php tramite il <em>php.ini</em>.

Nella path <em>/config/wordpress</em> del progetto, infatti, ho inserito un file php.ini in cui possiamo scrivere le nostre direttive per php.

Il file viene quindi iniettato nel container in accordo alle istruzioni presenti nel relativo <em>Dockerfile</em>. 

NB! Per rendere effettive eventuali modifiche al file <em>php.ini</em> sarà necessario effettuare nuovamente la build del servizio e riavviare i containers. Per farlo possiamo eseguire:

<pre><code>
docker-compose down
docker-compose build
docker-compose up -d
</code></pre>

Chiaramente possiamo eseguire anche una sequenza differente come: 

<pre><code>
docker-compose down
docker-compose up -d --build
</code></pre>

oppure ancora effettuare la build ed il riavvio  del solo container <em>wordpress</em>. 