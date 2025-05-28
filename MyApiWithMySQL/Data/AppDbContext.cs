using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using MyApiWithMySQL.Data.Models;
using Pomelo.EntityFrameworkCore.MySql.Scaffolding.Internal;



namespace MyApiWithMySQL.Data;

public partial class AppDbContext : DbContext
{
    public AppDbContext()
    {
    }

    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Appointment> Appointments { get; set; }

    public virtual DbSet<Doctor> Doctors { get; set; }

    public virtual DbSet<DoctorProfileView> DoctorProfileViews { get; set; }

    public virtual DbSet<Patient> Patients { get; set; }

    public virtual DbSet<PatientAgeSummary> PatientAgeSummaries { get; set; }

    public virtual DbSet<PatientHistory> PatientHistories { get; set; }

    public virtual DbSet<User> Users { get; set; }

//     protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
// #warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
//         => optionsBuilder.UseMySql("server=localhost;user=root;password=AnumAsim;database=CareSphereDB", Microsoft.EntityFrameworkCore.ServerVersion.Parse("8.0.42-mysql"));

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .UseCollation("utf8mb4_0900_ai_ci")
            .HasCharSet("utf8mb4");

        modelBuilder.Entity<Appointment>(entity =>
        {
            entity.HasKey(e => e.AppointmentId).HasName("PRIMARY");

            entity.HasIndex(e => e.DoctorId, "DoctorID");

            entity.HasIndex(e => e.PatientId, "PatientID");

            entity.Property(e => e.AppointmentId).HasColumnName("AppointmentID");
            entity.Property(e => e.BookingMethod).HasColumnType("enum('Manual','Chatbot')");
            entity.Property(e => e.CheckupType).HasColumnType("enum('Routine','Emergency','Follow-up')");
            entity.Property(e => e.DateTime).HasColumnType("datetime");
            entity.Property(e => e.DoctorId).HasColumnName("DoctorID");
            entity.Property(e => e.PatientId).HasColumnName("PatientID");
            entity.Property(e => e.Status).HasColumnType("enum('Scheduled','Completed','Cancelled')");

            entity.HasOne(d => d.Doctor).WithMany(p => p.Appointments)
                .HasForeignKey(d => d.DoctorId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("Appointments_ibfk_2");

            entity.HasOne(d => d.Patient).WithMany(p => p.Appointments)
                .HasForeignKey(d => d.PatientId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("Appointments_ibfk_1");
        });

        modelBuilder.Entity<Doctor>(entity =>
        {
            entity.HasKey(e => e.DoctorId).HasName("PRIMARY");

            entity.HasIndex(e => e.UserId, "UserID");

            entity.Property(e => e.DoctorId).HasColumnName("DoctorID");
            entity.Property(e => e.City).HasMaxLength(100);
            entity.Property(e => e.Name).HasMaxLength(100);
            entity.Property(e => e.Specialty).HasMaxLength(100);
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.User).WithMany(p => p.Doctors)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("Doctors_ibfk_1");
        });

        modelBuilder.Entity<DoctorProfileView>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("DoctorProfileView");

            entity.Property(e => e.City).HasMaxLength(100);
            entity.Property(e => e.DoctorName).HasMaxLength(100);
            entity.Property(e => e.Email).HasMaxLength(100);
            entity.Property(e => e.Specialty).HasMaxLength(100);
        });

        modelBuilder.Entity<Patient>(entity =>
        {
            entity.HasKey(e => e.PatientId).HasName("PRIMARY");

            entity.HasIndex(e => e.UserId, "UserID");

            entity.Property(e => e.PatientId).HasColumnName("PatientID");
            entity.Property(e => e.City).HasMaxLength(100);
            entity.Property(e => e.Name).HasMaxLength(100);
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.User).WithMany(p => p.Patients)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("Patients_ibfk_1");
        });

        modelBuilder.Entity<PatientAgeSummary>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("PatientAgeSummary");

            entity.Property(e => e.AvgAge).HasPrecision(14, 4);
            entity.Property(e => e.City).HasMaxLength(100);
        });

        modelBuilder.Entity<PatientHistory>(entity =>
        {
            entity.HasKey(e => e.HistoryId).HasName("PRIMARY");

            entity.ToTable("PatientHistory");

            entity.HasIndex(e => e.AppointmentId, "AppointmentID");

            entity.HasIndex(e => e.DoctorId, "DoctorID");

            entity.HasIndex(e => e.PatientId, "PatientID");

            entity.Property(e => e.HistoryId).HasColumnName("HistoryID");
            entity.Property(e => e.AppointmentId).HasColumnName("AppointmentID");
            entity.Property(e => e.Diagnosis).HasColumnType("text");
            entity.Property(e => e.DoctorId).HasColumnName("DoctorID");
            entity.Property(e => e.Notes).HasColumnType("text");
            entity.Property(e => e.PatientId).HasColumnName("PatientID");
            entity.Property(e => e.Prescriptions).HasColumnType("text");
            entity.Property(e => e.SymptomDescription).HasColumnType("text");

            entity.HasOne(d => d.Appointment).WithMany(p => p.PatientHistories)
                .HasForeignKey(d => d.AppointmentId)
                .HasConstraintName("PatientHistory_ibfk_3");

            entity.HasOne(d => d.Doctor).WithMany(p => p.PatientHistories)
                .HasForeignKey(d => d.DoctorId)
                .HasConstraintName("PatientHistory_ibfk_2");

            entity.HasOne(d => d.Patient).WithMany(p => p.PatientHistories)
                .HasForeignKey(d => d.PatientId)
                .HasConstraintName("PatientHistory_ibfk_1");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PRIMARY");

            entity.HasIndex(e => e.Email, "Email").IsUnique();

            entity.Property(e => e.UserId).HasColumnName("UserID");
            entity.Property(e => e.Email).HasMaxLength(100);
            entity.Property(e => e.PasswordHash).HasMaxLength(255);
            entity.Property(e => e.Role).HasColumnType("enum('Patient','Doctor','Admin')");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
