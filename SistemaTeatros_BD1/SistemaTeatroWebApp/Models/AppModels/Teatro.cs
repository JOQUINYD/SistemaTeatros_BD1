using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SistemaTeatroWebApp.Models.AppModels
{
    public class Teatro
    {
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Debe ingresar el nombre")]
        [MaxLength(50, ErrorMessage = "Debe tener máximo 50 caracteres")]
        public string Nombre { get; set; }

        [Display(Name = "Boleteria")]
        [Required(ErrorMessage = "Debe ingresar la Boleteria")]
        public int Boleteria { get; set; }

        [Display(Name = "Email")]
        [MaxLength(320, ErrorMessage = "Debe tener máximo 320 caracteres")]
        [Required(ErrorMessage = "Debe ingresar el Email")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }


        [Display(Name = "Sitio Web")]
        [MaxLength(500, ErrorMessage = "Debe tener máximo 500 caracteres")]
        [Required(ErrorMessage = "Debe ingresar el Sitio Web")]
        public string SitioWeb { get; set; }


        [Display(Name = "Numero de Teléfono")]
        [Required(ErrorMessage = "Debe ingresar el número de teléfono")]
        public int  Telefono { get; set; }

        public int? Id { get; set; }

    }
}