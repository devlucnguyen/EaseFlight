﻿using EaseFlight.Models.EntityModels;
using System.Collections.Generic;

namespace EaseFlight.BLL.Interfaces
{
    public interface IPassengerTicketService
    {
        IEnumerable<PassengerTicketModel> FindAll();
    }
}