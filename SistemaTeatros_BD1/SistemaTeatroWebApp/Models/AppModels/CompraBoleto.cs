using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Web;

namespace SistemaTeatroWebApp.Models.AppModels
{
    public class CompraBoleto
    {
        public int? IdTeatro { get; set; }

        [Display(Name = "Teatro")]
        public string NombreTeatro { get; set; }

        public int? IdPresentacion { get; set; }

        [Display(Name = "Obra")]
        public string NombreObra { get; set; }

        [Display(Name = "Bloque")]
        [Required(ErrorMessage = "Seleccione un bloque")]
        public int? IdBloque { get; set; }

        [Display(Name = "Bloque")]
        public string NombreBloque { get; set; }

        [Display(Name = "Fila")]
        public string Letra { get; set; }

        [DataType(DataType.Date)]
        public DateTime Fecha { get; set; }
        
        [DataType(DataType.Time)]
        public TimeSpan Hora { get; set; }

        public List<AsientosDisponibles> asientos { get; set; }

        public Factura factura { get; set; }

        [Display(Name = "Cantidad de Asientos")]
        [Range(1, 8, ErrorMessage = "Mínimo 1 asiento - Máximo 8 asientos")]
        public int cantidadAsientos { get; set; }

        [Display(Name = "Precio Total")]
        public decimal precioTotal { get; set; }
    }
}