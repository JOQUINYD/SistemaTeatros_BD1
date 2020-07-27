using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SistemaTeatroWebApp.Models.AppModels
{
    public class PreciosModel
    {
        [Display(Name = "Precio")]
        [Required(ErrorMessage = "Ingrese el precio del bloque")]
        [RegularExpression(@"^\d+\.\d{0,4}$", ErrorMessage = "Solo se admiten 4 decimales de precision")]
        [Range(0, 999999999999999.9999, ErrorMessage = "Tamaño maximo excedido")]
        public decimal Precio { get; set; }

        public int? Id { get; set; }

        public int? IdProduccion { get; set; }

        [Display(Name = "Bloque")]
        [Required(ErrorMessage = "Seleccione un bloque")]
        public int? IdBloque { get; set; }

        [Display(Name = "Bloque")]
        public string NombreBloque { get; set; }

        [Display(Name = "Producción")]
        public string NombreProduccion { get; set; }

        public int? IdTeatro { get; set; }
    }
}