# Use a Python base image
FROM python:3.9-slim as base

# Set environment variables
ENV POETRY_VERSION=1.4.2 \
    POETRY_HOME="/opt/poetry" \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python -

# Add Poetry to PATH
ENV PATH="$POETRY_HOME/bin:$PATH"

# Create a directory for our app
WORKDIR /app

# Copy only pyproject.toml and poetry.lock to cache layers
COPY pyproject.toml poetry.lock /app/

# Install dependencies
RUN poetry install --no-root --without dev

# Copy the rest of the source code
COPY . /app

# Install the project in editable mode (optional but often useful)
RUN poetry install --without dev

# Expose the default port (e.g., for Jupyter or an API)
EXPOSE 8888

# Default command: run Jupyter notebook or an API. Adjust as you like:
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
