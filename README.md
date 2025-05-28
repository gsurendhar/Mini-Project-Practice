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
## 🧱 Project Structure

```bash
Mini-Project-Practice/
├── frontend/        # Nginx and static web files
├── backend/         # Node.js service and API scripts
├── mysql/           # SQL scripts and DB setup
├── expense.conf     # Nginx configuration
└── README.md

## ⚙️  Setup Instructions

1. Frontend: Configure Nginx to serve static files from the frontend/ directory.

2.Backend: Run the Node.js server from the backend/ folder.

3.Database: Use SQL scripts in mysql/ to initialize MySQL tables.

## 📝 Notes
Ensure all services (frontend, backend, and database) are running on their respective servers.

For detailed configurations, refer to the respective `*.md` files in each directory.
