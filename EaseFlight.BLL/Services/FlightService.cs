﻿using EaseFlight.BLL.Interfaces;
using EaseFlight.Common.Utilities;
using EaseFlight.DAL.Entities;
using EaseFlight.DAL.Interfaces;
using EaseFlight.DAL.UnitOfWorks;
using EaseFlight.Models.CustomModel;
using EaseFlight.Models.EntityModels;
using System;
using System.Collections.Generic;
using System.Linq;

namespace EaseFlight.BLL.Services
{
    public class FlightService : BaseService, IFlightService
    {
        #region Properties
        private IFlightRepository FlightRepository { get; set; }
        private IPlaneAirportService PlaneAirportService { get; set; }
        #endregion

        #region Constructors
        public FlightService(IUnitOfWork unitOfWork,
            IFlightRepository flightRepository, IPlaneAirportService planeAirportService) : base(unitOfWork)
        {
            this.FlightRepository = flightRepository;
            this.PlaneAirportService = planeAirportService;
        }
        #endregion

        #region Functions
        public IEnumerable<FlightModel> FindAll()
        {
            var modelList = this.FlightRepository.FindAll();
            var result = modelList.Select(model => this.CreateViewModel(model));

            return result;
        }

        public int Insert(FlightModel flight)
        {
            this.FlightRepository.Insert(flight.GetModel());
            var result = this.UnitOfWork.SaveChanges();

            return result;
        }

        public FlightModel Find(int id)
        {
            var model = this.FlightRepository.Find(id);
            var result = this.CreateViewModel(model);

            return result;
        }

        public IEnumerable<SearchFlightModel> FindFlight(AirportModel departure, AirportModel arrival, DateTime departureDate)
        {
            //Direct
            var result = this.FindAll().Where(flight => flight.DepartureDate.Value.Date == departureDate
                        && flight.Departure.ID == departure.ID && flight.Arrival.ID == arrival.ID)
                        .Select(flight => new SearchFlightModel { FlightList = new List<FlightModel> { flight }, Price = flight.Price.Value }).ToList();
                        
            // 1 Transit
            var resutlDeparture = this.FindAll().Where(flight => flight.DepartureDate.Value.Date == departureDate && flight.Departure.ID == departure.ID);
            var resultArrival = this.FindAll().Where(flight => flight.DepartureDate.Value.Date == departureDate && flight.Arrival.ID == arrival.ID);

            var flightTransit = from departures in resutlDeparture
                        join arrivals in resultArrival on departures.Arrival.ID equals arrivals.Departure.ID
                        where arrivals.ArrivalDate > departures.DepartureDate
                        let flight = new List<FlightModel> { departures, arrivals}
                        select flight;

            foreach(var flightList in flightTransit)
                result.Add(new SearchFlightModel { FlightList = flightList, Price = flightList.Select(flight => flight.Price.Value).Sum() });

            return result;
        }

        public IEnumerable<FlightModel> FindByTicket(int ticketId, bool roundTrip = false)
        {
            var modelList = this.FlightRepository.FindByTicket(ticketId, roundTrip);
            var result = modelList.Select(model => this.CreateViewModel(model));

            return result;
        }
        #endregion

        #region Model Functions
        public FlightModel CreateViewModel(Flight model)
        {
            FlightModel viewModel = null;

            if (model != null)
            {
                viewModel = new FlightModel();
                CommonMethods.CopyObjectProperties(model, viewModel);

                //Get Departure and Arrival
                var planeAirportList = this.PlaneAirportService.FindByPlane(model.PlaneID.Value).ToList();

                viewModel.Departure = planeAirportList.Where(airport => airport.DepartureOrArrival != null 
                    && airport.DepartureOrArrival.Split('-').ToList().IndexOf(model.ID + ".d") != -1)
                    .Select(airport => airport.Airport).FirstOrDefault();
                viewModel.Arrival = planeAirportList.Where(airport => airport.DepartureOrArrival != null
                    && airport.DepartureOrArrival.Split('-').ToList().IndexOf(model.ID + ".a") != -1)
                    .Select(airport => airport.Airport).FirstOrDefault();
            }

            return viewModel;
        }
        #endregion
    }
}