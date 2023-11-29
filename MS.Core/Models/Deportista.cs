using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MS.Core.Models
{
    public class Deportista
    {
        public int Id { set; get; }
        public string? Nombre { set; get; }

        public string? CodPáis { set; get; }

        public int Valor { set; get; }
        public int Total { set; get; }

        public string? Modalidad { set; get; }
        public List<Modalidad>? Modalidades { set; get; }
    }
}
