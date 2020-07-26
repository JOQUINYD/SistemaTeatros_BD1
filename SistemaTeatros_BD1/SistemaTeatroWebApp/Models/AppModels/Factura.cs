using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SistemaTeatroWebApp.Models.AppModels
{
    public class Factura
    {
        [Display(Name = "Nombre Tarjeta habitante")]
        public string NombreCliente { get; set; }

        public long Telefono { get; set; }

        [Display(Name = "Correo electronico")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [DataType(DataType.CreditCard)]
        public string creditCard { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:MM/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime ExpirationDate { get; set; }

        [Range(100, 999, ErrorMessage = "Inválido")]
        public int CVC { get; set; }

        public bool aprobado { get; set; }

        public int numeroDeComprobacion { get; set; }

        public DateTime FechaHoraAprobacion { get; set; }

    }
}