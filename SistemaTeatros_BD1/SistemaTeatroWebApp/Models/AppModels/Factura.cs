using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SistemaTeatroWebApp.Models.AppModels
{
    public class Factura
    {
        public string NombreCliente { get; set; }

        public long Telefono { get; set; }

        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [DataType(DataType.CreditCard)]
        public string creditCard { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:MM/yyyy}")]
        public DateTime ExpirationDate { get; set; }

        [Range(100, 999, ErrorMessage = "Inválido")]
        public int CVC { get; set; }
    }
}