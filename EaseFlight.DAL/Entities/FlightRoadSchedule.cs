//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class FlightRoadSchedule
    {
        public int ScheduleID { get; set; }
        public int FlightRoadID { get; set; }
        public int PlaneID { get; set; }
        public Nullable<int> Order { get; set; }
    
        public virtual FlightRoad FlightRoad { get; set; }
        public virtual Plane Plane { get; set; }
        public virtual Schedule Schedule { get; set; }
    }
}
