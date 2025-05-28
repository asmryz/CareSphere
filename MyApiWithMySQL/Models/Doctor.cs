using System;
using System.Collections.Generic;

namespace MyApiWithMySQL.Models;

public partial class Doctor
{
    public int DoctorId { get; set; }

    public int UserId { get; set; }

    public string? Name { get; set; }

    public string? Specialty { get; set; }

    public string? City { get; set; }

    public virtual ICollection<Appointment> Appointments { get; set; } = new List<Appointment>();

    public virtual ICollection<PatientHistory> PatientHistories { get; set; } = new List<PatientHistory>();

    public virtual User User { get; set; } = null!;
}
