using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SistemaTeatroWebApp.Models.AppModels
{
    public class Fila
    {
        [Display(Name = "Letra")]
        [MaxLength(1, ErrorMessage = "Solo una letra")]
        [Required(ErrorMessage = "Selecione una Letra")]
        public string Letra { get; set; }

        [Display(Name = "Número de Asientos")]
        [MaxLength(100, ErrorMessage = "")]
        [Required(ErrorMessage = "Determine un número de asientos")]
        public int NumAsientos { get; set; }

        public int? IdBloque { get; set; }

        [Display(Name = "Bloque")]
        public string Bloque { get; set; }

        [Display(Name = "Teatro")]
        public string Teatro { get; set; }
    }
}