using SistemaTeatroWebApp.Filters;
using SistemaTeatroWebApp.Models;
using SistemaTeatroWebApp.Models.AppModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace SistemaTeatroWebApp.Controllers
{
    public class SystemAdminController : Controller
    {
        private SistemaTeatros_BD1Entities db = new SistemaTeatros_BD1Entities();

        // GET: SystemAdmin
        public ActionResult Index()
        {
            return View();
        }

        // GET: Usuarios/Create
        [AuthorizeUser(IdAcceso: 0)]
        public ActionResult CreateUsuario()
        {
            ViewBag.IdAcceso = new SelectList(db.Accesos, "Id", "Tipo");
            ViewBag.IdTeatro = new SelectList(db.Teatros, "Id", "Nombre");
            return View();
        }

        // POST: Usuarios/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [AuthorizeUser(IdAcceso: 0)]
        public ActionResult CreateUsuario(UsuarioCompleto usuarioCompleto)
        {
            if (ModelState.IsValid)
            {
                Personas persona = new Personas
                {
                    Cedula = usuarioCompleto.Cedula,
                    Nombre = usuarioCompleto.Nombre,
                    Sexo = usuarioCompleto.Sexo,
                    Direccion_ = usuarioCompleto.Direccion,
                    TelefonoCelular = usuarioCompleto.TelefonoCelular,
                    TelefonoCasa = usuarioCompleto.TelefonoCasa,
                    TelefonoOtro = usuarioCompleto.TelefonoOtro,
                    Email = usuarioCompleto.Email,
                    IdTeatro = usuarioCompleto.IdTeatro
                };
                if (usuarioCompleto.IdAcceso == 0)
                {
                    persona.IdTeatro = null;
                }
                // Cambiar a stored procedures
                db.Personas.Add(persona);
                db.SaveChanges();

                Usuarios usuario = new Usuarios
                {
                    Usuario = usuarioCompleto.Usuario,
                    Password = usuarioCompleto.Password, // aqui se debe hacer el hash y salt
                    IdAcceso = usuarioCompleto.IdAcceso,
                    CedulaPersona = usuarioCompleto.Cedula
                };

                db.Usuarios.Add(usuario);
                db.SaveChanges();

                return RedirectToAction("Index");
            }

            ViewBag.IdAcceso = new SelectList(db.Accesos, "Id", "Tipo");
            ViewBag.IdTeatro = new SelectList(db.Teatros, "Id", "Nombre");
            return View(usuarioCompleto);
        }
    }
}