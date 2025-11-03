# Інструкція з використання бази даних

## Встановлення та налаштування

### Крок 1: Підготовка середовища

Переконайтеся, що у вас встановлено:
- MySQL Server 8.0 або новіша версія
- MySQL Workbench (опціонально, для візуального інтерфейсу)

### Крок 2: Створення бази даних

#### Варіант A: Через командний рядок

```bash
mysql -u root -p

CREATE DATABASE robotics_surgery_viktor_tsvyk;
USE robotics_surgery_viktor_tsvyk;

SOURCE /Users/joshbuysell/Desktop/Work/data_base_college/schemas/schema_robotics_surgery_viktor_tsvyk.sql;
```

#### Варіант B: Через MySQL Workbench

1. Відкрийте MySQL Workbench
2. Підключіться до вашого сервера
3. Виконайте SQL скрипт `schema_robotics_surgery_viktor_tsvyk.sql`

### Крок 3: Імпорт даних

#### Спосіб 1: Автоматичний імпорт (рекомендовано)

```bash
mysql -u root -p --local-infile=1

SOURCE /Users/joshbuysell/Desktop/Work/data_base_college/schemas/import_data.sql;
```

**ВАЖЛИВО:** Перед виконанням відредагуйте файл `import_data.sql` та замініть шлях `/Users/joshbuysell/Desktop/Work/data_base_college/` на ваш реальний шлях до папки проєкту.

#### Спосіб 2: Ручний імпорт через MySQL Workbench

1. Відкрийте MySQL Workbench
2. Виберіть таблицю
3. Права кнопка миші → Table Data Import Wizard
4. Виберіть відповідний CSV файл
5. Налаштуйте відповідність колонок
6. Виконайте імпорт

#### Спосіб 3: Імпорт кожної таблиці окремо

```sql
LOAD DATA LOCAL INFILE '/шлях/до/data/patients.csv'
INTO TABLE patients
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

### Крок 4: Перевірка даних

Запустіть скрипт валідації:

```bash
mysql -u root -p robotics_surgery_viktor_tsvyk < /Users/joshbuysell/Desktop/Work/data_base_college/schemas/validate_data.sql
```

Або в MySQL консолі:

```sql
SOURCE /Users/joshbuysell/Desktop/Work/data_base_college/schemas/validate_data.sql;
```

## Перевірка кардинальності

Після імпорту перевірте кількість записів:

```sql
USE robotics_surgery_viktor_tsvyk;

SELECT 'patients' as table_name, COUNT(*) as count FROM patients
UNION ALL SELECT 'surgeons', COUNT(*) FROM surgeons
UNION ALL SELECT 'operating_rooms', COUNT(*) FROM operating_rooms
UNION ALL SELECT 'surgical_robots', COUNT(*) FROM surgical_robots
UNION ALL SELECT 'procedures', COUNT(*) FROM procedures
UNION ALL SELECT 'instruments', COUNT(*) FROM instruments
UNION ALL SELECT 'software_versions', COUNT(*) FROM software_versions;

SELECT 'surgery_sessions' as table_name, COUNT(*) as count FROM surgery_sessions
UNION ALL SELECT 'robot_modules', COUNT(*) FROM robot_modules
UNION ALL SELECT 'vital_signs', COUNT(*) FROM vital_signs
UNION ALL SELECT 'anesthesia_records', COUNT(*) FROM anesthesia_records
UNION ALL SELECT 'imaging_data', COUNT(*) FROM imaging_data
UNION ALL SELECT 'complications', COUNT(*) FROM complications
UNION ALL SELECT 'maintenances', COUNT(*) FROM maintenances
UNION ALL SELECT 'calibrations', COUNT(*) FROM calibrations
UNION ALL SELECT 'device_events', COUNT(*) FROM device_events;

SELECT 'instrument_compatibilities' as table_name, COUNT(*) as count FROM instrument_compatibilities
UNION ALL SELECT 'session_instrument_uses', COUNT(*) FROM session_instrument_uses
UNION ALL SELECT 'robot_software_installs', COUNT(*) FROM robot_software_installs;
```

## Приклади запитів

### Основні SELECT запити

```sql
SELECT * FROM patients;

SELECT 
    s.session_id,
    p.full_name AS patient_name,
    pr.name AS procedure_name,
    sr.full_name AS surgeon_name,
    s.scheduled_at,
    s.outcome
FROM surgery_sessions s
JOIN patients p ON s.patient_id = p.patient_id
JOIN procedures pr ON s.procedure_id = pr.procedure_id
JOIN surgeons sr ON s.surgeon_id = sr.surgeon_id
ORDER BY s.scheduled_at;

SELECT 
    s.full_name,
    s.specialty,
    COUNT(ss.session_id) as total_surgeries
FROM surgeons s
LEFT JOIN surgery_sessions ss ON s.surgeon_id = ss.surgeon_id
GROUP BY s.surgeon_id, s.full_name, s.specialty
ORDER BY total_surgeries DESC;

SELECT 
    sr.model,
    sr.serial_no,
    sr.status,
    rm.module_type,
    rm.position_no,
    rm.status as module_status
FROM surgical_robots sr
JOIN robot_modules rm ON sr.robot_id = rm.robot_id
ORDER BY sr.robot_id, rm.position_no;
```

### JOIN запити

```sql
SELECT 
    ss.session_id,
    p.full_name,
    vs.timestamp,
    vs.hr,
    vs.bp_syst,
    vs.bp_diast,
    vs.spo2
FROM surgery_sessions ss
JOIN patients p ON ss.patient_id = p.patient_id
JOIN vital_signs vs ON ss.session_id = vs.session_id
ORDER BY ss.session_id, vs.timestamp;

SELECT 
    ss.session_id,
    p.full_name AS patient,
    i.name AS instrument,
    siu.attached_at,
    siu.detached_at,
    siu.uses_count
FROM session_instrument_uses siu
JOIN surgery_sessions ss ON siu.session_id = ss.session_id
JOIN patients p ON ss.patient_id = p.patient_id
JOIN instruments i ON siu.instrument_id = i.instrument_id
ORDER BY ss.session_id;
```

### Агрегатні функції

```sql
SELECT 
    severity,
    COUNT(*) as count
FROM complications
GROUP BY severity
ORDER BY FIELD(severity, 'mild', 'moderate', 'severe', 'critical');

SELECT 
    pr.name,
    COUNT(*) as operations_count,
    AVG(TIMESTAMPDIFF(MINUTE, ss.started_at, ss.ended_at)) as avg_duration_minutes
FROM surgery_sessions ss
JOIN procedures pr ON ss.procedure_id = pr.procedure_id
WHERE ss.started_at IS NOT NULL AND ss.ended_at IS NOT NULL
GROUP BY pr.procedure_id, pr.name;
```

## Можливі проблеми та рішення

### Проблема 1: Помилка при імпорті "local_infile is disabled"

**Рішення:**
```sql
SET GLOBAL local_infile = 1;
```

І запустіть MySQL клієнт з опцією:
```bash
mysql -u root -p --local-infile=1
```

### Проблема 2: Помилка кодування символів

**Рішення:**
```sql
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
```

### Проблема 3: Помилка зовнішніх ключів

**Рішення:**
Переконайтеся що імпортуєте таблиці в правильному порядку:
1. Спочатку батьківські таблиці
2. Потім дочірні таблиці
3. В кінці зв'язуючі таблиці

Або тимчасово вимкніть перевірку:
```sql
SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 1;
```

## Експорт даних

Для експорту даних назад в CSV:

```sql
SELECT * FROM patients
INTO OUTFILE '/tmp/patients_export.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
```

## Рекомендації безпеки

1. Не використовуйте root акаунт для роботи з даними
2. Створіть окремого користувача з обмеженими правами:

```sql
CREATE USER 'robot_surgery_user'@'localhost' IDENTIFIED BY 'ваш_пароль';
GRANT SELECT, INSERT, UPDATE, DELETE ON robotics_surgery_viktor_tsvyk.* TO 'robot_surgery_user'@'localhost';
FLUSH PRIVILEGES;
```

## Додаткові ресурси

- [MySQL Documentation](https://dev.mysql.com/doc/)
- [MySQL Workbench Manual](https://dev.mysql.com/doc/workbench/en/)
- [SQL Tutorial](https://www.w3schools.com/sql/)

