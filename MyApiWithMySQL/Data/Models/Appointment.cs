using System;
using System.Collections.Generic;

namespace MyApiWithMySQL.Data.Models;

public partial class Appointment
{
    public int AppointmentId { get; set; }

    public int? PatientId { get; set; }

    public int? DoctorId { get; set; }

    public DateTime? DateTime { get; set; }

    public string? CheckupType { get; set; }

    public string? Status { get; set; }

    public string? BookingMethod { get; set; }

    public virtual Doctor? Doctor { get; set; }

    public virtual Patient? Patient { get; set; }

    public virtual ICollection<PatientHistory> PatientHistories { get; set; } = new List<PatientHistory>();
}
