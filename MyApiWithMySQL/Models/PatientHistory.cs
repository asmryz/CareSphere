using System;
using System.Collections.Generic;

namespace MyApiWithMySQL.Models;

public partial class PatientHistory
{
    public int HistoryId { get; set; }

    public int? PatientId { get; set; }

    public int? DoctorId { get; set; }

    public int? AppointmentId { get; set; }

    public string? SymptomDescription { get; set; }

    public string? Diagnosis { get; set; }

    public string? Prescriptions { get; set; }

    public bool? FollowUpRequired { get; set; }

    public DateOnly? CheckupDate { get; set; }

    public string? Notes { get; set; }

    public virtual Appointment? Appointment { get; set; }

    public virtual Doctor? Doctor { get; set; }

    public virtual Patient? Patient { get; set; }
}
