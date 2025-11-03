#!/bin/bash

DB_NAME="robotics_surgery_viktor_tsvyk"
PROJECT_DIR="/Users/joshbuysell/Desktop/Work/data_base_college"
BACKUP_DIR="$PROJECT_DIR/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

echo "=========================================="
echo "РОЗГОРТАННЯ БАЗИ ДАНИХ"
echo "=========================================="
echo ""

echo -n "MySQL користувач [root]: "
read DB_USER
DB_USER=${DB_USER:-root}

echo -n "MySQL пароль: "
read -s DB_PASS
echo ""
echo ""

mkdir -p "$BACKUP_DIR"

echo "КРОК 1/5: Видалення старої БД та створення схеми..."
mysql -u "$DB_USER" -p"$DB_PASS" < "$PROJECT_DIR/schemas/schema_robotics_surgery_viktor_tsvyk.sql"
if [ $? -eq 0 ]; then
    echo "Схема створена"
else
    echo "Помилка створення схеми"
    exit 1
fi

echo ""
echo "КРОК 2/5: Імпорт даних..."
mysql -u "$DB_USER" -p"$DB_PASS" --local-infile=1 $DB_NAME < "$PROJECT_DIR/schemas/import_data.sql"
if [ $? -eq 0 ]; then
    echo "Дані імпортовано"
else
    echo "Помилка імпорту даних"
    exit 1
fi

echo ""
echo "КРОК 3/5: Створення Views..."
mysql -u "$DB_USER" -p"$DB_PASS" $DB_NAME < "$PROJECT_DIR/schemas/views_examples.sql"
if [ $? -eq 0 ]; then
    echo "Views створено"
else
    echo "Помилка створення Views"
    exit 1
fi

echo ""
echo "КРОК 4/5: Створення Stored Procedures..."
mysql -u "$DB_USER" -p"$DB_PASS" $DB_NAME < "$PROJECT_DIR/schemas/stored_procedures_examples.sql"
if [ $? -eq 0 ]; then
    echo "Stored Procedures створено"
else
    echo "Помилка створення Stored Procedures"
    exit 1
fi

echo ""
echo "КРОК 5/5: Валідація..."
mysql -u "$DB_USER" -p"$DB_PASS" $DB_NAME < "$PROJECT_DIR/schemas/validate_data.sql" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Валідація пройдена"
else
    echo "Валідація з попередженнями (не критично)"
fi

echo ""
echo "=========================================="
echo "СТАТИСТИКА"
echo "=========================================="
mysql -u "$DB_USER" -p"$DB_PASS" $DB_NAME -e "
SELECT 'Таблиці' as object_type, COUNT(*) as count
FROM information_schema.tables
WHERE table_schema = '$DB_NAME' AND table_type = 'BASE TABLE'
UNION ALL
SELECT 'Views', COUNT(*)
FROM information_schema.tables
WHERE table_schema = '$DB_NAME' AND table_type = 'VIEW'
UNION ALL
SELECT 'Procedures', COUNT(*)
FROM information_schema.routines
WHERE routine_schema = '$DB_NAME' AND routine_type = 'PROCEDURE';"

echo ""
echo "=========================================="
echo "СТВОРЕННЯ ДАМПУ"
echo "=========================================="
DUMP_FILE="$BACKUP_DIR/${DB_NAME}_dump_${TIMESTAMP}.sql"

mysqldump -u "$DB_USER" -p"$DB_PASS" \
    --single-transaction \
    --routines \
    --triggers \
    --events \
    --databases $DB_NAME > "$DUMP_FILE" 2>/dev/null

if [ $? -eq 0 ]; then
    DUMP_SIZE=$(du -h "$DUMP_FILE" | cut -f1)
    echo "Дамп створено: $DUMP_FILE"
    echo "  Розмір: $DUMP_SIZE"
else
    echo "Помилка створення дампу"
    exit 1
fi

echo ""
echo "=========================================="
echo "ГОТОВО!"
echo "=========================================="
echo ""
echo "Для підключення:"
echo "mysql -u $DB_USER -p $DB_NAME"
echo ""
