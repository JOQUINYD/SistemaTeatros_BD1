using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SistemaTeatroWebApp.Models.AppModels
{
    public class Produccion
    {
        [Display(Name = "Nombre de la obra")]
        [Required(ErrorMessage = "Ingrese nombre de la obra")]
        public string NombreObra { get; set; }

        [Display(Name = "Fecha de inicio")]
        [Required(ErrorMessage = "Ingrese la fecha de inicio")]
        [DataType(DataType.Date)]
        public DateTime FechaInit { get; set; }

        [Display(Name = "Fecha final")]
        [Required(ErrorMessage = "Ingrese la fecha final")]
        [DataType(DataType.Date)]
        public DateTime FechaFin { get; set; }

        [Display(Name = "Tipo")]
        [Required(ErrorMessage = "Ingrese el tipo (Ej. Danza)")]
        public string Tipo { get; set; }

        [Display(Name = "Teatro")]
        public int IdTeatro { get; set; }

        [Display(Name = "Descripción (Max 300 char)")]
        [Required(ErrorMessage = "Ingrese una descripción")]
        public string Descripcion { get; set; }

        [Display(Name = "Estado")]
        [Required(ErrorMessage = "Ingrese Estado")]
        public int IdProduccionEstado { get; set; }

        public string Teatro { get; set; }

        public string Estado { get; set; }

    }
}