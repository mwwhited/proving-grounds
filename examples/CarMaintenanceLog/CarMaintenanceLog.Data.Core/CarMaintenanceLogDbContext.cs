using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace CarMaintenanceLog.Data.Core
{
    public partial class CarMaintenanceLogDbContext : DbContext
    {
        public CarMaintenanceLogDbContext()
        {
        }

        public CarMaintenanceLogDbContext(DbContextOptions<CarMaintenanceLogDbContext> options)
            : base(options)
        {
        }

        public virtual DbSet<AspNetRoles> AspNetRoles { get; set; }
        public virtual DbSet<AspNetUserClaims> AspNetUserClaims { get; set; }
        public virtual DbSet<AspNetUserLogins> AspNetUserLogins { get; set; }
        public virtual DbSet<AspNetUserRoles> AspNetUserRoles { get; set; }
        public virtual DbSet<AspNetUsers> AspNetUsers { get; set; }
        public virtual DbSet<BillingDocuments> BillingDocuments { get; set; }
        public virtual DbSet<CarCostsRolledUp> CarCostsRolledUp { get; set; }
        public virtual DbSet<Cars> Cars { get; set; }
        public virtual DbSet<CombinedCosts> CombinedCosts { get; set; }
        public virtual DbSet<CostsPerCar> CostsPerCar { get; set; }
        public virtual DbSet<Customers> Customers { get; set; }
        public virtual DbSet<DetailedTimeLog> DetailedTimeLog { get; set; }
        public virtual DbSet<DriverCarMaintenance> DriverCarMaintenance { get; set; }
        public virtual DbSet<Drivers> Drivers { get; set; }
        public virtual DbSet<EmployeeProjects> EmployeeProjects { get; set; }
        public virtual DbSet<Employees> Employees { get; set; }
        public virtual DbSet<FillUps> FillUps { get; set; }
        public virtual DbSet<FillUpsLocations> FillUpsLocations { get; set; }
        public virtual DbSet<InsurancePayments> InsurancePayments { get; set; }
        public virtual DbSet<Invoices> Invoices { get; set; }
        public virtual DbSet<LineItems> LineItems { get; set; }
        public virtual DbSet<MaintenanceSchedules> MaintenanceSchedules { get; set; }
        public virtual DbSet<MigrationHistory> MigrationHistory { get; set; }
        public virtual DbSet<Notes> Notes { get; set; }
        public virtual DbSet<OilChanges> OilChanges { get; set; }
        public virtual DbSet<OtherServices> OtherServices { get; set; }
        public virtual DbSet<Payments> Payments { get; set; }
        public virtual DbSet<Projects> Projects { get; set; }
        public virtual DbSet<ReportedTimeLogs> ReportedTimeLogs { get; set; }
        public virtual DbSet<SlidingBalance> SlidingBalance { get; set; }
        public virtual DbSet<Stations> Stations { get; set; }
        public virtual DbSet<SummaryCostsYearly> SummaryCostsYearly { get; set; }
        public virtual DbSet<Terms> Terms { get; set; }
        public virtual DbSet<TimeLogs> TimeLogs { get; set; }
        public virtual DbSet<TimeSheets> TimeSheets { get; set; }
        public virtual DbSet<Tires> Tires { get; set; }
        public virtual DbSet<TotalMiles> TotalMiles { get; set; }
        public virtual DbSet<Transactions> Transactions { get; set; }
        public virtual DbSet<Vehicles> Vehicles { get; set; }
        public virtual DbSet<Vendors> Vendors { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Data Source=(localdb)\\ProjectsV13;Initial Catalog=CarMaintenanceLog.Db;Integrated Security=True;Pooling=False;Connect Timeout=30");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AspNetRoles>(entity =>
            {
                entity.HasIndex(e => e.Name)
                    .HasName("RoleNameIndex")
                    .IsUnique();

                entity.Property(e => e.Id).HasMaxLength(128);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(256);
            });

            modelBuilder.Entity<AspNetUserClaims>(entity =>
            {
                entity.HasIndex(e => e.UserId)
                    .HasName("IX_UserId");

                entity.Property(e => e.UserId)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.HasOne(d => d.User)
                    .WithMany(p => p.AspNetUserClaims)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId");
            });

            modelBuilder.Entity<AspNetUserLogins>(entity =>
            {
                entity.HasKey(e => new { e.LoginProvider, e.ProviderKey, e.UserId })
                    .HasName("PK_dbo.AspNetUserLogins");

                entity.HasIndex(e => e.UserId)
                    .HasName("IX_UserId");

                entity.Property(e => e.LoginProvider).HasMaxLength(128);

                entity.Property(e => e.ProviderKey).HasMaxLength(128);

                entity.Property(e => e.UserId).HasMaxLength(128);

                entity.HasOne(d => d.User)
                    .WithMany(p => p.AspNetUserLogins)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId");
            });

            modelBuilder.Entity<AspNetUserRoles>(entity =>
            {
                entity.HasKey(e => new { e.UserId, e.RoleId })
                    .HasName("PK_dbo.AspNetUserRoles");

                entity.HasIndex(e => e.RoleId)
                    .HasName("IX_RoleId");

                entity.HasIndex(e => e.UserId)
                    .HasName("IX_UserId");

                entity.Property(e => e.UserId).HasMaxLength(128);

                entity.Property(e => e.RoleId).HasMaxLength(128);

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.AspNetUserRoles)
                    .HasForeignKey(d => d.RoleId)
                    .HasConstraintName("FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.AspNetUserRoles)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId");
            });

            modelBuilder.Entity<AspNetUsers>(entity =>
            {
                entity.HasIndex(e => e.UserName)
                    .HasName("UserNameIndex")
                    .IsUnique();

                entity.Property(e => e.Id).HasMaxLength(128);

                entity.Property(e => e.Email).HasMaxLength(256);

                entity.Property(e => e.LockoutEndDateUtc).HasColumnType("datetime");

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasMaxLength(256);
            });

            modelBuilder.Entity<BillingDocuments>(entity =>
            {
                entity.HasKey(e => e.BillingDocument);

                entity.ToTable("BillingDocuments", "Accounting");

                entity.Property(e => e.Amount).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.Data).IsRequired();

                entity.Property(e => e.DownloadedDate).HasColumnType("datetime");

                entity.Property(e => e.PaidDate).HasColumnType("datetime");

                entity.Property(e => e.VendorId).HasColumnName("VendorID");

                entity.HasOne(d => d.Vendor)
                    .WithMany(p => p.BillingDocuments)
                    .HasForeignKey(d => d.VendorId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_BillingDocuments_Vendors");
            });

            modelBuilder.Entity<CarCostsRolledUp>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("CarCosts_RolledUp", "Vehicles");

                entity.Property(e => e.Amount).HasColumnType("decimal(38, 4)");

                entity.Property(e => e.CarId).HasColumnName("CarID");
            });

            modelBuilder.Entity<Cars>(entity =>
            {
                entity.HasKey(e => e.CarId)
                    .HasName("PK_Vehicles_Cars");

                entity.ToTable("Cars", "Vehicles");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.DriverId).HasColumnName("DriverID");

                entity.Property(e => e.Make)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Model)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.PurchasedDate).HasColumnType("datetime");

                entity.Property(e => e.SoldDate).HasColumnType("datetime");

                entity.Property(e => e.StartingMiles).HasColumnType("decimal(12, 2)");

                entity.Property(e => e.SubModel).HasMaxLength(100);

                entity.HasOne(d => d.Driver)
                    .WithMany(p => p.Cars)
                    .HasForeignKey(d => d.DriverId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Vehicles_Cars_to_Drivers");
            });

            modelBuilder.Entity<CombinedCosts>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("CombinedCosts", "Vehicles");

                entity.Property(e => e.Amount).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.Date).HasColumnType("datetime");

                entity.Property(e => e.RowId).HasColumnName("RowID");

                entity.Property(e => e.RowSource)
                    .IsRequired()
                    .HasMaxLength(17)
                    .IsUnicode(false);

                entity.Property(e => e.TotalMiles).HasColumnType("decimal(14, 4)");
            });

            modelBuilder.Entity<CostsPerCar>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("CostsPerCar", "Vehicles");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.FillUps).HasColumnType("decimal(12, 2)");

                entity.Property(e => e.InsurancePayments).HasColumnType("decimal(12, 2)");

                entity.Property(e => e.OilChanges).HasColumnType("decimal(12, 2)");

                entity.Property(e => e.OtherServices).HasColumnType("decimal(12, 2)");

                entity.Property(e => e.Payments).HasColumnType("decimal(12, 2)");

                entity.Property(e => e.Tires).HasColumnType("decimal(12, 2)");

                entity.Property(e => e.TotalCost).HasColumnType("decimal(12, 2)");
            });

            modelBuilder.Entity<Customers>(entity =>
            {
                entity.HasKey(e => e.CustomerId);

                entity.ToTable("Customers", "Common");

                entity.Property(e => e.CustomerId).HasColumnName("CustomerID");

                entity.Property(e => e.AccountingEmail).HasMaxLength(256);

                entity.Property(e => e.Address1).HasMaxLength(128);

                entity.Property(e => e.Address2).HasMaxLength(128);

                entity.Property(e => e.City).HasMaxLength(128);

                entity.Property(e => e.CompanyName).HasMaxLength(50);

                entity.Property(e => e.ContractEmail).HasMaxLength(256);

                entity.Property(e => e.Country).HasMaxLength(50);

                entity.Property(e => e.FirstName).HasMaxLength(50);

                entity.Property(e => e.LastName).HasMaxLength(50);

                entity.Property(e => e.Phone).HasMaxLength(256);

                entity.Property(e => e.PostalCode).HasMaxLength(50);

                entity.Property(e => e.State).HasMaxLength(128);
            });

            modelBuilder.Entity<DetailedTimeLog>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("DetailedTimeLog", "Hours");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.Date).HasColumnType("date");

                entity.Property(e => e.DayOfWeek)
                    .HasMaxLength(9)
                    .IsUnicode(false);

                entity.Property(e => e.EndTime).HasColumnName("EndTIme");

                entity.Property(e => e.InvoiceId).HasColumnName("InvoiceID");

                entity.Property(e => e.Note).HasMaxLength(265);

                entity.Property(e => e.ProjectId).HasColumnName("ProjectID");

                entity.Property(e => e.TimeLogId)
                    .HasColumnName("TimeLogID")
                    .ValueGeneratedOnAdd();
            });

            modelBuilder.Entity<DriverCarMaintenance>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("DriverCarMaintenance", "Vehicles");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.CompletedOn).HasColumnType("datetime");

                entity.Property(e => e.Driver)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.DriverId).HasColumnName("DriverID");

                entity.Property(e => e.DueIn).HasColumnType("decimal(15, 4)");

                entity.Property(e => e.MaintenanceScheduleId).HasColumnName("MaintenanceScheduleID");

                entity.Property(e => e.Make)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Model)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.ScheduledMiles).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.SubModel).HasMaxLength(100);

                entity.Property(e => e.TotalMiles).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.WorkItems).IsRequired();
            });

            modelBuilder.Entity<Drivers>(entity =>
            {
                entity.HasKey(e => e.DriverId)
                    .HasName("PK_Vehicles_Drivers");

                entity.ToTable("Drivers", "Vehicles");

                entity.Property(e => e.DriverId).HasColumnName("DriverID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.UserId).HasColumnName("UserID");
            });

            modelBuilder.Entity<EmployeeProjects>(entity =>
            {
                entity.HasKey(e => e.EmployeProjectId);

                entity.ToTable("EmployeeProjects", "Accounting");

                entity.HasIndex(e => new { e.EmployeeId, e.ProjectId })
                    .HasName("UX_EmployeeProjects")
                    .IsUnique();

                entity.Property(e => e.EmployeProjectId).HasColumnName("EmployeProjectID");

                entity.Property(e => e.EmployeeId).HasColumnName("EmployeeID");

                entity.Property(e => e.ProjectId).HasColumnName("ProjectID");

                entity.HasOne(d => d.Employee)
                    .WithMany(p => p.EmployeeProjects)
                    .HasForeignKey(d => d.EmployeeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_EmployeeProjects_Employees");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.EmployeeProjects)
                    .HasForeignKey(d => d.ProjectId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_EmployeeProjects_Projects");
            });

            modelBuilder.Entity<Employees>(entity =>
            {
                entity.HasKey(e => e.EmployeeId);

                entity.ToTable("Employees", "Common");

                entity.Property(e => e.EmployeeId).HasColumnName("EmployeeID");

                entity.Property(e => e.DefaultCarId).HasColumnName("DefaultCarID");

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.UserId).HasColumnName("UserID");

                entity.HasOne(d => d.DefaultCar)
                    .WithMany(p => p.Employees)
                    .HasForeignKey(d => d.DefaultCarId)
                    .HasConstraintName("FK_Employees_Cars");
            });

            modelBuilder.Entity<FillUps>(entity =>
            {
                entity.HasKey(e => e.FillUpId)
                    .HasName("PK_Vehicles_FillUps");

                entity.ToTable("FillUps", "Vehicles");

                entity.Property(e => e.FillUpId).HasColumnName("FillUpID");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.CostPerGallon).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.Date).HasColumnType("datetime");

                entity.Property(e => e.ExtendedCost)
                    .HasColumnType("decimal(14, 4)")
                    .HasComputedColumnSql("(CONVERT([decimal](14,4),[CostPerGallon]*[Gallons]))");

                entity.Property(e => e.Gallons).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.MilesPerGallon)
                    .HasColumnType("decimal(14, 4)")
                    .HasComputedColumnSql("(case [Gallons] when (0) then (0) else CONVERT([decimal](14,4),[TankMiles]/[Gallons]) end)");

                entity.Property(e => e.Station)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.TankMiles).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.TotalMiles).HasColumnType("decimal(14, 4)");

                entity.HasOne(d => d.Car)
                    .WithMany(p => p.FillUps)
                    .HasForeignKey(d => d.CarId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Vehicles_FillUps_to_Cars");
            });

            modelBuilder.Entity<FillUpsLocations>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("FillUps_Locations", "Vehicles");

                entity.Property(e => e.Address1).HasMaxLength(256);

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.City).HasMaxLength(256);

                entity.Property(e => e.Date).HasColumnType("datetime");

                entity.Property(e => e.DriverId).HasColumnName("DriverID");

                entity.Property(e => e.FillUpId).HasColumnName("FillUpID");

                entity.Property(e => e.Make)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Model)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.State).HasMaxLength(256);

                entity.Property(e => e.Station)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.StationId).HasColumnName("StationID");

                entity.Property(e => e.TankMiles).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.ZipCode).HasMaxLength(256);
            });

            modelBuilder.Entity<InsurancePayments>(entity =>
            {
                entity.HasKey(e => e.InsurancePaymentId)
                    .HasName("PK_Vehicles_InsurancePayments");

                entity.ToTable("InsurancePayments", "Vehicles");

                entity.Property(e => e.InsurancePaymentId).HasColumnName("InsurancePaymentID");

                entity.Property(e => e.Amount).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.Date).HasColumnType("datetime");

                entity.Property(e => e.PaidTo)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.HasOne(d => d.Car)
                    .WithMany(p => p.InsurancePayments)
                    .HasForeignKey(d => d.CarId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Vehicles_InsurancePayments_to_Cars");
            });

            modelBuilder.Entity<Invoices>(entity =>
            {
                entity.HasKey(e => e.InvoiceId);

                entity.ToTable("Invoices", "Accounting");

                entity.Property(e => e.InvoiceId).HasColumnName("InvoiceID");

                entity.Property(e => e.CustomerId).HasColumnName("CustomerID");

                entity.Property(e => e.DueDate).HasColumnType("date");

                entity.Property(e => e.HasRenderedInvoice).HasComputedColumnSql("(case when [RenderedInvoice] IS NULL then (0) else (1) end)");

                entity.Property(e => e.InvoiceDate).HasColumnType("date");

                entity.Property(e => e.InvoiceStatusCode)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.PaidDate).HasColumnType("datetime");

                entity.Property(e => e.RenderedInvoiceMime).HasMaxLength(256);

                entity.Property(e => e.TermsId).HasColumnName("TermsID");

                entity.HasOne(d => d.Customer)
                    .WithMany(p => p.Invoices)
                    .HasForeignKey(d => d.CustomerId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Invoices_Customers");

                entity.HasOne(d => d.Terms)
                    .WithMany(p => p.Invoices)
                    .HasForeignKey(d => d.TermsId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Invoices_Terms");
            });

            modelBuilder.Entity<LineItems>(entity =>
            {
                entity.HasKey(e => e.LineItemId);

                entity.ToTable("LineItems", "Accounting");

                entity.Property(e => e.LineItemId).HasColumnName("LineItemID");

                entity.Property(e => e.Description)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.ExtendedAmount).HasComputedColumnSql("([Quantity]*[UnitPrice])");

                entity.Property(e => e.InvoiceId).HasColumnName("InvoiceID");

                entity.Property(e => e.ProjectId).HasColumnName("ProjectID");

                entity.Property(e => e.TaxAmount).HasComputedColumnSql("(([Quantity]*[UnitPrice])*[TaxRate])");

                entity.Property(e => e.TotalAmount).HasComputedColumnSql("(([Quantity]*[UnitPrice])*((1)+isnull([TaxRate],(0))))");

                entity.HasOne(d => d.Invoice)
                    .WithMany(p => p.LineItems)
                    .HasForeignKey(d => d.InvoiceId)
                    .HasConstraintName("FK_LineItems_Invoices");
            });

            modelBuilder.Entity<MaintenanceSchedules>(entity =>
            {
                entity.HasKey(e => e.MaintenanceScheduleId);

                entity.ToTable("MaintenanceSchedules", "Vehicles");

                entity.Property(e => e.MaintenanceScheduleId).HasColumnName("MaintenanceScheduleID");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.CompletedOn).HasColumnType("datetime");

                entity.Property(e => e.IsComplete).HasComputedColumnSql("(CONVERT([bit],case when [CompletedOn] IS NOT NULL then (1) else (0) end))");

                entity.Property(e => e.Miles).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.WorkItems).IsRequired();

                entity.HasOne(d => d.Car)
                    .WithMany(p => p.MaintenanceSchedules)
                    .HasForeignKey(d => d.CarId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Vehicles_MaintenanceSchedules_to_Cars");
            });

            modelBuilder.Entity<MigrationHistory>(entity =>
            {
                entity.HasKey(e => new { e.MigrationId, e.ContextKey })
                    .HasName("PK_dbo.__MigrationHistory");

                entity.ToTable("__MigrationHistory");

                entity.Property(e => e.MigrationId).HasMaxLength(150);

                entity.Property(e => e.ContextKey).HasMaxLength(300);

                entity.Property(e => e.Model).IsRequired();

                entity.Property(e => e.ProductVersion)
                    .IsRequired()
                    .HasMaxLength(32);
            });

            modelBuilder.Entity<Notes>(entity =>
            {
                entity.HasKey(e => e.NoteId);

                entity.ToTable("Notes", "Common");

                entity.Property(e => e.NoteId).HasColumnName("NoteID");

                entity.Property(e => e.Date)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Note).IsRequired();
            });

            modelBuilder.Entity<OilChanges>(entity =>
            {
                entity.HasKey(e => e.OilChangeId)
                    .HasName("PK_Vehicles_OilChanges");

                entity.ToTable("OilChanges", "Vehicles");

                entity.Property(e => e.OilChangeId).HasColumnName("OilChangeID");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.ChangeMiles).HasColumnType("decimal(10, 2)");

                entity.Property(e => e.Date).HasColumnType("datetime");

                entity.Property(e => e.ExtendedCost)
                    .HasColumnType("decimal(14, 4)")
                    .HasComputedColumnSql("(CONVERT([decimal](14,4),(((isnull([OilCost],(0))+isnull([FilterCost],(0)))+isnull([LaborCost],(0)))+isnull([OtherCost],(0)))+isnull([TaxRate],(0))*(((isnull([OilCost],(0))+isnull([FilterCost],(0)))+isnull([LaborCost],(0)))+isnull([OtherCost],(0)))))");

                entity.Property(e => e.FilterBrand).HasMaxLength(100);

                entity.Property(e => e.FilterCost).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.LaborCost).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.Location)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.OilBrand).HasMaxLength(100);

                entity.Property(e => e.OilCost).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.OtherCost).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.Quarts).HasColumnType("decimal(7, 4)");

                entity.Property(e => e.TaxRate).HasColumnType("decimal(4, 4)");

                entity.HasOne(d => d.Car)
                    .WithMany(p => p.OilChanges)
                    .HasForeignKey(d => d.CarId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Vehicles_OilChanges_to_Cars");
            });

            modelBuilder.Entity<OtherServices>(entity =>
            {
                entity.HasKey(e => e.OtherServiceId)
                    .HasName("PK_Vehicles_OtherServices");

                entity.ToTable("OtherServices", "Vehicles");

                entity.Property(e => e.OtherServiceId).HasColumnName("OtherServiceID");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.Cost).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.Date).HasColumnType("datetime");

                entity.Property(e => e.ExtendedCost)
                    .HasColumnType("decimal(14, 4)")
                    .HasComputedColumnSql("(CONVERT([decimal](14,4),[Cost]+[Cost]*[Rate]))");

                entity.Property(e => e.Item)
                    .IsRequired()
                    .HasMaxLength(200);

                entity.Property(e => e.Location)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Miles).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.Rate).HasColumnType("decimal(4, 4)");

                entity.HasOne(d => d.Car)
                    .WithMany(p => p.OtherServices)
                    .HasForeignKey(d => d.CarId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Vehicles_OtherServices_to_Cars");
            });

            modelBuilder.Entity<Payments>(entity =>
            {
                entity.HasKey(e => e.PaymentId)
                    .HasName("PK_Vehicles_Payments");

                entity.ToTable("Payments", "Vehicles");

                entity.Property(e => e.PaymentId).HasColumnName("PaymentID");

                entity.Property(e => e.Amount).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.Date).HasColumnType("datetime");

                entity.Property(e => e.PaidTo)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.HasOne(d => d.Car)
                    .WithMany(p => p.Payments)
                    .HasForeignKey(d => d.CarId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Vehicles_Payments_to_Cars");
            });

            modelBuilder.Entity<Projects>(entity =>
            {
                entity.HasKey(e => e.ProjectId);

                entity.ToTable("Projects", "Accounting");

                entity.Property(e => e.ProjectId).HasColumnName("ProjectID");

                entity.Property(e => e.CustomerId).HasColumnName("CustomerID");

                entity.Property(e => e.DefaultTermId).HasColumnName("DefaultTermID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Customer)
                    .WithMany(p => p.Projects)
                    .HasForeignKey(d => d.CustomerId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Projects_Customers");

                entity.HasOne(d => d.DefaultTerm)
                    .WithMany(p => p.Projects)
                    .HasForeignKey(d => d.DefaultTermId)
                    .HasConstraintName("FK_Projects_Terms");
            });

            modelBuilder.Entity<ReportedTimeLogs>(entity =>
            {
                entity.HasKey(e => e.ReportedTimeLogId);

                entity.ToTable("ReportedTimeLogs", "Hours");

                entity.HasIndex(e => new { e.ProjectId, e.Year, e.Month, e.Week })
                    .HasName("UX_ReportedTimeLogs")
                    .IsUnique();

                entity.Property(e => e.ReportedTimeLogId).HasColumnName("ReportedTimeLogID");

                entity.Property(e => e.FirstOfWeek).HasColumnType("date");

                entity.Property(e => e.HasRendering).HasComputedColumnSql("(case when [Rendering] IS NULL then (0) else (1) end)");

                entity.Property(e => e.ProjectId).HasColumnName("ProjectID");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.ReportedTimeLogs)
                    .HasForeignKey(d => d.ProjectId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ReportedTimeLogs_Projects");
            });

            modelBuilder.Entity<SlidingBalance>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("SlidingBalance", "Loans");

                entity.Property(e => e.Balance).HasColumnType("decimal(38, 8)");

                entity.Property(e => e.Credit).HasColumnType("decimal(18, 8)");

                entity.Property(e => e.Currency)
                    .IsRequired()
                    .HasMaxLength(5);

                entity.Property(e => e.CustomerId).HasColumnName("CustomerID");

                entity.Property(e => e.DateTime).HasColumnType("datetime");

                entity.Property(e => e.Debit).HasColumnType("decimal(18, 8)");

                entity.Property(e => e.TransactionId)
                    .HasColumnName("TransactionID")
                    .ValueGeneratedOnAdd();
            });

            modelBuilder.Entity<Stations>(entity =>
            {
                entity.HasKey(e => e.StationId);

                entity.ToTable("Stations", "Vehicles");

                entity.Property(e => e.StationId).HasColumnName("StationID");

                entity.Property(e => e.Address1).HasMaxLength(256);

                entity.Property(e => e.Address2).HasMaxLength(256);

                entity.Property(e => e.City).HasMaxLength(256);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.State).HasMaxLength(256);

                entity.Property(e => e.ZipCode).HasMaxLength(256);
            });

            modelBuilder.Entity<SummaryCostsYearly>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("SummaryCosts_Yearly", "Vehicles");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.CostDifferenceYear).HasColumnType("decimal(38, 4)");

                entity.Property(e => e.CostPerMile).HasColumnType("decimal(38, 6)");

                entity.Property(e => e.MilesThisYear).HasColumnType("decimal(15, 4)");

                entity.Property(e => e.TotalMiles).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.YearlyCost).HasColumnType("decimal(38, 4)");
            });

            modelBuilder.Entity<Terms>(entity =>
            {
                entity.HasKey(e => e.TermId);

                entity.ToTable("Terms", "Accounting");

                entity.Property(e => e.TermId).HasColumnName("TermID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Rules).HasColumnType("xml");
            });

            modelBuilder.Entity<TimeLogs>(entity =>
            {
                entity.HasKey(e => e.TimeLogId);

                entity.ToTable("TimeLogs", "Hours");

                entity.Property(e => e.TimeLogId).HasColumnName("TimeLogID");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.Date).HasColumnType("date");

                entity.Property(e => e.EndTime).HasColumnName("EndTIme");

                entity.Property(e => e.Hours).HasComputedColumnSql("(CONVERT([float],datediff(minute,[StartTime],isnull([EndTIme],'0:00'))-CONVERT([float],datediff(minute,isnull([StartBreak],'0:00'),isnull([EndBreak],'0:00'))))/(60.0))");

                entity.Property(e => e.InvoiceId).HasColumnName("InvoiceID");

                entity.Property(e => e.Note).HasMaxLength(265);

                entity.Property(e => e.ProjectId).HasColumnName("ProjectID");

                entity.Property(e => e.ReportedTimeLogId).HasColumnName("ReportedTimeLogID");

                entity.HasOne(d => d.Car)
                    .WithMany(p => p.TimeLogs)
                    .HasForeignKey(d => d.CarId)
                    .HasConstraintName("FK_TimeLogs_Cars");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.TimeLogs)
                    .HasForeignKey(d => d.ProjectId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_TimeLogs_Projects");

                entity.HasOne(d => d.ReportedTimeLog)
                    .WithMany(p => p.TimeLogs)
                    .HasForeignKey(d => d.ReportedTimeLogId)
                    .HasConstraintName("FK_TimeLogs_ReportedTimeLogs");
            });

            modelBuilder.Entity<TimeSheets>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("TimeSheets", "Hours");

                entity.Property(e => e.FirstOfWeek).HasColumnType("date");

                entity.Property(e => e.InvoiceId).HasColumnName("InvoiceID");

                entity.Property(e => e.ProjectId).HasColumnName("ProjectID");

                entity.Property(e => e.RowOrder).HasColumnName("Row_Order");
            });

            modelBuilder.Entity<Tires>(entity =>
            {
                entity.HasKey(e => e.TireId)
                    .HasName("PK_Vehicles_Tires");

                entity.ToTable("Tires", "Vehicles");

                entity.Property(e => e.TireId).HasColumnName("TireID");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.Cost).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.Date).HasColumnType("datetime");

                entity.Property(e => e.ExpireDate)
                    .HasColumnType("datetime")
                    .HasComputedColumnSql("(dateadd(month,[WarrantyMonths],[Date]))");

                entity.Property(e => e.ExpireMiles)
                    .HasColumnType("decimal(15, 4)")
                    .HasComputedColumnSql("([Miles]+[WarrantyMiles])");

                entity.Property(e => e.ExtendedCost)
                    .HasColumnType("decimal(14, 4)")
                    .HasComputedColumnSql("(CONVERT([decimal](14,4),([Cost]*[Quantity])*((1)+[TaxRate])))");

                entity.Property(e => e.Make)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.Miles).HasColumnType("decimal(14, 4)");

                entity.Property(e => e.Model)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.TaxRate).HasColumnType("decimal(4, 4)");

                entity.Property(e => e.WarrantyMiles).HasColumnType("decimal(14, 4)");

                entity.HasOne(d => d.Car)
                    .WithMany(p => p.Tires)
                    .HasForeignKey(d => d.CarId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Vehicles_Tires_to_Cars");
            });

            modelBuilder.Entity<TotalMiles>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("TotalMiles", "Vehicles");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.TotalMiles1)
                    .HasColumnName("TotalMiles")
                    .HasColumnType("decimal(14, 4)");
            });

            modelBuilder.Entity<Transactions>(entity =>
            {
                entity.HasKey(e => e.TransactionId);

                entity.ToTable("Transactions", "Loans");

                entity.Property(e => e.TransactionId).HasColumnName("TransactionID");

                entity.Property(e => e.Credit).HasColumnType("decimal(18, 8)");

                entity.Property(e => e.Currency)
                    .IsRequired()
                    .HasMaxLength(5)
                    .HasDefaultValueSql("('USD')");

                entity.Property(e => e.CustomerId).HasColumnName("CustomerID");

                entity.Property(e => e.DateTime)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Debit).HasColumnType("decimal(18, 8)");

                entity.HasOne(d => d.Customer)
                    .WithMany(p => p.Transactions)
                    .HasForeignKey(d => d.CustomerId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Transactions_Customers");
            });

            modelBuilder.Entity<Vehicles>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("Vehicles", "Accounting");

                entity.Property(e => e.CarId).HasColumnName("CarID");

                entity.Property(e => e.Cost).HasColumnType("decimal(38, 4)");

                entity.Property(e => e.PercentBusiness).HasMaxLength(11);

                entity.Property(e => e.TotalMiles).HasColumnType("decimal(15, 4)");
            });

            modelBuilder.Entity<Vendors>(entity =>
            {
                entity.HasKey(e => e.VendorId);

                entity.ToTable("Vendors", "Accounting");

                entity.Property(e => e.VendorId).HasColumnName("VendorID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.Password).HasMaxLength(128);

                entity.Property(e => e.Username).HasMaxLength(128);

                entity.Property(e => e.WebSite).HasMaxLength(256);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
