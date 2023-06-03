# Nexis
Nexis is an Easy Django Project for a Machine Learning's Website, it's a Full Stack Project, as Database uses MySQL, below this message you'll getting started.

## How to Setup Database using MySql and initialize your Project
To Setup MySQL Database, please make sure u have already installed MySQL.
- Modify the following code in `nexis/settings.py`:
    ```
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.sqlite3',
            'NAME': os.path.join(BASE_DIR, "db.sqlite3"),
        }
    }
    ``` 
    to
    ```
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.mysql',
            'NAME': '<your_database_name>',
            'USER': '<your_username>',
            'PASSWORD': '<your_password>',
            'HOST': '<your_host>',
            'PORT': '3306',
        }
    }
    ```
    Please make sure to rename `<your_database_name>`, `<your_username>`, `<your_password>` and `<your_host>` with your MySQL Credentials

- Modify the file `mydb.py` located at the root of the project

- Finally you can run `python mydb.py` and if everything is done correctlly, you are gonna see `All done`

- Once the Database is setted up, you have to install requirements running `pip install -r requirements.txt`, if you got an error try to run  `pip install -r dev.txt`

- Now just run `python manage.py collectstatic --noinput`, then run `python manage.py migrate` and `python manage.py createsuperuser` and insert your details, finally you can run `python manage.py runserver` and be able to access the [Homepage](http://127.0.0.1:8000)

# How to Setup Emails in Django?
To be able to send Emails using Django, you have to follow this steps:
- Replace the following code with your informations
    ```
    EMAIL_USE_TLS = True
    EMAIL_HOST = '<your_smtp_host>'
    EMAIL_HOST_USER = '<your_email>'
    EMAIL_HOST_PASSWORD = '<your_password_email>'
    EMAIL_PORT = 587
    ```
- Save your code

Now you are ready to have fun with Nexis

# Change your email data
For sending email you have to modify the code in nexis/info.py.example
    ```
    EMAIL_USE_TLS = True
    EMAIL_HOST = '<your_smtp_host>'
    EMAIL_HOST_USER = '<your_email>'
    EMAIL_HOST_PASSWORD = '<your_password_email>'
    EMAIL_PORT = '<your_email_port>'
    ```
Then run `cp nexis/info.py.example nexis/info.py`

Make sure to modify `<your_smtp_host>`, `<yout_email>`, `<your_password_email>` and `<your_email_port>` with your credentials