from datetime import datetime, date
from sqlalchemy.orm import Session
from orm import (
    SessionLocal,
    Patient,
    Surgeon,
    SurgicalRobot,
    SurgerySession,
    Procedure,
    OperatingRoom,
)


def create_sample_data():
    db = SessionLocal()
    try:
        patient = Patient(
            mrn="MRN123456",
            full_name="Іван Петренко",
            dob=date(1975, 5, 15),
            sex="M",
            blood_type="A+",
            allergies="Пеніцилін",
            diagnosis="Проблеми з жовчним міхуром",
        )
        db.add(patient)

        surgeon = Surgeon(
            full_name="Др. Олена Коваленко",
            specialty="Загальна хірургія",
            license_no="LIC98765",
            experience_years=15,
        )
        db.add(surgeon)

        operating_room = OperatingRoom(name="OR-1", floor=3, sterility_class="Class I")
        db.add(operating_room)

        robot = SurgicalRobot(
            model="da Vinci Xi",
            serial_no="SN-DV-2023-001",
            install_date=date(2023, 1, 15),
            status="ready",
        )
        db.add(robot)

        procedure = Procedure(
            name="Лапароскопічна холецистектомія",
            icd_code="51.23",
            description="Видалення жовчного міхура з використанням роботизованої системи",
        )
        db.add(procedure)

        db.commit()

        surgery_session = SurgerySession(
            patient_id=patient.patient_id,
            procedure_id=procedure.procedure_id,
            surgeon_id=surgeon.surgeon_id,
            robot_id=robot.robot_id,
            or_id=operating_room.or_id,
            scheduled_at=datetime(2025, 11, 10, 9, 0),
            started_at=datetime(2025, 11, 10, 9, 15),
            ended_at=datetime(2025, 11, 10, 11, 30),
            outcome="Успішно виконано без ускладнень",
            notes="Процедура пройшла згідно плану",
        )
        db.add(surgery_session)
        db.commit()

        print("Тестові дані успішно створені!")
        print(f"Пацієнт: {patient.full_name} (ID: {patient.patient_id})")
        print(f"Хірург: {surgeon.full_name} (ID: {surgeon.surgeon_id})")
        print(f"Сесія: {surgery_session.session_id}")

    except Exception as e:
        print(f"Помилка при створенні даних: {e}")
        db.rollback()
    finally:
        db.close()


def query_examples():
    db = SessionLocal()
    try:
        print("\n" + "=" * 60)
        print("ПРИКЛАДИ ЗАПИТІВ")
        print("=" * 60)

        print("\n1. Всі пацієнти:")
        patients = db.query(Patient).all()
        for patient in patients:
            print(f"- {patient.full_name} (MRN: {patient.mrn})")

        print("\n2. Пошук пацієнта за MRN:")
        patient = db.query(Patient).filter(Patient.mrn == "MRN123456").first()
        if patient:
            print(f"Знайдено: {patient.full_name}, дата народження: {patient.dob}")

        print("\n3. Хірурги з досвідом > 10 років:")
        experienced_surgeons = (
            db.query(Surgeon).filter(Surgeon.experience_years > 10).all()
        )
        for surgeon in experienced_surgeons:
            print(f"- {surgeon.full_name}: {surgeon.experience_years} років")

        print("\n4. Сесії пацієнта з деталями:")
        sessions = (
            db.query(SurgerySession)
            .join(Patient)
            .filter(Patient.mrn == "MRN123456")
            .all()
        )
        for session in sessions:
            print(f"Сесія #{session.session_id}:")
            print(f"Процедура: {session.procedure.name}")
            print(f"Хірург: {session.surgeon.full_name}")
            print(f"Робот: {session.robot.model}")
            print(f"Час: {session.started_at} - {session.ended_at}")

        print("\n5. Роботи готові до роботи:")
        ready_robots = (
            db.query(SurgicalRobot).filter(SurgicalRobot.status == "ready").all()
        )
        for robot in ready_robots:
            print(f"- {robot.model} (S/N: {robot.serial_no})")

        print("\n6. Кількість операцій за хірургом:")
        from sqlalchemy import func

        surgeon_stats = (
            db.query(
                Surgeon.full_name,
                func.count(SurgerySession.session_id).label("operations_count"),
            )
            .join(SurgerySession)
            .group_by(Surgeon.surgeon_id)
            .all()
        )
        for name, count in surgeon_stats:
            print(f"- {name}: {count} операцій")

    finally:
        db.close()


def update_example():
    db = SessionLocal()
    try:
        print("\n" + "=" * 60)
        print("ПРИКЛАД ОНОВЛЕННЯ")
        print("=" * 60)

        robot = (
            db.query(SurgicalRobot)
            .filter(SurgicalRobot.serial_no == "SN-DV-2023-001")
            .first()
        )

        if robot:
            old_status = robot.status
            robot.status = "maintenance"
            db.commit()
            print(f"\nСтатус робота {robot.model} змінено:")
            print(f"{old_status} → {robot.status}")

    except Exception as e:
        print(f"Помилка при оновленні: {e}")
        db.rollback()
    finally:
        db.close()


def delete_example():
    db = SessionLocal()
    try:
        print("\n" + "=" * 60)
        print("ПРИКЛАД ВИДАЛЕННЯ")
        print("=" * 60)

        procedure = db.query(Procedure).filter(Procedure.icd_code == "51.23").first()

        if procedure:
            proc_name = procedure.name
            sessions_count = (
                db.query(SurgerySession)
                .filter(SurgerySession.procedure_id == procedure.procedure_id)
                .count()
            )

            if sessions_count > 0:
                print(
                    f"\nПроцедура '{proc_name}' використовується в {sessions_count} сесіях."
                )
                print("Видалення скасовано для збереження цілісності даних.")
            else:
                db.delete(procedure)
                db.commit()
                print(f"\nПроцедура '{proc_name}' видалена")

    except Exception as e:
        print(f"Помилка при видаленні: {e}")
        db.rollback()
    finally:
        db.close()


if __name__ == "__main__":
    print("=" * 60)
    print("ДЕМОНСТРАЦІЯ РОБОТИ ORM")
    print("=" * 60)

    create_sample_data()
    query_examples()
