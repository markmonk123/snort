#!/bin/bash
# Development environment startup script

set -e

echo "🚀 Starting Snort development environment..."

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker compose &> /dev/null && ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Use docker compose (v2) or docker-compose (v1)
if command -v docker compose &> /dev/null; then
    DOCKER_COMPOSE="docker compose"
else
    DOCKER_COMPOSE="docker-compose"
fi

# Stop any existing containers
echo "🛑 Stopping existing containers..."
$DOCKER_COMPOSE -f compose.dev.yml down

# Build and start the development environment
echo "🔨 Building development container..."
$DOCKER_COMPOSE -f compose.dev.yml build

echo "▶️  Starting development server..."
$DOCKER_COMPOSE -f compose.dev.yml up -d

echo ""
echo "✅ Development environment is ready!"
echo ""
echo "📝 Access the application at: http://localhost:5173"
echo ""
echo "📋 Useful commands:"
echo "  - View logs: $DOCKER_COMPOSE -f compose.dev.yml logs -f"
echo "  - Stop server: $DOCKER_COMPOSE -f compose.dev.yml down"
echo "  - Restart server: $DOCKER_COMPOSE -f compose.dev.yml restart"
echo "  - Access shell: $DOCKER_COMPOSE -f compose.dev.yml exec snort-dev sh"
echo ""
