# 🛠 Makefile – Automazione del progetto WordPress con Docker

## 📌 Introduzione
Il **Makefile** è stato progettato per semplificare la gestione del progetto **WordPress Docker**.  
Attraverso semplici comandi `make`, puoi avviare, fermare e gestire il tuo ambiente di sviluppo **senza dover ricordare comandi Docker complessi**.

---

## 🔍 Struttura del Makefile

### **1️⃣ Avvio del progetto**
```sh
make start
```
## 📌 Cosa fa?

* Esegue docker compose up -d --build, forzando la build delle immagini.
* Chiede se vuoi importare un sito esistente o crearne uno nuovo.
* Se scegli l’importazione, fornisce le istruzioni su come posizionare i file e avvia make import.
* Se scegli una nuova installazione, avvia semplicemente il progetto.

# 🛠 Comando `make stop` – Arresto dei container WordPress Docker

## 📌 Descrizione
Il comando `make stop` serve per **arrestare tutti i container** associati al progetto WordPress Docker, rimuovendo anche i container orfani.

---

## 🔍 Sintassi del comando
```sh
make stop
```

# 📦 Backup e Ripristino in WordPress Docker

## 📌 Introduzione
Il sistema di backup e ripristino in questo progetto Docker per WordPress permette di salvare e ripristinare facilmente sia i file di WordPress che il database MySQL.  
Tutti i backup vengono memorizzati nella cartella `/backup` all'interno dei container.

---

## 🔍 Struttura dei Comandi
### **1️⃣ Backup Completo**
Per eseguire un backup completo, usa il comando:  
```sh
make backup
```

📌 **Cosa fa?**
- Esegue il backup sia dei file di WordPress che del database MySQL.
- Archivia i file di WordPress in un file `.zip`.
- Esporta il database in un file `.sql`.
- Salva entrambi i file in `/backup` con un timestamp.

---

### **2️⃣ Backup dei soli file**
Per eseguire il backup solo dei file di WordPress, usa il comando:  
```sh
make backup-files
```

📌 **Cosa fa?**
- Crea un archivio zip di tutti i file di WordPress presenti in `/var/www/html`.
- Il backup viene salvato in `/backup/wp-backup-YYYYMMDD_HHMMSS.zip` all'interno del container.

Internamente esegue:  
```sh
docker-compose exec wordpress bash -c "cd /var/www/html && zip -r /backup/wp-backup-$(date +"%Y%m%d_%H%M%S").zip ."
```
---

### **3️⃣ Backup del solo database**
Per eseguire il backup solo del database MySQL, usa il comando:  
```sh
make backup-db
```
📌 **Cosa fa?**
- Esegue un dump del database MySQL e lo salva in `/backup/wpdb-backup-YYYYMMDD_HHMMSS.sql`.
- Usa il comando `mysqldump` per esportare il database, preservando il set di caratteri UTF-8.

Internamente esegue:  
```sh
docker-compose exec db bash -c "mysqldump --default-character-set=utf8mb4 -u ${MYSQL_USER} -p${WORDPRESS_DB_PASSWORD} ${MYSQL_DATABASE} > /backup/wpdb-backup-$(date +"%Y%m%d_%H%M%S").sql"
```
---

## 🔄 Ripristino di un Backup
### **4️⃣ Ripristino Completo**
Per ripristinare un backup completo, usa il comando:  
```sh
make restore
```
📌 **Cosa fa?**
- Ripristina sia i file di WordPress che il database.
- Trova l'ultimo backup disponibile e lo utilizza automaticamente.

---

### **5️⃣ Ripristino dei soli file**
Per ripristinare solo i file di WordPress, usa il comando: 
```sh
make restore-files
```
📌 **Cosa fa?**
- Trova l'ultimo backup disponibile dei file WordPress nella cartella `/backup`.
- Estrae l'archivio `.zip` e ripristina tutti i file in `/var/www/html`.

Internamente esegue:  
```sh
docker-compose exec wordpress bash -c 'LATEST_FILE=$(ls -t /backup/wp-backup-*.zip | head -n 1); unzip -o $$LATEST_FILE -d /var/www/html'
```
---

### **6️⃣ Ripristino del solo database**
Per ripristinare solo il database MySQL, usa il comando:  
```sh
make restore-db
```

📌 **Cosa fa?**
- Trova l'ultimo backup disponibile del database in `/backup`.
- Ripristina il database eseguendo il file `.sql` con `mysql`.

Internamente esegue:  
```sh
docker-compose exec db bash -c 'LATEST_DB=$(ls -t /backup/wpdb-backup-*.sql | head -n 1); mysql -u ${MYSQL_USER} -p${WORDPRESS_DB_PASSWORD} ${MYSQL_DATABASE} < $$LATEST_DB'
```
---

## 🚀 Come usare il sistema di backup e ripristino
Esempi di utilizzo:

- Creare un backup completo:  
  make backup

- Ripristinare il backup più recente:  
  make restore

- Eseguire il backup solo dei file WordPress:  
  make backup-files

- Eseguire il backup solo del database:  
  make backup-db

- Ripristinare solo i file WordPress:  
  make restore-files

- Ripristinare solo il database:  
  make restore-db

---

## 🎯 Conclusione
Questo sistema di backup e ripristino è fondamentale per garantire la sicurezza e la facilità di gestione del progetto.  
Tutti i backup vengono archiviati automaticamente con timestamp, rendendo semplice il ripristino in caso di necessità.

# 📥 Importazione di un sito WordPress in Docker

## 📌 Introduzione
L'importazione di un sito WordPress esistente permette di caricare rapidamente un'installazione preesistente all'interno del progetto Docker.  
Questo processo include l'importazione dei **file di WordPress** e del **database MySQL**, mantenendo la configurazione già esistente.

---

## 🔍 Struttura dell'Importazione

### **1️⃣ Modifica dei permessi sugli script di importazione**
Per assicurarsi che gli script di importazione siano eseguibili, vengono modificati i permessi dei file necessari.  
Questa operazione viene eseguita automaticamente.

---

### **2️⃣ Esecuzione dell'importazione**
L'importazione avviene in due fasi:

- **Importazione dei file di WordPress**
    - Vengono estratti i file presenti nella cartella `/data/import/`.
    - I file vengono copiati nella directory di WordPress dentro il container.

- **Importazione del database**
    - Il file `.sql` viene caricato nel database MySQL del container.
    - Il database esistente viene eliminato e ricreato con i nuovi dati importati.

Una volta completato il processo, WordPress sarà disponibile con il contenuto importato.

---

## 🚀 Come eseguire l'importazione

Per avviare l'importazione di un sito WordPress, eseguire:  
make import-wordpress

📌 **Requisiti per l'importazione:**
- Posizionare i file di WordPress in `/data/import/wp-files.zip` o `/data/import/wp-files.tar.gz`.
- Posizionare il dump del database in `/data/import/wp-database.sql`.
- Assicurarsi che i file siano leggibili e utilizzabili dal container.

---

## 🎯 Conclusione
Il comando di importazione consente di trasferire un'installazione WordPress esistente nel progetto Docker,  
semplificando il processo di migrazione o ripristino di un sito senza necessità di interventi manuali.  
Una volta completata l'importazione, il sito sarà pronto per essere utilizzato.  