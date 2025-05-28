using System;
using System.Collections.Generic;

namespace MyApiWithMySQL.Data.Models;

public partial class PatientAgeSummary
{
    public string? City { get; set; }

    public long TotalPatients { get; set; }

    public decimal? AvgAge { get; set; }

    public int? Oldest { get; set; }

    public int? Youngest { get; set; }
}
