# База даних робототехнічної хірургії - Viktor Tsvyk

## Опис проєкту

Це навчальний проєкт бази даних для системи управління робототехнічною хірургією. База даних містить інформацію про пацієнтів, хірургів, операційні зали, хірургічні роботи, процедури та всі пов'язані дані операцій.

### Особливості проекту:
- 19 таблиць з даними
- 17 Views для аналізу даних
- 4 Stored Procedures для бізнес-логіки
- Приклади агрегатних функцій та складних запитів
- Автоматичні скрипти розгортання
- Готовий дамп бази даних

## Структура бази даних

### Батьківські таблиці (5 записів кожна)

1. **patients** - Пацієнти
    - patient_id, mrn, full_name, dob, sex, blood_type, allergies, diagnosis
    - 5 унікальних пацієнтів

2. **surgeons** - Хірурги
    - surgeon_id, full_name, specialty, license_no, experience_years
    - 5 лікарів різних спеціальностей

3. **operating_rooms** - Операційні зали
    - or_id, name, floor, sterility_class
    - 5 операційних залів

4. **surgical_robots** - Хірургічні роботи
    - robot_id, model, serial_no, install_date, status
    - 5 роботів різних моделей

5. **procedures** - Процедури
    - procedure_id, name, icd_code, description
    - 5 типів хірургічних процедур

6. **instruments** - Інструменти
    - instrument_id, name, instrument_type, manufacturer, sterile_reuse_limit
    - 5 типів інструментів

7. **software_versions** - Версії програмного забезпечення
    - sw_id, version, release_date, vendor_notes
    - 5 версій ПЗ

### Дочірні таблиці (15 записів кожна)

1. **surgery_sessions** - Сесії операцій
    - Основна таблиця операцій, пов'язує пацієнтів, процедури, хірургів та роботів
    - 15 операційних сесій

2. **robot_modules** - Модулі роботів
    - Компоненти хірургічних роботів (руки, камери, консолі)
    - 15 модулів

3. **vital_signs** - Життєві показники
    - Дані моніторингу пацієнтів під час операцій
    - 15 записів

4. **anesthesia_records** - Записи анестезії
    - Інформація про анестезіологічні препарати та дозування
    - 15 записів

5. **imaging_data** - Дані зображень
    - Ендоскопічні та інші медичні зображення
    - 15 записів

6. **complications** - Ускладнення
    - Записи про ускладнення під час операцій
    - 15 записів

7. **maintenances** - Технічне обслуговування
    - Записи про обслуговування роботів
    - 15 записів

8. **calibrations** - Калібрування
    - Дані калібрування модулів роботів
    - 15 записів

9. **device_events** - Події пристроїв
    - Логи та події роботів
    - 15 записів

### Зв'язуючі таблиці (8 записів кожна)

1. **instrument_compatibilities** - Сумісність інструментів
    - Зв'язок між модулями та типами інструментів
    - 8 записів

2. **session_instrument_uses** - Використання інструментів у сесіях
    - Відстеження використання інструментів під час операцій
    - 8 записів

3. **robot_software_installs** - Встановлення ПЗ на роботи
    - Історія оновлень програмного забезпечення
    - 8 записів

## Структура проекту

```
data_base_college/
├── README.md
├── INSTRUCTIONS.md
├── ER_DIAGRAM.md
│
├── data/
│   ├── patients.csv
│   ├── surgeons.csv
│   ├── operating_rooms.csv
│   ├── surgical_robots.csv
│   ├── procedures.csv
│   ├── instruments.csv
│   ├── software_versions.csv
│   ├── surgery_sessions.csv
│   ├── robot_modules.csv
│   ├── vital_signs.csv
│   ├── anesthesia_records.csv
│   ├── imaging_data.csv
│   ├── complications.csv
│   ├── maintenances.csv
│   ├── calibrations.csv
│   ├── device_events.csv
│   ├── instrument_compatibilities.csv
│   ├── session_instrument_uses.csv
│   └── robot_software_installs.csv
│
├── schemas/
│   ├── schema_robotics_surgery_viktor_tsvyk.sql
│   ├── import_data.sql
│   ├── validate_data.sql
│   ├── views_examples.sql
│   ├── stored_procedures_examples.sql
│   └── aggregate_functions_examples.sql
│
├── scripts/
│   ├── quick_deploy.sh
│   ├── create_dump.sh
│
├── backups/
│   ├── robotics_surgery_viktor_tsvyk_dump_YYYYMMDD_HHMMSS.sql
│   └── README.md
│
```

## Ключові особливості

### Кардинальність даних

- **Батьківські таблиці**: 5 записів
- **Дочірні таблиці**: 15 записів (3 × батьківська)
- **Рівносильні таблиці**: 8 записів

### Цілісність даних

Всі зовнішні ключі правильно пов'язані між таблицями
Унікальні значення для PRIMARY KEY
Немає повторень даних
Реалістичні та різноманітні дані

### Формат даних

- Усі файли в форматі CSV з кодуванням UTF-8
- Перший рядок містить заголовки колонок
- Значення розділені комами
- Дати у форматі ISO (YYYY-MM-DD або YYYY-MM-DD HH:MM:SS)

## Швидкий старт

### Рекомендований спосіб: Автоматичне розгортання

```bash
./scripts/quick_deploy.sh
```

Цей скрипт автоматично:
1. Видалить стару БД (якщо існує)
2. Створить базу даних та всі таблиці
3. Імпортує всі дані з CSV файлів
4. Створить 17 Views
5. Створить 4 Stored Procedures
6. Виконає валідацію даних
7. Створить повний дамп БД у папці `backups/`

**Результат**: Готова база даних + дамп для резервного копіювання!

### Варіант 2: Відновлення з готового дампу

```bash
mysql -u root -p < backups/robotics_surgery_viktor_tsvyk_dump_20251031_035944.sql
```

### Варіант 3: Ручне розгортання через MySQL

```bash
mysql -u root -p --local-infile=1

SOURCE /Users/joshbuysell/Desktop/Work/data_base_college/scripts/deploy_database.sql;
```

## Робота з базою даних

### Підключення до БД

```bash
mysql -u root -p robotics_surgery_viktor_tsvyk
```

### Приклади запитів

```sql
SHOW TABLES;

SHOW FULL TABLES WHERE Table_type = 'VIEW';

SHOW PROCEDURE STATUS WHERE Db = 'robotics_surgery_viktor_tsvyk';

SELECT * FROM v_surgery_details WHERE outcome = 'success';

CALL GetPatientInfo(1);

SELECT * FROM v_surgeon_performance ORDER BY success_rate_percent DESC;
```

### Приклади агрегатних функцій

```sql
SOURCE schemas/aggregate_functions_examples.sql;
```

## Резервне копіювання

### Створити дамп БД

```bash
./create_dump.sh

mysqldump -u root -p \
    --single-transaction \
    --routines \
    --triggers \
    --events \
    --databases robotics_surgery_viktor_tsvyk \
    > backup.sql
```

### Відновити з дампу

```bash
mysql -u root -p < backups/robotics_surgery_viktor_tsvyk_dump_YYYYMMDD_HHMMSS.sql
```

## Аналіз даних

### Доступні Views (15):

1. `v_patient_overview` - Огляд пацієнтів
2. `v_surgery_details` - Детальна інформація про операції
3. `v_surgeon_performance` - Статистика по хірургам
4. `v_robot_utilization` - Використання роботів
5. `v_vital_signs_summary` - Зведення життєвих показників
6. `v_active_sessions` - Активні сесії
7. `v_maintenance_schedule` - Графік обслуговування
8. `v_complications_report` - Звіт про ускладнення
9. `v_instrument_usage` - Використання інструментів
10. `v_operating_room_schedule` - Розклад операційних
11. `v_robot_health_status` - Стан роботів
12. `v_anesthesia_log` - Лог анестезії
13. `v_patient_full_history` - Повна історія пацієнтів
14. `v_surgery_statistics` - Статистика операцій
15. `v_device_events_summary` - Зведення подій пристроїв

### Доступні Stored Procedures (4):

1. `GetAllPatients()` - Отримати всіх пацієнтів
2. `GetPatientInfo(patient_id)` - Детальна інформація про пацієнта
3. `GetSurgeonStatistics(surgeon_id, OUT ...)` - Статистика хірурга
4. `GetRobotStatus(robot_id)` - Статус робота з діагностикою

## Перевірка даних

```bash
mysql -u root -p robotics_surgery_viktor_tsvyk < schemas/validate_data.sql
```

Або через скрипт розгортання - валідація виконується автоматично.

## Діаграма зв'язків

Детальна ER-діаграма доступна в файлі `ER_DIAGRAM.md`

Основні зв'язки:
```
patients (1) ──▶ surgery_sessions (N)
surgeons (1) ──▶ surgery_sessions (N)
procedures (1) ──▶ surgery_sessions (N)
surgical_robots (1) ──▶ surgery_sessions (N)
surgery_sessions (1) ──▶ vital_signs (N)
surgery_sessions (1) ──▶ complications (N)
```

## Технології та інструменти

- **СУБД**: MySQL 8.0+
- **Мова запитів**: SQL
- **Формат даних**: CSV (UTF-8)
- **Скрипти**: Bash (для автоматизації)

## Навчальні матеріали

Проект включає практичні приклади:

- **Aggregate Functions** - COUNT, SUM, AVG, MIN, MAX, GROUP_CONCAT
- **JOIN** - INNER JOIN, LEFT JOIN, множинні JOIN
- **GROUP BY** з HAVING
- **Subqueries** - підзапити для складного аналізу
- **Views** - 15 представлень для різних потреб
- **Stored Procedures** - процедури з IN, OUT, INOUT параметрами
- **Transactions** - робота з транзакціями
- **Error Handling** - обробка помилок у процедурах

## Випадки використання

### Для студентів:
- Вивчення SQL на реалістичних даних
- Практика з агрегатними функціями
- Розробка складних запитів
- Робота з Views та Stored Procedures

### Для викладачів:
- Готовий навчальний проект
- Приклади для демонстрації концепцій SQL
- База для лабораторних робіт
- Різноманітні сценарії запитів

## Важливі примітки

1. **Перед імпортом даних** переконайтеся що в MySQL ввімкнено `local_infile`:
   ```sql
   SET GLOBAL local_infile = 1;
   ```

2. **Шляхи до файлів** у `import_data.sql` можуть потребувати корекції під вашу систему.

3. **Права доступу** - для виконання bash скриптів потрібно спочатку надати права:
   ```bash
   chmod +x create_dump.sh
   chmod +x quick_deploy.sh
   ```

4. **Резервні копії** зберігаються в папці `backups/` і не видаляються автоматично.

## Підтримка

Для питань та пропозицій:
- Перевірте документацію в `INSTRUCTIONS.md`
- Перегляньте ER-діаграму в `ER_DIAGRAM.md`
