﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EaseFlight.DAL.Entities
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class EaseFlightEntities : DbContext
    {
        public EaseFlightEntities()
            : base("name=EaseFlightEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Account> Accounts { get; set; }
        public virtual DbSet<AccountType> AccountTypes { get; set; }
        public virtual DbSet<Airport> Airports { get; set; }
        public virtual DbSet<FlightRoad> FlightRoads { get; set; }
        public virtual DbSet<FlightRoadAirport> FlightRoadAirports { get; set; }
        public virtual DbSet<FlightRoadSchedule> FlightRoadSchedules { get; set; }
        public virtual DbSet<PassengerType> PassengerTypes { get; set; }
        public virtual DbSet<Plane> Planes { get; set; }
        public virtual DbSet<PlaneSeatClass> PlaneSeatClasses { get; set; }
        public virtual DbSet<Schedule> Schedules { get; set; }
        public virtual DbSet<SeatClass> SeatClasses { get; set; }
        public virtual DbSet<Ticket> Tickets { get; set; }
        public virtual DbSet<TicketSchedule> TicketSchedules { get; set; }
    }
}
