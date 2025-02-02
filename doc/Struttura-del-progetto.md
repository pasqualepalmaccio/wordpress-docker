# 📂 Cartella `config/` – Configurazione del progetto WordPress con Docker

## 📌 Introduzione

La cartella `config/` contiene **tutte le configurazioni necessarie per personalizzare e ottimizzare l’ambiente Docker**.  
Qui troverai i file di configurazione per **WordPress, MySQL, Redis, PHP e Varnish**, che permettono di controllare le impostazioni del sistema senza modificare i container direttamente.

Questa struttura ti consente di personalizzare facilmente il tuo setup mantenendo **un ambiente stabile e riproducibile**.

---

## 🛠 **Dettaglio delle configurazioni**

### 🔹 **1. `config/mariadb/` – Configurazione del database**
Questa cartella contiene la configurazione per **MySQL/MariaDB**, il database di WordPress.

📄 **`my.cnf`**  
✅ Ottimizza le performance del database.  
✅ Definisce i limiti di connessione, buffer e caching.  
✅ Utilizza il file come override delle impostazioni predefinite del container MySQL.  

---

### 🔹 **2. `config/redis/` – Configurazione Redis**
Questa cartella contiene il file di configurazione per **Redis**, usato per migliorare le prestazioni della cache di WordPress.

📄 **`redis.conf`**  
✅ Configura il caching di oggetti per WordPress.  
✅ Permette di gestire timeout e memoria cache.  
✅ Ottimizza la connessione tra WordPress e Redis.

---

### 🔹 **3. `config/php/` – Configurazione PHP**
Contiene **un file php.ini personalizzato** che permette di **modificare le impostazioni di PHP**.

📄 **`php.ini`**  
✅ Imposta i valori per `upload_max_filesize`, `memory_limit`, `post_max_size`.  
✅ Abilita OPcache per migliorare le prestazioni di WordPress.  
✅ Personalizza i limiti di esecuzione di PHP per adattarli a WordPress.

---

### 🔹 **4. `config/varnish/` – Configurazione Varnish**
Questa cartella contiene la configurazione per **Varnish Cache**, utilizzata per servire le pagine in modo più veloce riducendo il carico su PHP.

📄 **`default.vcl`**  
✅ Definisce le regole di caching per WordPress.  
✅ Esclude dalla cache pagine come `/wp-admin` e `/wp-login.php`.  
✅ Gestisce la memorizzazione di pagine statiche e dinamiche.

---

### 🔹 **5. `config/wp-files/` – Configurazioni personalizzate per WordPress**
Questa cartella contiene il file di configurazione principale di WordPress.

📄 **`wp-config.php`**  
✅ **Forza l’uso delle variabili d’ambiente** per il database e la cache.  
✅ **Evita la modifica manuale** del file all’interno del container.  
✅ **Compatibile con l’importazione di siti esistenti**, evitando conflitti di configurazione.

---

## ✅ **Conclusione**
La cartella `config/` è il cuore della configurazione del progetto, permettendo di:
- **Gestire le impostazioni di MySQL, Redis, PHP e Varnish** senza modificare i container.
- **Personalizzare WordPress** con un `wp-config.php` predefinito.
- **Ottimizzare le performance** del sito grazie a caching e configurazioni avanzate.

📌 **Prossimo passo:** Documentiamo **`docker-compose.yml`** per spiegare come i servizi interagiscono! 🚀  