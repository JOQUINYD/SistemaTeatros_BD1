using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SistemaTeatroWebApp.Models.AppModels
{
    public class Presentacion
    {
        [Display(Name = "Fecha de la presentación")]
        [Required(ErrorMessage = "Ingrese fecha de la presentación")]
        [DataType(DataType.Date)]
        public DateTime Fecha { get; set; }

        [Display(Name = "Hora de la presentación")]
        [Required(ErrorMessage = "Ingrese hora de la presentación")]
        [DataType(DataType.Time)]
        public TimeSpan Hora { get; set; }

        [Display(Name = "Producción")]
        public string Produccion { get; set; }

        [Display(Name = "Comienza")]
        [DataType(DataType.Date)]
        public DateTime FechaInit { get; set; }

        [Display(Name = "Termina")]
        [DataType(DataType.Date)]
        public DateTime FechaFin { get; set; }

        public int? IdProduccion { get; set; }
    }
}