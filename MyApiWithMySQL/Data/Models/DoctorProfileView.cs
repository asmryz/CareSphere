using System;
using System.Collections.Generic;

namespace MyApiWithMySQL.Data.Models;

public partial class DoctorProfileView
{
    public string? DoctorName { get; set; }

    public string? Specialty { get; set; }

    public string? City { get; set; }

    public string Email { get; set; } = null!;
}
