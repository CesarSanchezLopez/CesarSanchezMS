﻿using MS.Core.Models;

namespace MS.Api.Interfaces
{
    public interface IDeportistasController
    {

        Task<List<Deportista>> Deportistas();
        Task<List<Deportista>> DeportistasModalidad();
        Task<int> InsertarDeportistaModalidad(int idDeportista, int idModalidad, int valor);
    }
}
