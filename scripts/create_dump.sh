#!/bin/bash

DB_NAME="robotics_surgery_viktor_tsvyk"
DB_USER="root"
PROJECT_DIR="/Users/joshbuysell/Desktop/Work/data_base_college"
BACKUP_DIR="$PROJECT_DIR/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

mkdir -p "$BACKUP_DIR"

echo "=========================================="
echo "Створення дампу бази даних"
echo "=========================================="
echo ""
echo "Введіть пароль MySQL:"
read -s DB_PASS

DUMP_FILE="$BACKUP_DIR/${DB_NAME}_dump_${TIMESTAMP}.sql"
echo ""
echo "Створення повного дампу..."
mysqldump -u "$DB_USER" -p"$DB_PASS" \
    --single-transaction \
    --routines \
    --triggers \
    --events \
    --add-drop-database \
    --databases $DB_NAME > "$DUMP_FILE"

if [ $? -eq 0 ]; then
    DUMP_SIZE=$(du -h "$DUMP_FILE" | cut -f1)
    echo "Дамп створено: $DUMP_FILE"
    echo "  Розмір: $DUMP_SIZE"
else
    echo "Помилка створення дампу"
    exit 1
fi

echo ""
echo "Готово!"
