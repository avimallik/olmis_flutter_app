# OLMIS: Online Lawyer Management Information System

OLMIS (Online Lawyer Management Information System) is Django application designed to register the Lawyers and other applicants to the Janata Bank PLC. Built using Django (Python), Oracle Database, and Bootstrap.

## 🏗️ Instruction video
[🔵▶️ Click to Play](https://drive.google.com/file/d/1qq1XheHXyOzYjqSc8q0V99oYfzCcOCBL/preview)

---

## 🚀 Features

- **Lawyer Registration:** Comprehensive form with dependent dropdowns for Division, Branch, Area, Country, and Bar 
- **API Integration:** Added seamless REST API for flutter application

---

## 🏗️ Technologies Used

- **Backend:** Python, Django, Oracle
- **Database:** SQL
- **Frontend:** HTML, Bootstrap 5, JavaScript (jQuery for dependent dropdowns)

---

## 📦 Installation

1. **Clone the Repository:**
    ```bash
    git clone https://github.com/avimallik/olms_lawyers_registration_django_oracle.git
    cd olms
    ```

2. **Set Up Virtual Environment (Optional but Recommended):**
    ```bash
    python -m venv venv
    source venv/bin/activate  # On Windows: venv\Scripts\activate
    ```

3. **Configure Database Connection:**
    - In `setting.py` , set your SQL credentials in DATABASES section:
      ```python
        'ENGINE': 'django.db.backends.oracle',
        'NAME': 'localhost:1521/orclpdb',
        'USER': 'django_user',
        'PASSWORD': 'django_pass',
      ```

4. **Run the Application:**
    ```VS Code Terminal
    cd olms_registration
    python manage.py runserver 0.0.0.0:8000 
    ```

    ```CMD
    ipconfig
    IPv4 Address. . . . . . . . . . . : 192.XXX.0.XXX [Based on your IP]
    ```
    - The app will run at [http://192.XXX.0.XXX:8000/]

---



