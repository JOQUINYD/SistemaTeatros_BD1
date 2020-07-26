using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SistemaTeatroWebApp.Models.AppModels
{
    public class AsientosDisponibles
    {
        [Display(Name = "Fila")]
        public string Letra { get; set; }

        public string asientos { get; set; }
    }
}