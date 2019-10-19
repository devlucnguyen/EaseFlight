﻿using EaseFlight.BLL.Interfaces;
using EaseFlight.Common.Utilities;
using EaseFlight.DAL.Entities;
using EaseFlight.DAL.Interfaces;
using EaseFlight.DAL.UnitOfWorks;
using EaseFlight.Models.EntityModels;
using System.Collections.Generic;
using System.Linq;

namespace EaseFlight.BLL.Services
{
    public class PlaneAirportService : BaseService, IPlaneAirportService
    {
        #region Properties
        private IPlaneAirportRepository PlaneAirportRepository { get; set; }
        #endregion

        #region Constructors
        public PlaneAirportService(IUnitOfWork unitOfWork,
            IPlaneAirportRepository planeAirportRepository) : base(unitOfWork)
        {
            this.PlaneAirportRepository = planeAirportRepository;
        }
        #endregion

        #region Functions
        public IEnumerable<PlaneAirportModel> FindAll()
        {
            var modelList = this.PlaneAirportRepository.FindAll();
            var result = modelList.Select(model => this.CreateViewModel(model));

            return result;
        }
        #endregion

        #region Model Functions
        public PlaneAirportModel CreateViewModel(PlaneAirport model)
        {
            PlaneAirportModel viewModel = null;

            if (model != null)
            {
                viewModel = new PlaneAirportModel();
                CommonMethods.CopyObjectProperties(model, viewModel);
            }

            return viewModel;
        }
        #endregion
    }
}