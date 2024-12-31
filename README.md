<p>
  <a href="https://www.docker.com/" target="_blank">
    <img src="https://www.docker.com/wp-content/uploads/2022/03/Moby-logo.png" width="400" alt="docker-logo">
  </a>  
  <a href="https://laravel.com" target="_blank">
    <img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="laravel-logo">
  </a>
</p>

# http-docker

This project provides a collection of Docker containers designed to streamline local development setups for Laravel
applications.
It includes containers for running a PHP environment, PostgreSQL database, an SMTP server for email 
testing, and a Nginx web server.
Each container is configured using Dockerfiles and a `docker-compose.yml` file, 
enabling developers to quickly spin up an environment tailored for modern web development.

## Purpose

The main purpose of this project is to:

- Simplify the process of setting up a development environment using Docker.
- Provides a unified ecosystem for building and testing Laravel applications.
- Include additional tools like Xdebug for debugging, Mailpit for email testing, and PostgreSQL as a database backend.

This setup is ideal for developers who want a pre-configured, containerized development environment.

---

## Project Structure

- **`php84.Dockerfile`**:
    - Builds a PHP 8.4 environment with FPM.
    - Includes support for PostgreSQL (`pdo_pgsql`), GD for image manipulation, Composer, and Node.js.
    - Configures Xdebug for PHP debugging.

- **`postgres17.Dockerfile`**:
    - Builds a PostgreSQL 17 database container.
    - Relies on environment variables from `.env` for database credentials.

- **`mailpit12.Dockerfile`**:
    - Create an SMTP testing server using Mailpit.
    - Useful for capturing and testing outgoing emails in development environments.

- **`nginx12.Dockerfile`**:
    - Configures a Nginx web server using the provided `vhost.conf` file.
    - Supports PHP applications and restricts access to sensitive files.

- **`vhost.exemple.conf`**:
    - Template file to define the Nginx virtual host configuration.
    - Supports PHP routing and implements basic security rules.
    - Developers should copy this to `web/vhost.conf` and adjust the values as needed.

- **`.env.example`**:
    - Template file for defining environment variables (e.g., PostgreSQL credentials).
    - Developers should copy this to `.env` and adjust the values as needed.

- **`docker-compose.yml`**:
    - Orchestrates all containers and defines their configurations, networking, volume mappings, and exposed ports.

---

## Running the Project Locally

Follow these steps to set up and run the project on your local machine.

### 1. Prerequisites

Ensure the following is installed on your system:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### 2. Clone the Repository

Clone the repository from your version control system.

```shell script
git clone <repository-url>
cd <repository-folder>
```

### 3. Set Up Environment Variables

Create a copy of the `.env.example` file and rename it to `.env`.

```shell script
cp .env.example .env
```

Edit the `.env` file to set your PostgreSQL credentials and database name as needed:

```dotenv
POSTGRES_USER=your_username
POSTGRES_PASSWORD=your_password
POSTGRES_DB=your_database
```

### 4. Set Up Nginx vhost.conf file

Create a copy of the `web/vhost.exemple.conf` file and rename it to `web/vhost.conf`.

```shell script
cp web/vhost.exemple.conf web/vhost.conf
```

Edit the `web/vhost.conf` file to set the Nginx working directory.
To do this, rename `NGINX_WORKING_DIR` variable in the root directive.
You can adjust another config as needed.

### 5. Build and Start the Containers

Use the following command to build and start the Docker containers:

```shell script
docker-compose up --build -d
```

- `--build`: Ensures all Docker containers are rebuilt using the latest configurations.
- `-d`: Runs the containers in detached mode (in the background).

### 6. Verify Running Containers

To verify the running containers, execute:

```shell script
docker ps
```

You should see the following containers running:

- PHP (Container name: `php84`)
- Nginx (Container name: `nginx12`)
- PostgreSQL (Container name: `postgres17`)
- Mailpit (Container name: `mailpit12`)

### 7. File and Port Mappings

- **PHP (php84)**:
    - Port: `5173` (adjustable in `docker-compose.yml`)

- **Nginx (nginx12)**:
    - Port: `8084` (adjustable in `docker-compose.yml`)

- **PostgreSQL (postgres17)**:
    - Port: `5432` (adjustable in `docker-compose.yml`)

- **Mailpit (mailpit12)**:
    - Web Interface: `http://localhost:8025`
    - SMTP Port: `1025`

### 8. Testing the Setup

#### Nginx

Visit `http://localhost:8084` in your browser to check the Nginx server.

#### Mailpit

Mailpit’s interface is accessible at `http://localhost:8025`. You can use SMTP testing on port `1025`.

#### Database

Connect to the PostgreSQL container using your preferred database client or via the command line:

```shell script
psql -h localhost -U your_username -d your_database
```

Use the credentials set in the `.env` file.

---

## Additional Notes

- **Debugging with Xdebug**:
    - Xdebug is pre-installed and configured in the PHP container for remote debugging.
    - Ensure your IDE (like PhpStorm) is configured to work with Xdebug. Use the `xdebug.ini` file for reference.

- **Volume Mappings**:
    - Shared volumes ensure changes to your files on the host machine are reflected inside the containers.

- **Data Persistence**:
    - PostgreSQL and Mailpit use persistent storage to preserve data across container restarts (`postgresql17-data` and
      `mailpit12-data` volumes).

---

## Shutdown

To stop the containers, run:

```shell script
docker-compose down
```

## Starting

To start the containers, run:

```shell script
docker-compose up -d
```

To remove containers, use:

```shell script
docker-compose down --volumes
```

---

Feel free to extend or modify the configurations to suit your specific project requirements!