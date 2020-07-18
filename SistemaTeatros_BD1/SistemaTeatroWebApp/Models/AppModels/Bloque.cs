using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SistemaTeatroWebApp.Models.AppModels
{
    public class Bloque
    {
        public int? Id { get; set; }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Ingrese un nombre para el bloque")]
        public string NombreBloque { get; set; }

        public int? IdTeatro { get; set; }

        [Display(Name = "Teatro")]
        public string Teatro { get; set; }

        public List<Fila> Filas { get; set; }
    }
}