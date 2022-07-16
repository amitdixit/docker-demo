using demo_crud_docker.Models;
using Microsoft.EntityFrameworkCore;

namespace demo_crud_docker.DataAccess;

public class StudentDemoContext : DbContext
{
    public StudentDemoContext(DbContextOptions<StudentDemoContext> options) : base(options)
    {
    }

    public DbSet<Course>? Courses { get; set; }
    public DbSet<Enrollment>? Enrollments { get; set; }
    public DbSet<Student>? Students { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Course>().ToTable("Course");
        modelBuilder.Entity<Enrollment>().ToTable("Enrollment");
        modelBuilder.Entity<Student>().ToTable("Student");
    }
}