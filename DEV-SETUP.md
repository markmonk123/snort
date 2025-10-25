# Snort Development Environment Setup

This guide will help you set up the Snort development environment using Docker Compose.

## Prerequisites

- Docker (v20.10 or higher)
- Docker Compose (v2.0 or higher)

## Quick Start

### Option 1: Using the Startup Script (Recommended)

Simply run the startup script:

```bash
./dev-start.sh
```

This will:
1. Stop any existing containers
2. Build the development container
3. Start the development server with hot-reloading
4. Make the app available at http://localhost:5173

### Option 2: Using Docker Compose Directly

```bash
# Build and start the development environment
docker compose -f compose.dev.yml up -d

# View logs
docker compose -f compose.dev.yml logs -f

# Stop the environment
docker compose -f compose.dev.yml down
```

## GitHub Codespaces

This repository is configured to work seamlessly with GitHub Codespaces.

1. Click the "Code" button on GitHub
2. Select "Codespaces" tab
3. Click "Create codespace on main" (or your branch)
4. Wait for the environment to build and start
5. The dev server will automatically start and open in your browser

The Codespace configuration:
- Automatically installs dependencies
- Starts the development server on port 5173
- Includes recommended VS Code extensions
- Enables hot-reloading for instant feedback

## Development Workflow

### Making Changes

The development environment is configured with hot-reloading:
1. Edit any file in the `packages/` directory
2. Save your changes
3. The browser will automatically reload with your updates

### Running Commands Inside the Container

```bash
# Access the container shell
docker compose -f compose.dev.yml exec snort-dev sh

# Run tests
docker compose -f compose.dev.yml exec snort-dev yarn test

# Run linting
docker compose -f compose.dev.yml exec snort-dev yarn pre:commit

# Build for production
docker compose -f compose.dev.yml exec snort-dev yarn build
```

### Viewing Logs

```bash
# Follow all logs
docker compose -f compose.dev.yml logs -f

# View logs for specific service
docker compose -f compose.dev.yml logs -f snort-dev
```

### Restarting the Server

```bash
# Restart the development server
docker compose -f compose.dev.yml restart

# Or rebuild if you've made changes to dependencies
docker compose -f compose.dev.yml up -d --build
```

## Troubleshooting

### Port Already in Use

If port 5173 is already in use, you can change it in `compose.dev.yml`:

```yaml
ports:
  - "5174:5173"  # Change 5174 to any available port
```

### Container Not Starting

Check the logs for errors:

```bash
docker compose -f compose.dev.yml logs snort-dev
```

### Hot Reload Not Working

Make sure the `CHOKIDAR_USEPOLLING` environment variable is set in `compose.dev.yml`:

```yaml
environment:
  - CHOKIDAR_USEPOLLING=true
```

### Permission Issues

If you encounter permission issues with node_modules, try rebuilding:

```bash
docker compose -f compose.dev.yml down -v
docker compose -f compose.dev.yml up -d --build
```

## Production Deployment

For production deployment, use the existing `compose.yml` or build production images:

```bash
# Using the production compose file
docker compose up -d

# Or build a custom production image
docker build -f Dockerfile.custom -t snort-custom .
```

## Additional Resources

- [Main README](../README.md) - Project overview and features
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)
