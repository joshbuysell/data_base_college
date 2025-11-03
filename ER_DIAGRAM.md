# ER-діаграма: Робототехнічна хірургія

## Схема зв'язків між таблицями

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                        БАТЬКІВСЬКІ ТАБЛИЦІ (5 записів)                       │
└──────────────────────────────────────────────────────────────────────────────┘

┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│    PATIENTS     │     │    SURGEONS     │     │    PROCEDURES   │
├─────────────────┤     ├─────────────────┤     ├─────────────────┤
│ patient_id (PK) │     │ surgeon_id (PK) │     │ procedure_id(PK)│
│ mrn (UNIQUE)    │     │ full_name       │     │ name            │
│ full_name       │     │ specialty       │     │ icd_code        │
│ dob             │     │ license_no(UNIQ)│     │ description     │
│ sex             │     │ experience_years│     └─────────────────┘
│ blood_type      │     └─────────────────┘              │
│ allergies       │              │                       │
│ diagnosis       │              │                       │
└─────────────────┘              │                       │
        │                        │                       │
        │                        │                       │
        │     ┌──────────────────┼───────────────────────┘
        │     │                  │
        │     │                  │
        ▼     ▼                  ▼

┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│ SURGICAL_ROBOTS │     │ OPERATING_ROOMS │     │  INSTRUMENTS    │
├─────────────────┤     ├─────────────────┤     ├─────────────────┤
│ robot_id (PK)   │     │ or_id (PK)      │     │instrument_id(PK)│
│ model           │     │ name            │     │ name            │
│ serial_no(UNIQ) │     │ floor           │     │instrument_type  │
│ install_date    │     │ sterility_class │     │ manufacturer    │
│ status          │     └─────────────────┘     │sterile_reuse_lim│
└─────────────────┘              │               └─────────────────┘
        │                        │                       │
        │                        │                       │
        ├────────────────────────┼───────────────────────┘
        │                        │
        │                        │
        ▼                        │
                                 │
┌─────────────────┐              │
│SOFTWARE_VERSIONS│              │
├─────────────────┤              │
│ sw_id (PK)      │              │
│ version (UNIQUE)│              │
│ release_date    │              │
│ vendor_notes    │              │
└─────────────────┘              │
        │                        │
        │                        │
        │                        │

┌──────────────────────────────────────────────────────────────────────────────┐
│                     ЦЕНТРАЛЬНА ТАБЛИЦЯ (15 записів)                          │
└──────────────────────────────────────────────────────────────────────────────┘

                    ┌─────────────────────────┐
                    │   SURGERY_SESSIONS      │
                    ├─────────────────────────┤
                    │ session_id (PK)         │
                    │ patient_id (FK)      ───┼──▶ patients
                    │ procedure_id (FK)    ───┼──▶ procedures
                    │ surgeon_id (FK)      ───┼──▶ surgeons
                    │ robot_id (FK)        ───┼──▶ surgical_robots
                    │ or_id (FK)           ───┼──▶ operating_rooms
                    │ scheduled_at            │
                    │ started_at              │
                    │ ended_at                │
                    │ outcome                 │
                    │ notes                   │
                    └─────────────────────────┘
                                │
                ┌───────────────┼───────────────┐
                │               │               │
                ▼               ▼               ▼

┌──────────────────────────────────────────────────────────────────────────────┐
│                       ДОЧІРНІ ТАБЛИЦІ (15 записів)                           │
└──────────────────────────────────────────────────────────────────────────────┘

┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│  VITAL_SIGNS    │  │ ANESTHESIA_REC  │  │  IMAGING_DATA   │
├─────────────────┤  ├─────────────────┤  ├─────────────────┤
│ vital_id (PK)   │  │an_record_id(PK) │  │ image_id (PK)   │
│ session_id (FK) │  │ session_id (FK) │  │ session_id (FK) │
│ timestamp       │  │anesthesiolog_nm │  │ modality        │
│ hr              │  │ agent           │  │ file_uri        │
│ bp_syst         │  │ dosage          │  │ captured_at     │
│ bp_diast        │  │ route           │  │ metadata_json   │
│ spo2            │  │ timestamp       │  └─────────────────┘
│ temp            │  │ notes           │
│ etco2           │  └─────────────────┘
└─────────────────┘

┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│ COMPLICATIONS   │  │ DEVICE_EVENTS   │  │  MAINTENANCES   │
├─────────────────┤  ├─────────────────┤  ├─────────────────┤
│complication_id  │  │ event_id (PK)   │  │maintenance_id   │
│ session_id (FK) │  │ session_id (FK) │  │ robot_id (FK)   │
│ type            │  │ robot_id (FK)   │  │ performed_at    │
│ severity        │  │ module_id (FK)  │  │ type            │
│ detected_at     │  │ level           │  │ engineer_name   │
│ resolved_at     │  │ code            │  │ notes           │
│ description     │  │ message         │  │ next_due_at     │
└─────────────────┘  │ timestamp       │  └─────────────────┘
                     └─────────────────┘

┌─────────────────┐  ┌─────────────────┐
│ ROBOT_MODULES   │  │  CALIBRATIONS   │
├─────────────────┤  ├─────────────────┤
│ module_id (PK)  │  │calibration_id   │
│ robot_id (FK) ──┼──▶surgical_robots │ module_id (FK)  │
│ module_type     │  │ performed_at    │
│ position_no     │  │ method          │
│ status          │  │ result          │
└─────────────────┘  │ tolerance_mm    │
        │            └─────────────────┘
        │                     ▲
        │                     │
        └─────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│                      ЗВ'ЯЗУЮЧІ ТАБЛИЦІ (8 записів)                           │
└──────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────┐  ┌──────────────────────────┐
│INSTRUMENT_COMPATIBILITIES│  │SESSION_INSTRUMENT_USES   │
├──────────────────────────┤  ├──────────────────────────┤
│ module_id (PK, FK)    ───┼──▶robot_modules          │ session_id (PK, FK)  │
│ instrument_type (PK)     │  │ instrument_id (PK, FK)   │
└──────────────────────────┘  │ module_id (FK)           │
                              │ attached_at (PK)         │
                              │ detached_at              │
┌──────────────────────────┐  │ uses_count               │
│ ROBOT_SOFTWARE_INSTALLS  │  └──────────────────────────┘
├──────────────────────────┤
│ robot_id (PK, FK)     ───┼──▶surgical_robots
│ sw_id (PK, FK)        ───┼──▶software_versions
│ installed_at (PK)        │
└──────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│                              ЛЕГЕНДА                                          │
└──────────────────────────────────────────────────────────────────────────────┘

PK  = Primary Key (Первинний ключ)
FK  = Foreign Key (Зовнішній ключ)
──▶ = Зв'язок один-до-багатьох
◀─▶ = Зв'язок багато-до-багатьох

┌──────────────────────────────────────────────────────────────────────────────┐
│                         ТИПИ ВІДНОСИН                                         │
└──────────────────────────────────────────────────────────────────────────────┘

ОДИН-ДО-БАГАТЬОХ (1:N):
• patients (1) ──▶ surgery_sessions (N)
• surgeons (1) ──▶ surgery_sessions (N)
• procedures (1) ──▶ surgery_sessions (N)
• surgical_robots (1) ──▶ surgery_sessions (N)
• operating_rooms (1) ──▶ surgery_sessions (N)
• surgical_robots (1) ──▶ robot_modules (N)
• surgical_robots (1) ──▶ maintenances (N)
• robot_modules (1) ──▶ calibrations (N)
• surgery_sessions (1) ──▶ vital_signs (N)
• surgery_sessions (1) ──▶ anesthesia_records (N)
• surgery_sessions (1) ──▶ imaging_data (N)
• surgery_sessions (1) ──▶ complications (N)
• surgery_sessions (1) ──▶ device_events (N)

БАГАТО-ДО-БАГАТЬОХ (M:N):
• robot_modules ◀─▶ instruments (через instrument_compatibilities)
• surgery_sessions ◀─▶ instruments (через session_instrument_uses)
• surgical_robots ◀─▶ software_versions (через robot_software_installs)

┌──────────────────────────────────────────────────────────────────────────────┐
│                         КАРДИНАЛЬНІСТЬ ДАНИХ                                  │
└──────────────────────────────────────────────────────────────────────────────┘

Батьківські таблиці:       5 записів кожна
├─ patients
├─ surgeons
├─ operating_rooms
├─ surgical_robots
├─ procedures
├─ instruments
└─ software_versions

Дочірні таблиці:          15 записів кожна
├─ surgery_sessions
├─ robot_modules
├─ vital_signs
├─ anesthesia_records
├─ imaging_data
├─ complications
├─ maintenances
├─ calibrations
└─ device_events

Зв'язуючі таблиці:         8 записів кожна
├─ instrument_compatibilities
├─ session_instrument_uses
└─ robot_software_installs

ЗАГАЛОМ: 19 таблиць, 159 записів
```

## Нормалізація

База даних нормалізована до третьої нормальної форми (3NF):

- **1NF**: Всі атрибути атомарні, є первинні ключі
- **2NF**: Відсутня часткова залежність від ключа
- **3NF**: Відсутня транзитивна залежність

## Індекси

Автоматично створюються індекси для:
- Первинних ключів (PRIMARY KEY)
- Унікальних полів (UNIQUE)
- Зовнішніх ключів (FOREIGN KEY)
