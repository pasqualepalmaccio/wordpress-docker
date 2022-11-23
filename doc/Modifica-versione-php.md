# Modifica Versione di PHP per WordPress

Per modificare la versione di PHP in cui girerà WordPress ti basta modificare la variabile d'ambiente <em>PHP_VERSION</em> nel file <em>.env</em>

### Le versioni disponibili

L'immagine ufficiale di WordPress nel Docker Hub mette a disposizione molte varianti. Il mio consiglio è quello di usare una tra queste elencate:

<ul>
<li>php7.4-apache</li>
<li>php8.1-apache</li>
</ul>

Puoi comunque trovare le versioni disponibili qui: https://hub.docker.com/_/wordpress nella sezione "Supported tags"