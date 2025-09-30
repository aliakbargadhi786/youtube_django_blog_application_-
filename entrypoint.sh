#!/bin/sh

echo "Waiting for Postgres..."
while ! nc -z db 5432; do
  sleep 1
done

echo "Postgres is up - applying migrations..."
python manage.py makemigrations --noinput
python manage.py migrate --noinput
python manage.py collectstatic --noinput

echo "Starting Django..."
exec "$@"
