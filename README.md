# PHP Development Environment

A Docker-based development environment for PHP projects and more (e.g. Drupal projects).

## Requirements

- Docker
- Docker Compose
- VS Code (optional, for devcontainer support)

## Setup

1. Create a `.env` file in the root directory with the following variables:

   ```
   MYSQL_ROOT_PASSWORD=your_root_password
   MYSQL_DATABASE=drupal
   MYSQL_USER=drupal
   MYSQL_PASSWORD=your_password
   ```

2. Start the environment:

   ```
   docker-compose up -d
   ```

3. Access Drupal at http://localhost:8080

## Features

- PHP 8.3 with Apache
- MySQL 8.0 database
- Pre-configured development environment
- VS Code devcontainer support
- Custom bash prompt
- Non-root user (`dev`) for development work

## Directory Structure

- `src/` - Web root directory for Drupal installation
- `.devcontainer/` - VS Code devcontainer configuration
- `Dockerfile` - PHP/Apache container configuration
- `docker-compose.yml` - Docker Compose services configuration

## Development Workflow

1. Place your Drupal codebase in the `src/` directory
2. Connect to MySQL using:
   - Host: `db`
   - Port: `3306`
   - User: as defined in `.env`
   - Password: as defined in `.env`
   - Database: as defined in `.env`

## VS Code Integration

This project includes a devcontainer configuration for VS Code. When opening the project in VS Code with the Remote Containers extension installed, you'll be prompted to reopen the project in a container.
