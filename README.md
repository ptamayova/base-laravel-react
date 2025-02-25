# Base Laravel React

A modern web application built with Laravel 12, Inertia.js, React, and ShadcnUI, containerized with Docker.

## Technologies

This project leverages several powerful technologies:

- [Laravel 12](https://laravel.com/) - PHP web application framework
- [Inertia.js](https://inertiajs.com/) - Modern monolithic architecture connecting Laravel to React
- [React](https://reactjs.org/) - JavaScript library for building user interfaces
- [ShadcnUI](https://ui.shadcn.com/) - A collection of reusable UI components
- [FrankenPHP](https://frankenphp.dev/) - Modern PHP application server
- [Docker](https://www.docker.com/) - Containerization platform
- [SQLite](https://www.sqlite.org/) - Embedded database

## Development Setup

### Prerequisites

- Docker and Docker Compose
- Git

### Getting Started

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. Start the development environment:
   ```bash
   docker-compose up -d
   ```

3. Install PHP dependencies:
   ```bash
   docker-compose run --rm composer install
   ```

4. Install JavaScript dependencies:
   ```bash
   docker-compose run --rm npm install
   ```

5. Build frontend assets:
   ```bash
   docker-compose run --rm npm run dev
   ```

6. Generate application key:
   ```bash
   docker-compose exec app php artisan key:generate
   ```

7. Run database migrations:
   ```bash
   docker-compose exec app php artisan migrate
   ```

The application should now be accessible at `https://localhost` (you may need to accept the self-signed certificate).

For live frontend development:
```bash
docker-compose run --rm npm run dev
```

## Production Deployment

To deploy to production:

1. Ensure your environment variables are properly set for production.

2. Build and start the production containers:
   ```bash
   docker-compose -f docker-compose.prod.yml up -d
   ```

3. Run database migrations:
   ```bash
   docker-compose -f docker-compose.prod.yml exec app php artisan migrate --force
   ```

The production environment uses optimized Docker images with precompiled assets.

## Code Quality Tools

### Frontend

- **ESLint** - JavaScript linting
- **Prettier** - Code formatter
- **TypeScript** - Static type checking

Run the frontend linting:
```bash
docker-compose run --rm npm run lint
```

Format frontend code:
```bash
docker-compose run --rm npm run format
```

### Backend

- **Laravel Pint** - PHP code style fixer
- **PHPStan/Larastan** - Static analysis tool
- **Rector** - PHP code quality tool and automatic refactoring

Run the backend code style fixes:
```bash
docker-compose run --rm composer pint
```

Run static analysis:
```bash
docker-compose run --rm composer analyse
```

## Directory Structure

The project follows the standard Laravel directory structure with additional organization for React components:

- `app/` - Laravel PHP code
- `resources/js/` - React components and frontend code
- `resources/css/` - CSS and styling
- `public/` - Static assets and compiled frontend code
- `routes/` - Application routes
- `database/` - Database migrations and seeders

## License

[MIT License](LICENSE)
