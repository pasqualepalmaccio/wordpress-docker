# Variabili d'ambiente: il file .env

Il progetto fa uso di un file <em>.env</em> per la gestione delle variabili d'ambiente. 
Le variabili d'ambiente sono parametri stringa che possiamo definire globalmente all'interno di un sistema affinchè un processo possa utlizzarle.

Puoi approfondire qui: https://it.wikipedia.org/wiki/Variabile_d%27ambiente

Nel progetto utilizzo il file .env per definire delle variabili globali utili alla connessione con il database, alla scelta della versione di PHP del progetto e così via. 

Nel docker-compose.yaml puoi notare come queste variabili vengono utilizzate attraverso una direttiva all'interno dei containers. In questo modo ogni container, e quindi ogni processo, ne può consultare ed utilizzare il valore. 

<pre><code>

  db:
    ...
    env_file:
      - ./.env
  wordpress:
    ...
    env_file:
      - ./.env
</code></pre>

Puoi tranquillamente modificare i valori delle chiavi presenti nel file ad esempio:


<pre><code>
  MYSQL_ROOT_PASSWORD="miapassword" 
  MYSQL_DATABASE="miodatabase"
  MYSQL_USER="mioutente"
</code></pre>

NB! Modificando i valori di queste chiavi dovresti verificare che questi non sono utilizzati in modo statico in altre parti del progetto. 
Nel makefile ho utilizzato i riferimenti alle chiavi importando il file .env in modo da renderlo agnostico ai valori espressi per le variabil. 