from typing import List, Optional
from datetime import datetime, date
from sqlalchemy.orm import Session
from sqlalchemy import and_, or_, func

from .models import (
    Patient,
    Surgeon,
    SurgicalRobot,
    RobotModule,
    Procedure,
    SurgerySession,
    Instrument,
)


def create_patient(
    db: Session,
    mrn: str,
    full_name: str,
    dob: Optional[date] = None,
    sex: Optional[str] = None,
    blood_type: Optional[str] = None,
    allergies: Optional[str] = None,
    diagnosis: Optional[str] = None,
) -> Patient:
    patient = Patient(
        mrn=mrn,
        full_name=full_name,
        dob=dob,
        sex=sex,
        blood_type=blood_type,
        allergies=allergies,
        diagnosis=diagnosis,
    )
    db.add(patient)
    db.commit()
    db.refresh(patient)
    return patient


def get_patient_by_id(db: Session, patient_id: int) -> Optional[Patient]:
    return db.query(Patient).filter(Patient.patient_id == patient_id).first()


def get_patient_by_mrn(db: Session, mrn: str) -> Optional[Patient]:
    return db.query(Patient).filter(Patient.mrn == mrn).first()


def get_patients(db: Session, skip: int = 0, limit: int = 100) -> List[Patient]:
    return db.query(Patient).offset(skip).limit(limit).all()


def search_patients(db: Session, search_term: str) -> List[Patient]:
    search_pattern = f"%{search_term}%"
    return (
        db.query(Patient)
        .filter(
            or_(
                Patient.full_name.like(search_pattern), Patient.mrn.like(search_pattern)
            )
        )
        .all()
    )


def update_patient(db: Session, patient_id: int, **kwargs) -> Optional[Patient]:
    patient = get_patient_by_id(db, patient_id)
    if patient:
        for key, value in kwargs.items():
            if hasattr(patient, key):
                setattr(patient, key, value)
        db.commit()
        db.refresh(patient)
    return patient


def delete_patient(db: Session, patient_id: int) -> bool:
    patient = get_patient_by_id(db, patient_id)
    if patient:
        db.delete(patient)
        db.commit()
        return True
    return False


def create_surgeon(
    db: Session,
    full_name: str,
    specialty: Optional[str] = None,
    license_no: Optional[str] = None,
    experience_years: Optional[int] = None,
) -> Surgeon:
    surgeon = Surgeon(
        full_name=full_name,
        specialty=specialty,
        license_no=license_no,
        experience_years=experience_years,
    )
    db.add(surgeon)
    db.commit()
    db.refresh(surgeon)
    return surgeon


def get_surgeon_by_id(db: Session, surgeon_id: int) -> Optional[Surgeon]:
    return db.query(Surgeon).filter(Surgeon.surgeon_id == surgeon_id).first()


def get_surgeons_by_specialty(db: Session, specialty: str) -> List[Surgeon]:
    return db.query(Surgeon).filter(Surgeon.specialty == specialty).all()


def get_experienced_surgeons(db: Session, min_years: int) -> List[Surgeon]:
    return db.query(Surgeon).filter(Surgeon.experience_years >= min_years).all()


def create_robot(
    db: Session,
    model: str,
    serial_no: str,
    install_date: Optional[date] = None,
    status: str = "ready",
) -> SurgicalRobot:
    robot = SurgicalRobot(
        model=model, serial_no=serial_no, install_date=install_date, status=status
    )
    db.add(robot)
    db.commit()
    db.refresh(robot)
    return robot


def get_robot_by_id(db: Session, robot_id: int) -> Optional[SurgicalRobot]:
    return db.query(SurgicalRobot).filter(SurgicalRobot.robot_id == robot_id).first()


def get_robots_by_status(db: Session, status: str) -> List[SurgicalRobot]:
    return db.query(SurgicalRobot).filter(SurgicalRobot.status == status).all()


def get_available_robots(db: Session) -> List[SurgicalRobot]:
    return (
        db.query(SurgicalRobot).filter(SurgicalRobot.status.in_(["ready", "ok"])).all()
    )


def update_robot_status(
    db: Session, robot_id: int, new_status: str
) -> Optional[SurgicalRobot]:
    robot = get_robot_by_id(db, robot_id)
    if robot:
        robot.status = new_status
        db.commit()
        db.refresh(robot)
    return robot


def create_surgery_session(
    db: Session,
    patient_id: int,
    procedure_id: int,
    surgeon_id: int,
    robot_id: int,
    or_id: int,
    scheduled_at: Optional[datetime] = None,
    started_at: Optional[datetime] = None,
    ended_at: Optional[datetime] = None,
    outcome: Optional[str] = None,
    notes: Optional[str] = None,
) -> SurgerySession:
    session = SurgerySession(
        patient_id=patient_id,
        procedure_id=procedure_id,
        surgeon_id=surgeon_id,
        robot_id=robot_id,
        or_id=or_id,
        scheduled_at=scheduled_at,
        started_at=started_at,
        ended_at=ended_at,
        outcome=outcome,
        notes=notes,
    )
    db.add(session)
    db.commit()
    db.refresh(session)
    return session


def get_session_by_id(db: Session, session_id: int) -> Optional[SurgerySession]:
    return (
        db.query(SurgerySession).filter(SurgerySession.session_id == session_id).first()
    )


def get_sessions_by_patient(db: Session, patient_id: int) -> List[SurgerySession]:
    return (
        db.query(SurgerySession).filter(SurgerySession.patient_id == patient_id).all()
    )


def get_sessions_by_surgeon(db: Session, surgeon_id: int) -> List[SurgerySession]:
    return (
        db.query(SurgerySession).filter(SurgerySession.surgeon_id == surgeon_id).all()
    )


def get_sessions_by_date_range(
    db: Session, start_date: datetime, end_date: datetime
) -> List[SurgerySession]:
    return (
        db.query(SurgerySession)
        .filter(
            and_(
                SurgerySession.scheduled_at >= start_date,
                SurgerySession.scheduled_at <= end_date,
            )
        )
        .all()
    )


def get_upcoming_sessions(db: Session) -> List[SurgerySession]:
    now = datetime.now()
    return (
        db.query(SurgerySession)
        .filter(SurgerySession.scheduled_at > now)
        .order_by(SurgerySession.scheduled_at)
        .all()
    )


def get_surgeon_statistics(db: Session, surgeon_id: int) -> dict:
    total_operations = (
        db.query(SurgerySession).filter(SurgerySession.surgeon_id == surgeon_id).count()
    )

    return {"surgeon_id": surgeon_id, "total_operations": total_operations}


def get_robot_usage_statistics(db: Session, robot_id: int) -> dict:
    total_sessions = (
        db.query(SurgerySession).filter(SurgerySession.robot_id == robot_id).count()
    )

    sessions = (
        db.query(SurgerySession)
        .filter(
            and_(
                SurgerySession.robot_id == robot_id,
                SurgerySession.started_at.isnot(None),
                SurgerySession.ended_at.isnot(None),
            )
        )
        .all()
    )

    total_hours = sum(
        (session.ended_at - session.started_at).total_seconds() / 3600
        for session in sessions
    )

    return {
        "robot_id": robot_id,
        "total_sessions": total_sessions,
        "total_hours": round(total_hours, 2),
    }


def get_procedure_statistics(db: Session) -> List[dict]:
    results = (
        db.query(Procedure.name, func.count(SurgerySession.session_id).label("count"))
        .join(SurgerySession)
        .group_by(Procedure.procedure_id)
        .all()
    )

    return [{"procedure_name": name, "count": count} for name, count in results]
