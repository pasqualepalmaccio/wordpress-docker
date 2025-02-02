# 📌 Docker Compose e .env – Configurazione del progetto WordPress con Docker

## 🛠 Introduzione

Questo progetto fornisce un ambiente di sviluppo per **WordPress completamente containerizzato** utilizzando **Docker e Docker Compose**.  
Grazie a questa configurazione, puoi avviare un sito WordPress in locale senza dover installare manualmente **PHP, MySQL, Apache, Redis** o altri servizi.

L’intero stack è gestito tramite **Docker Compose**, che permette di definire e orchestrare i servizi necessari in un unico file YAML.  
Le credenziali e le configurazioni variabili sono invece gestite tramite un file **.env**, semplificando la personalizzazione dell’ambiente.

Questa documentazione fornisce una guida dettagliata su come utilizzare e configurare il progetto, spiegando ogni servizio contenuto nel **docker-compose.yml**, le variabili d'ambiente nel **.env**, e le operazioni di gestione tramite **Makefile** e **WP-CLI**.

---

## 📌 Caratteristiche principali

✅ **WordPress completamente containerizzato** con configurazione personalizzabile.  
✅ **Supporto per Redis** per migliorare le prestazioni della cache.  
✅ **Integrazione con Varnish** per caching avanzato lato server.  
✅ **Configurazione PHP ottimizzata** con estensioni per WordPress.  
✅ **Facile gestione tramite WP-CLI** per installazione di plugin, temi e manutenzione del database.  
✅ **Makefile per automazione delle operazioni più comuni**, come avvio, backup e importazione.

---

## 🔧 Requisiti

Per utilizzare il progetto, devi avere installati i seguenti strumenti:

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Make (GNU Make)](https://www.gnu.org/software/make/) (opzionale, ma consigliato)

---

## 🚀 Avvio rapido

Per avviare rapidamente il progetto, segui questi passaggi:

```sh
# 1️⃣ Clona il repository
git clone https://github.com/tuo-utente/wordpress-docker.git
cd wordpress-docker

# 2️️⃣ Avvia il progetto
make start