using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SistemaTeatroWebApp.Models.AppModels
{
    public class PageAsientosDisponibles
    {
        [Display(Name = "Bloques")]
        public int? IdBloque { get; set; }

        [Display(Name = "Bloque")]
        public string NombreBloque { get; set; }

        public int? IdTeatro { get; set; }

        [Display(Name = "Teatro")]
        public string NombreTeatro { get; set; }

        public int? IdPresentacion { get; set; }

        [Display(Name = "Obra")]
        public string NombreObra { get; set; }

        [DataType(DataType.Date)]
        public DateTime Fecha { get; set; }

        [DataType(DataType.Time)]
        public TimeSpan Hora { get; set; }

        public List<AsientosDisponibles> asientos { get; set; }

        public DateTime? FechaBusquedaInicio { get; set; }

        public DateTime? FechaBusquedaFinal { get; set; }

        public int? IdProduccion { get; set; }
    }
}