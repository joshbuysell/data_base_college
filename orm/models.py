from sqlalchemy import (
    BigInteger,
    String,
    Date,
    Integer,
    Text,
    Enum,
    DateTime,
    ForeignKey,
    CheckConstraint,
    DECIMAL,
    JSON,
    Column,
)
from sqlalchemy.orm import relationship, Mapped, mapped_column
from typing import Optional, List
from datetime import date, datetime
from decimal import Decimal

from .database import Base


class Patient(Base):

    __tablename__ = "patients"

    patient_id: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    mrn: Mapped[Optional[str]] = mapped_column(String(32), unique=True)
    full_name: Mapped[str] = mapped_column(String(255), nullable=False)
    dob: Mapped[Optional[date]] = mapped_column(Date)
    sex: Mapped[Optional[str]] = mapped_column(String(3))
    blood_type: Mapped[Optional[str]] = mapped_column(String(3))
    allergies: Mapped[Optional[str]] = mapped_column(Text)
    diagnosis: Mapped[Optional[str]] = mapped_column(Text)

    surgery_sessions: Mapped[List["SurgerySession"]] = relationship(
        "SurgerySession", back_populates="patient"
    )

    def __repr__(self):
        return f"<Patient(id={self.patient_id}, name='{self.full_name}', mrn='{self.mrn}')>"


class Surgeon(Base):

    __tablename__ = "surgeons"

    surgeon_id: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    full_name: Mapped[str] = mapped_column(String(255), nullable=False)
    specialty: Mapped[Optional[str]] = mapped_column(String(255))
    license_no: Mapped[Optional[str]] = mapped_column(String(64), unique=True)
    experience_years: Mapped[Optional[int]] = mapped_column(
        Integer, CheckConstraint("experience_years >= 0")
    )

    surgery_sessions: Mapped[List["SurgerySession"]] = relationship(
        "SurgerySession", back_populates="surgeon"
    )

    def __repr__(self):
        return f"<Surgeon(id={self.surgeon_id}, name='{self.full_name}', specialty='{self.specialty}')>"


class OperatingRoom(Base):

    __tablename__ = "operating_rooms"

    or_id: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    name: Mapped[str] = mapped_column(String(255), nullable=False)
    floor: Mapped[Optional[int]] = mapped_column(Integer)
    sterility_class: Mapped[Optional[str]] = mapped_column(String(255))

    surgery_sessions: Mapped[List["SurgerySession"]] = relationship(
        "SurgerySession", back_populates="operating_room"
    )

    def __repr__(self):
        return (
            f"<OperatingRoom(id={self.or_id}, name='{self.name}', floor={self.floor})>"
        )


class SurgicalRobot(Base):

    __tablename__ = "surgical_robots"

    robot_id: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    model: Mapped[str] = mapped_column(String(255), nullable=False)
    serial_no: Mapped[str] = mapped_column(String(255), unique=True, nullable=False)
    install_date: Mapped[Optional[date]] = mapped_column(Date)
    status: Mapped[str] = mapped_column(
        Enum("ok", "ready", "maintenance", "offline", name="robot_status_enum"),
        nullable=False,
    )

    modules: Mapped[List["RobotModule"]] = relationship(
        "RobotModule", back_populates="robot", cascade="all, delete-orphan"
    )
    surgery_sessions: Mapped[List["SurgerySession"]] = relationship(
        "SurgerySession", back_populates="robot"
    )
    maintenances: Mapped[List["Maintenance"]] = relationship(
        "Maintenance", back_populates="robot", cascade="all, delete-orphan"
    )
    software_installs: Mapped[List["RobotSoftwareInstall"]] = relationship(
        "RobotSoftwareInstall", back_populates="robot", cascade="all, delete-orphan"
    )
    device_events: Mapped[List["DeviceEvent"]] = relationship(
        "DeviceEvent", back_populates="robot", cascade="all, delete-orphan"
    )

    def __repr__(self):
        return f"<SurgicalRobot(id={self.robot_id}, model='{self.model}', serial='{self.serial_no}', status='{self.status}')>"


class RobotModule(Base):

    __tablename__ = "robot_modules"

    module_id: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    robot_id: Mapped[int] = mapped_column(
        BigInteger,
        ForeignKey("surgical_robots.robot_id", ondelete="CASCADE"),
        nullable=False,
    )
    module_type: Mapped[str] = mapped_column(
        Enum("arm", "camera", "console", "other", name="module_type_enum"),
        nullable=False,
    )
    position_no: Mapped[Optional[int]] = mapped_column(Integer)
    status: Mapped[Optional[str]] = mapped_column(String(255))

    robot: Mapped["SurgicalRobot"] = relationship(
        "SurgicalRobot", back_populates="modules"
    )
    compatibilities: Mapped[List["InstrumentCompatibility"]] = relationship(
        "InstrumentCompatibility", back_populates="module", cascade="all, delete-orphan"
    )
    session_instrument_uses: Mapped[List["SessionInstrumentUse"]] = relationship(
        "SessionInstrumentUse", back_populates="module"
    )
    calibrations: Mapped[List["Calibration"]] = relationship(
        "Calibration", back_populates="module", cascade="all, delete-orphan"
    )
    device_events: Mapped[List["DeviceEvent"]] = relationship(
        "DeviceEvent", back_populates="module"
    )

    def __repr__(self):
        return f"<RobotModule(id={self.module_id}, type='{self.module_type}', robot_id={self.robot_id})>"


class Instrument(Base):

    __tablename__ = "instruments"

    instrument_id: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    name: Mapped[str] = mapped_column(String(255), nullable=False)
    instrument_type: Mapped[str] = mapped_column(String(255), nullable=False)
    manufacturer: Mapped[Optional[str]] = mapped_column(String(255))
    sterile_reuse_limit: Mapped[Optional[int]] = mapped_column(Integer)

    session_uses: Mapped[List["SessionInstrumentUse"]] = relationship(
        "SessionInstrumentUse", back_populates="instrument"
    )

    def __repr__(self):
        return f"<Instrument(id={self.instrument_id}, name='{self.name}', type='{self.instrument_type}')>"


class InstrumentCompatibility(Base):

    __tablename__ = "instrument_compatibilities"

    module_id: Mapped[int] = mapped_column(
        BigInteger,
        ForeignKey("robot_modules.module_id", ondelete="CASCADE"),
        primary_key=True,
    )
    instrument_type: Mapped[str] = mapped_column(String(255), primary_key=True)

    module: Mapped["RobotModule"] = relationship(
        "RobotModule", back_populates="compatibilities"
    )

    def __repr__(self):
        return f"<InstrumentCompatibility(module_id={self.module_id}, type='{self.instrument_type}')>"


class Procedure(Base):

    __tablename__ = "procedures"

    procedure_id: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    name: Mapped[str] = mapped_column(String(255), nullable=False)
    icd_code: Mapped[Optional[str]] = mapped_column(String(16))
    description: Mapped[Optional[str]] = mapped_column(Text)

    surgery_sessions: Mapped[List["SurgerySession"]] = relationship(
        "SurgerySession", back_populates="procedure"
    )

    def __repr__(self):
        return f"<Procedure(id={self.procedure_id}, name='{self.name}', icd='{self.icd_code}')>"


class SurgerySession(Base):

    __tablename__ = "surgery_sessions"

    session_id: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    patient_id: Mapped[int] = mapped_column(
        BigInteger, ForeignKey("patients.patient_id"), nullable=False
    )
    procedure_id: Mapped[int] = mapped_column(
        BigInteger, ForeignKey("procedures.procedure_id"), nullable=False
    )
    surgeon_id: Mapped[int] = mapped_column(
        BigInteger, ForeignKey("surgeons.surgeon_id"), nullable=False
    )
    robot_id: Mapped[int] = mapped_column(
        BigInteger, ForeignKey("surgical_robots.robot_id"), nullable=False
    )
    or_id: Mapped[int] = mapped_column(
        BigInteger, ForeignKey("operating_rooms.or_id"), nullable=False
    )
    scheduled_at: Mapped[Optional[datetime]] = mapped_column(DateTime)
    started_at: Mapped[Optional[datetime]] = mapped_column(DateTime)
    ended_at: Mapped[Optional[datetime]] = mapped_column(DateTime)
    outcome: Mapped[Optional[str]] = mapped_column(Text)
    notes: Mapped[Optional[str]] = mapped_column(Text)

    __table_args__ = (
        CheckConstraint("started_at <= ended_at", name="check_session_times"),
    )

    patient: Mapped["Patient"] = relationship(
        "Patient", back_populates="surgery_sessions"
    )
    procedure: Mapped["Procedure"] = relationship(
        "Procedure", back_populates="surgery_sessions"
    )
    surgeon: Mapped["Surgeon"] = relationship(
        "Surgeon", back_populates="surgery_sessions"
    )
    robot: Mapped["SurgicalRobot"] = relationship(
        "SurgicalRobot", back_populates="surgery_sessions"
    )
    operating_room: Mapped["OperatingRoom"] = relationship(
        "OperatingRoom", back_populates="surgery_sessions"
    )

    instrument_uses: Mapped[List["SessionInstrumentUse"]] = relationship(
        "SessionInstrumentUse", back_populates="session", cascade="all, delete-orphan"
    )
    vital_signs: Mapped[List["VitalSign"]] = relationship(
        "VitalSign", back_populates="session", cascade="all, delete-orphan"
    )
    anesthesia_records: Mapped[List["AnesthesiaRecord"]] = relationship(
        "AnesthesiaRecord", back_populates="session", cascade="all, delete-orphan"
    )
    imaging_data: Mapped[List["ImagingData"]] = relationship(
        "ImagingData", back_populates="session", cascade="all, delete-orphan"
    )
    complications: Mapped[List["Complication"]] = relationship(
        "Complication", back_populates="session", cascade="all, delete-orphan"
    )
    device_events: Mapped[List["DeviceEvent"]] = relationship(
        "DeviceEvent", back_populates="session"
    )

    def __repr__(self):
        return f"<SurgerySession(id={self.session_id}, patient_id={self.patient_id}, scheduled={self.scheduled_at})>"


class SessionInstrumentUse(Base):

    __tablename__ = "session_instrument_uses"

    session_id: Mapped[int] = mapped_column(
        BigInteger,
        ForeignKey("surgery_sessions.session_id", ondelete="CASCADE"),
        primary_key=True,
    )
    instrument_id: Mapped[int] = mapped_column(
        BigInteger, ForeignKey("instruments.instrument_id"), primary_key=True
    )
    attached_at: Mapped[datetime] = mapped_column(
        DateTime, primary_key=True, nullable=False
    )
    module_id: Mapped[Optional[int]] = mapped_column(
        BigInteger, ForeignKey("robot_modules.module_id")
    )
    detached_at: Mapped[Optional[datetime]] = mapped_column(DateTime)
    uses_count: Mapped[int] = mapped_column(Integer, default=1)

    __table_args__ = (CheckConstraint("uses_count >= 0", name="check_uses_count"),)

    session: Mapped["SurgerySession"] = relationship(
        "SurgerySession", back_populates="instrument_uses"
    )
    instrument: Mapped["Instrument"] = relationship(
        "Instrument", back_populates="session_uses"
    )
    module: Mapped[Optional["RobotModule"]] = relationship(
        "RobotModule", back_populates="session_instrument_uses"
    )

    def __repr__(self):
        return f"<SessionInstrumentUse(session_id={self.session_id}, instrument_id={self.instrument_id}, attached={self.attached_at})>"


class VitalSign(Base):

    __tablename__ = "vital_signs"

    vital_id: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    session_id: Mapped[int] = mapped_column(
        BigInteger,
        ForeignKey("surgery_sessions.session_id", ondelete="CASCADE"),
        nullable=False,
    )
    timestamp: Mapped[datetime] = mapped_column(DateTime, nullable=False)
    hr: Mapped[Optional[int]] = mapped_column(Integer)
    bp_syst: Mapped[Optional[int]] = mapped_column(Integer)
    bp_diast: Mapped[Optional[int]] = mapped_column(Integer)
    spo2: Mapped[Optional[int]] = mapped_column(Integer)
    temp: Mapped[Optional[Decimal]] = mapped_column(DECIMAL(4, 1))
    etco2: Mapped[Optional[Decimal]] = mapped_column(DECIMAL(5, 2))

    session: Mapped["SurgerySession"] = relationship(
        "SurgerySession", back_populates="vital_signs"
    )

    def __repr__(self):
        return f"<VitalSign(id={self.vital_id}, session_id={self.session_id}, time={self.timestamp})>"


class AnesthesiaRecord(Base):

    __tablename__ = "anesthesia_records"

    an_record_id: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    session_id: Mapped[int] = mapped_column(
        BigInteger,
        ForeignKey("surgery_sessions.session_id", ondelete="CASCADE"),
        nullable=False,
    )
    anesthesiologist_name: Mapped[Optional[str]] = mapped_column(String(255))
    agent: Mapped[Optional[str]] = mapped_column(String(255))
    dosage: Mapped[Optional[str]] = mapped_column(String(255))
    route: Mapped[Optional[str]] = mapped_column(String(255))
    timestamp: Mapped[datetime] = mapped_column(DateTime, nullable=False)
    notes: Mapped[Optional[str]] = mapped_column(Text)

    session: Mapped["SurgerySession"] = relationship(
        "SurgerySession", back_populates="anesthesia_records"
    )

    def __repr__(self):
        return f"<AnesthesiaRecord(id={self.an_record_id}, session_id={self.session_id}, agent='{self.agent}')>"


class ImagingData(Base):

    __tablename__ = "imaging_data"

    image_id: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    session_id: Mapped[int] = mapped_column(
        BigInteger,
        ForeignKey("surgery_sessions.session_id", ondelete="CASCADE"),
        nullable=False,
    )
    modality: Mapped[str] = mapped_column(
        Enum(
            "endoscope",
            "fluoro",
            "ultrasound",
            "ct",
            "other",
            name="imaging_modality_enum",
        ),
        nullable=False,
    )
    file_uri: Mapped[str] = mapped_column(String(255), nullable=False)
    captured_at: Mapped[Optional[datetime]] = mapped_column(DateTime)
    metadata_json: Mapped[Optional[dict]] = mapped_column(JSON)

    session: Mapped["SurgerySession"] = relationship(
        "SurgerySession", back_populates="imaging_data"
    )

    def __repr__(self):
        return f"<ImagingData(id={self.image_id}, session_id={self.session_id}, modality='{self.modality}')>"


class Complication(Base):

    __tablename__ = "complications"

    complication_id: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    session_id: Mapped[int] = mapped_column(
        BigInteger,
        ForeignKey("surgery_sessions.session_id", ondelete="CASCADE"),
        nullable=False,
    )
    type: Mapped[str] = mapped_column(String(255), nullable=False)
    severity: Mapped[str] = mapped_column(
        Enum("mild", "moderate", "severe", "critical", name="severity_enum"),
        nullable=False,
    )
    detected_at: Mapped[Optional[datetime]] = mapped_column(DateTime)
    resolved_at: Mapped[Optional[datetime]] = mapped_column(DateTime)
    description: Mapped[Optional[str]] = mapped_column(Text)

    session: Mapped["SurgerySession"] = relationship(
        "SurgerySession", back_populates="complications"
    )

    def __repr__(self):
        return f"<Complication(id={self.complication_id}, session_id={self.session_id}, severity='{self.severity}')>"


class Maintenance(Base):

    __tablename__ = "maintenances"

    maintenance_id: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    robot_id: Mapped[int] = mapped_column(
        BigInteger,
        ForeignKey("surgical_robots.robot_id", ondelete="CASCADE"),
        nullable=False,
    )
    performed_at: Mapped[datetime] = mapped_column(DateTime, nullable=False)
    type: Mapped[Optional[str]] = mapped_column(String(255))
    engineer_name: Mapped[Optional[str]] = mapped_column(String(255))
    notes: Mapped[Optional[str]] = mapped_column(Text)
    next_due_at: Mapped[Optional[datetime]] = mapped_column(DateTime)

    robot: Mapped["SurgicalRobot"] = relationship(
        "SurgicalRobot", back_populates="maintenances"
    )

    def __repr__(self):
        return f"<Maintenance(id={self.maintenance_id}, robot_id={self.robot_id}, performed={self.performed_at})>"


class Calibration(Base):

    __tablename__ = "calibrations"

    calibration_id: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    module_id: Mapped[int] = mapped_column(
        BigInteger,
        ForeignKey("robot_modules.module_id", ondelete="CASCADE"),
        nullable=False,
    )
    performed_at: Mapped[datetime] = mapped_column(DateTime, nullable=False)
    method: Mapped[Optional[str]] = mapped_column(String(255))
    result: Mapped[Optional[str]] = mapped_column(String(255))
    tolerance_mm: Mapped[Optional[Decimal]] = mapped_column(DECIMAL(6, 3))

    module: Mapped["RobotModule"] = relationship(
        "RobotModule", back_populates="calibrations"
    )

    def __repr__(self):
        return f"<Calibration(id={self.calibration_id}, module_id={self.module_id}, performed={self.performed_at})>"


class SoftwareVersion(Base):

    __tablename__ = "software_versions"

    sw_id: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    version: Mapped[str] = mapped_column(String(255), unique=True, nullable=False)
    release_date: Mapped[Optional[date]] = mapped_column(Date)
    vendor_notes: Mapped[Optional[str]] = mapped_column(Text)

    robot_installs: Mapped[List["RobotSoftwareInstall"]] = relationship(
        "RobotSoftwareInstall", back_populates="software"
    )

    def __repr__(self):
        return f"<SoftwareVersion(id={self.sw_id}, version='{self.version}')>"


class RobotSoftwareInstall(Base):

    __tablename__ = "robot_software_installs"

    robot_id: Mapped[int] = mapped_column(
        BigInteger,
        ForeignKey("surgical_robots.robot_id", ondelete="CASCADE"),
        primary_key=True,
    )
    sw_id: Mapped[int] = mapped_column(
        BigInteger,
        ForeignKey("software_versions.sw_id", ondelete="RESTRICT"),
        primary_key=True,
    )
    installed_at: Mapped[datetime] = mapped_column(
        DateTime, primary_key=True, nullable=False
    )

    robot: Mapped["SurgicalRobot"] = relationship(
        "SurgicalRobot", back_populates="software_installs"
    )
    software: Mapped["SoftwareVersion"] = relationship(
        "SoftwareVersion", back_populates="robot_installs"
    )

    def __repr__(self):
        return f"<RobotSoftwareInstall(robot_id={self.robot_id}, sw_id={self.sw_id}, installed={self.installed_at})>"


class DeviceEvent(Base):

    __tablename__ = "device_events"

    event_id: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    session_id: Mapped[Optional[int]] = mapped_column(
        BigInteger, ForeignKey("surgery_sessions.session_id", ondelete="SET NULL")
    )
    robot_id: Mapped[int] = mapped_column(
        BigInteger,
        ForeignKey("surgical_robots.robot_id", ondelete="CASCADE"),
        nullable=False,
    )
    module_id: Mapped[Optional[int]] = mapped_column(
        BigInteger, ForeignKey("robot_modules.module_id", ondelete="SET NULL")
    )
    level: Mapped[str] = mapped_column(
        Enum("info", "warning", "error", "critical", name="event_level_enum"),
        nullable=False,
    )
    code: Mapped[Optional[str]] = mapped_column(String(255))
    message: Mapped[Optional[str]] = mapped_column(Text)
    timestamp: Mapped[datetime] = mapped_column(DateTime, nullable=False)

    session: Mapped[Optional["SurgerySession"]] = relationship(
        "SurgerySession", back_populates="device_events"
    )
    robot: Mapped["SurgicalRobot"] = relationship(
        "SurgicalRobot", back_populates="device_events"
    )
    module: Mapped[Optional["RobotModule"]] = relationship(
        "RobotModule", back_populates="device_events"
    )

    def __repr__(self):
        return f"<DeviceEvent(id={self.event_id}, robot_id={self.robot_id}, level='{self.level}', time={self.timestamp})>"
