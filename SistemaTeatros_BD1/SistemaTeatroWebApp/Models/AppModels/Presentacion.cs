using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SistemaTeatroWebApp.Models.AppModels
{
    public class Presentacion
    {
        [Display(Name = "Fecha de la presentación")]
        [Required(ErrorMessage = "Ingrese fecha de la presentación")]
        [DataType(DataType.Date)]
        //[Remote("isDateInRange", "TeatroAdmin", AdditionalFields="FechaInit,FechaFin", HttpMethod = "POST", ErrorMessage = "La Fecha no se encuentra en el rango disponible")]
        public DateTime Fecha { get; set; }

        [Display(Name = "Hora de la presentación")]
        [Required(ErrorMessage = "Ingrese hora de la presentación")]
        [DataType(DataType.Time)]
        //[Remote("isHoraDisponible", "TeatroAdmin", HttpMethod = "POST", ErrorMessage = "Ya existe una presentacion en la misma hora")]
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
        
        public int IdPresentacion { get; set; }
    }
}