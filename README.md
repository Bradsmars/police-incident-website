# 🚔 Police Incident Reporting Website (Local Version)

## 📹 Demo Video

Watch the video walkthrough of the Police Incident Reporting System:  
[![Watch the demo](https://img.youtube.com/vi/YOUR_VIDEO_ID/0.jpg)](https://www.youtube.com/watch?v=YOUR_VIDEO_ID)


This is a PHP + MariaDB web application that allows police officers to record and manage incident data involving vehicles, people, and offences.

Designed as part of MSc coursework (COMP4039).

---

## 📦 Technologies

- PHP 8.1 + Apache
- MariaDB (MySQL compatible)
- Docker + Docker Compose
- PHPmyAdmin

---

## 🛠️ How to Run Locally (on `localhost`)

### 🔄 1. Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop) installed and running
- Git Bash or terminal

---

### 📁 2. Open Terminal in Project Folder

Navigate to the folder that contains `docker-compose.yml`:

```bash
cd "C:/Users/Bradley/Documents/20504177_DB/COMP4039-CW2-psxbm3-20504177/psxbm3-20504177_Docker"

🐳 3. Start the Website with Docker
bash
Copy
Edit
docker-compose up --build
This builds and runs:

PHP + Apache server

MariaDB database

Adminer (on port 8081)

🌐 4. Access in Browser
Website: http://localhost

Adminer: http://localhost:8081


Project Structure
project-root/
├── html/                  # Frontend PHP files
│   ├── index.php
│   ├── php/
│   ├── pictures/
│   └── style/
├── mariadb/               # SQL scripts used to build DB
│   ├── 2_coursework-2-database.sql
├── docker-compose.yml
├── Dockerfile


✅ Done!
Now go to http://localhost — your site should be running with full database access.


## 🔐 Login Details

To log in to the Police Incident Reporting System, use one of the following accounts:

| Username | Password | Role          |
|----------|----------|---------------|
| mcnulty  | plod123  | Officer       |
| moreland | fuzz42   | Officer       |
| daniels  | copper99 | Administrator |


