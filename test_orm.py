#!/usr/bin/env python3

import sys
from datetime import date, datetime


def test_import():
    print("1. Тестування імпорту модулів...")
    try:
        from orm import (
            SessionLocal,
            Patient,
            Surgeon,
            SurgicalRobot,
            Procedure,
            OperatingRoom,
        )

        print("Модулі успішно імпортовані")
        return True
    except ImportError as e:
        print(f"Помилка імпорту: {e}")
        print("Встановіть залежності: pip install -r requirements.txt")
        return False


def test_connection():
    print("\n2. Тестування підключення до БД...")
    try:
        from orm import SessionLocal, engine
        from sqlalchemy import text

        with engine.connect() as connection:
            result = connection.execute(text("SELECT 1"))
            result.fetchone()

        print("Підключення до БД успішне")
        return True
    except Exception as e:
        print(f"Помилка підключення: {e}")
        print("Перевірте налаштування в .env файлі")
        return False


def test_tables():
    print("\n3. Тестування доступу до таблиць...")
    try:
        from orm import SessionLocal, Patient

        db = SessionLocal()
        count = db.query(Patient).count()
        print(f"Доступ до таблиць працює (пацієнтів у БД: {count})")
        db.close()
        return True
    except Exception as e:
        print(f"Помилка доступу до таблиць: {e}")
        print("Можливо база даних не створена. Виконайте:")
        print("mysql < schemas/schema_robotics_surgery_viktor_tsvyk.sql")
        return False


def test_crud_operations():
    print("\n4. Тестування CRUD операцій...")
    try:
        from orm import SessionLocal, Patient

        db = SessionLocal()

        test_mrn = f"TEST_MRN_{datetime.now().strftime('%Y%m%d%H%M%S')}"
        test_patient = Patient(
            mrn=test_mrn,
            full_name="Тестовий Пацієнт",
            dob=date(1990, 1, 1),
            sex="M",
            blood_type="A+",
            diagnosis="Тест",
        )
        db.add(test_patient)
        db.commit()
        patient_id = test_patient.patient_id
        print(f"CREATE: Пацієнта створено (ID: {patient_id})")

        patient = db.query(Patient).filter(Patient.patient_id == patient_id).first()
        if patient and patient.full_name == "Тестовий Пацієнт":
            print(f"READ: Пацієнта знайдено")
        else:
            raise Exception("Не вдалося знайти створеного пацієнта")

        patient.diagnosis = "Тест (оновлено)"
        db.commit()
        db.refresh(patient)
        if patient.diagnosis == "Тест (оновлено)":
            print(f"UPDATE: Дані оновлено")

        db.delete(patient)
        db.commit()
        deleted = db.query(Patient).filter(Patient.patient_id == patient_id).first()
        if deleted is None:
            print(f"DELETE: Пацієнта видалено")
        else:
            raise Exception("Не вдалося видалити пацієнта")

        db.close()
        return True

    except Exception as e:
        print(f"Помилка CRUD операцій: {e}")
        return False


def test_relationships():
    print("\n5. Тестування зв'язків між таблицями...")
    try:
        from orm import SessionLocal, SurgerySession

        db = SessionLocal()

        session = db.query(SurgerySession).first()

        if session:
            patient_name = session.patient.full_name if session.patient else None
            surgeon_name = session.surgeon.full_name if session.surgeon else None
            robot_model = session.robot.model if session.robot else None
            procedure_name = session.procedure.name if session.procedure else None

            print(f"Relationships працюють:")
            print(f"Пацієнт: {patient_name}")
            print(f"Хірург: {surgeon_name}")
            print(f"Робот: {robot_model}")
            print(f"Процедура: {procedure_name}")
        else:
            print(f"Немає даних для тесту зв'язків")
            print(f"Завантажте дані: mysql < schemas/import_data.sql")

        db.close()
        return True

    except Exception as e:
        print(f"Помилка при роботі зі зв'язками: {e}")
        return False


def main():
    print("=" * 60)
    print("ТЕСТУВАННЯ ORM")
    print("=" * 60)

    tests = [
        test_import,
        test_connection,
        test_tables,
        test_crud_operations,
        test_relationships,
    ]

    results = []
    for test in tests:
        result = test()
        results.append(result)
        if not result and test in [test_import, test_connection]:
            break

    print("\n" + "=" * 60)
    print("РЕЗУЛЬТАТИ")
    print("=" * 60)
    passed = sum(results)
    total = len(results)
    print(f"Пройдено: {passed}/{total} тестів")

    if passed == total:
        print("\nВсі тести пройдені успішно!")
        print("\nНаступні кроки:")
        print("- Перегляньте приклади в orm/examples.py")
        print("- Вивчіть CRUD операції в orm/crud.py")
        print("- Прочитайте документацію в ORM_README.md")
        return 0
    else:
        print("\nДеякі тести не пройдені. Перевірте помилки вище.")
        return 1


if __name__ == "__main__":
    sys.exit(main())
