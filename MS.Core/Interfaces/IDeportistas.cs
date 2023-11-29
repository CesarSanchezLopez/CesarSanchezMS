using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MS.Core.Models;

namespace MS.Core.Interfaces
{
    public interface IDeportistas
    {
        Task<List<Deportista>> Deportistas();
        Task<List<Deportista>> DeportistasModalidad();
    }
}
