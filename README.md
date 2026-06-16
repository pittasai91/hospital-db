# hospital-db
# Hospital Appointment Scheduling Database

A MySQL dataset and schema for practicing SQL by building a doctor
appointment schedule. Modeled after a school-timetable structure, adapted
to a hospital domain.

## Overview

The database represents departments, doctors, specializations, patients,
rooms, and time slots. The goal is to write SQL that assigns doctors to
appointment slots without clashes, then validate the schedule using the
included queries.

## Tables

- `departments` – hospital departments (Cardiology, Orthopedics, etc.)
- `doctors` – doctor details and experience
- `specializations` – consultation types and required weekly sessions
- `patients` – patients linked to a department
- `rooms` – consultation rooms, labs, and therapy rooms
- `week_days` – Monday–Friday reference table
- `time_slots` – daily appointment slots with start/end times
- `doctor_specialization_department` – valid doctor-specialization-
  department mappings
- `appointment_schedule` – the table students populate with their
  schedule

## Getting Started

1. Import the schema:
   ```
   mysql -u root -p < hospital_appointment_scheduling.sql
   ```
2. Review the sample data in `departments`, `doctors`, `specializations`,
   and `time_slots`.
3. Write `INSERT` statements into `appointment_schedule` to build a full
   weekly schedule.

## Validation Queries

The script includes ready-made queries to:

- View the full schedule in a readable format
- Detect doctor clashes (same doctor, same day/slot)
- Detect room clashes (same room, same day/slot)
- Check whether each specialization meets its required weekly sessions
- Flag invalid doctor-specialization-department assignments

## Notes

The included sample schedule is partial — delete or extend it as needed
when building a complete weekly timetable.
