using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SistemaTeatroWebApp.Models.AppModels
{
    public class UsuarioCompleto
    {
        //Atributos Persona

        [Display(Name = "Telefono Celular")]
        public long? TelefonoCelular { get; set; }

        [Display(Name = "Telefono Casa")]
        public long? TelefonoCasa { get; set; }

        [Display(Name = "Telefono Otro")]
        public long? TelefonoOtro { get; set; }

        [Display(Name = "Cédula")]
        [Required(ErrorMessage = "Tiene que ingresar su cédula")]
        [Remote("doesCedulaExist", "SystemAdmin", HttpMethod = "POST", ErrorMessage = "Este usuario ya ha sido registrado")]
        public long Cedula { get; set; }

        [Required(ErrorMessage = "Ingrese su nombre completo")]
        public string Nombre { get; set; }

        [Display(Name = "Fecha de nacimiento")]
        [Required(ErrorMessage = "Ingresar fecha de nacimiento")]
        [DataType(DataType.Date)]
        public DateTime FechaNac { get; set; }

        [Required(ErrorMessage = "Selecione un sexo")]
        public string Sexo { get; set; }

        [Required(ErrorMessage = "Ingresar direccion")]
        public string Direccion { get; set; }

        [Display(Name = "Email")]
        [Required(ErrorMessage = "Ingresar su Email")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [Display(Name = "Teatro a trabajar")]
        public int? IdTeatro { get; set; }

        // Atributos usuario

        [Display(Name = "Nombre de usuario unico")]
        [MaxLength(50, ErrorMessage = "Nombre de usuario debe ser menor a 50 caracteres")]
        [Required(ErrorMessage = "Tiene que ingresar su usuario")]
        [Remote("doesUsuarioExist", "SystemAdmin", HttpMethod = "POST", ErrorMessage = "Este usuario ya ha sido registrado")]
        public string Usuario { get; set; }

        [Display(Name = "Contraseña")]
        [MaxLength(25, ErrorMessage = "Contraseña debe ser menor a 25 caracteres")]
        [Required(ErrorMessage = "Ingresar Contraseña!")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Display(Name = "Confirmar Contraseña")]
        [MaxLength(25, ErrorMessage = "Contraseña debe ser menor a 25 caracteres")]
        [Required(ErrorMessage = "Ingresar Contraseña!")]
        [DataType(DataType.Password)]
        [System.ComponentModel.DataAnnotations.Compare("Password")]
        public string ConfirmPassword { get; set; }

        [Display(Name = "Nivel de autorización")]
        public int IdAcceso { get; set; }
    }
}