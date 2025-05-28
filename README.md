# Mini-Project-Practice


# 💰 Expense – Daily Expense Tracker

This is a simple 3-tier architecture project to track daily expenses.  
It includes a **Frontend** (Nginx web server), **Backend** (Node.js application), and a **Database** (MySQL).

## 🧱 Architecture Overview

- **Frontend:** Nginx serves the static web application
- **Backend:** Node.js handles API logic and data processing
- **Database:** MySQL stores expense records securely

## 🖥️ Architecture Diagram

![image](https://github.com/user-attachments/assets/890e8b29-f34a-442d-ace3-7371352a66fc)

## 🚀 Purpose

Helps users log, manage, and review their day-to-day expenses via a clean web interface.

## ⚙️ Technologies Used

- **Frontend:** Nginx
- **Backend:** Node.js
- **Database:** MySQL

## 🛠 Deployment

Each tier runs on a dedicated server:
- Frontend: Serves UI via Nginx
- Backend: Listens for API requests (Node.js)
- Database: MySQL handles data storage and retrieval

---

This project is ideal for learning full-stack deployment, system design, and basic expense management.


## 📂 Project Structure

Mini-Project-Practice/
├── backend/
│   ├── backend.md
│   ├── backend.service
│   ├── backend.sh
├── frontend/
│   ├── frontend.md
│   ├── frontend.sh
│   ├── expense.conf
├── mysql/
│   ├── mysql.md
│   ├── mysql.sh
└── README.md

## 🚀 Setup Instructions
1. Database Setup (MySQL)

Navigate to the mysql directory.

Execute the SQL scripts to set up the database schema and tables.

2. Backend Setup (Node.js)

Navigate to the backend directory.

Install dependencies:

```
npm install
```

3. Frontend Setup (Nginx)

Navigate to the frontend directory.

Configure Nginx to serve the static files.
