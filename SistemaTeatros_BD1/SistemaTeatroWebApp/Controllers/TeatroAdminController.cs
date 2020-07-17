using SistemaTeatroWebApp.Filters;
using SistemaTeatroWebApp.Models;
using SistemaTeatroWebApp.Models.AppModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Mvc;
using WebGrease;

namespace SistemaTeatroWebApp.Controllers
{
    public class TeatroAdminController : Controller
    {
        private SistemaTeatros_BD1Entities db = new SistemaTeatros_BD1Entities();

        // GET: TeatroAdmin
        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult Index()
        {
            return View();
        }


        // GET: Usuarios/Create
        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult CreateUsuario()
        {
            ViewBag.IdAcceso = new SelectList(db.Accesos.Where(i => i.Id != 0).ToList(), "Id", "Tipo");
            ViewBag.IdTeatro = new SelectList(db.Teatros, "Id", "Nombre");
            return View();
        }

        // POST: Usuarios/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult CreateUsuario(UsuarioCompleto usuarioCompleto)
        {
            if (ModelState.IsValid)
            {
                Personas persona = new Personas
                {
                    Cedula = usuarioCompleto.Cedula,
                    Nombre = usuarioCompleto.Nombre,
                    Sexo = usuarioCompleto.Sexo,
                    Direccion = usuarioCompleto.Direccion,
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
                    Password = HashController.ComputeHash(usuarioCompleto.Password, null), // aqui se debe hacer el hash y salt
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

        // GET: Producciones/Create
        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult CreateProduccion()
        {
            ViewBag.IdProduccionEstado = new SelectList(db.ProduccionEstados.Where(e => e.Id == 0).ToList(), "Id", "Estado");
            //var oUsuario = (Usuarios)Session["User"];
            var oUsuario = (Usuarios) System.Web.HttpContext.Current.Session["User"];
            var idTeatro = (from d in db.Personas
                            where d.Cedula == oUsuario.CedulaPersona
                            select d.IdTeatro).FirstOrDefault();
            ViewBag.IdTeatro = new SelectList(db.Teatros.Where(t => t.Id == idTeatro), "Id", "Nombre");
            return View();
        }

        // POST: Producciones/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult CreateProduccion(Produccion produccion)
        {
            if (ModelState.IsValid)
            {
                db.spAddProduccion(produccion.NombreObra, produccion.Descripcion, produccion.Tipo, produccion.FechaInit, produccion.FechaFin, produccion.IdTeatro);
                return RedirectToAction("Index");
            }

            ViewBag.IdProduccionEstado = new SelectList(db.ProduccionEstados.Where(e => e.Id == 0).ToList(), "Id", "Estado");
            var oUsuario = (Usuarios)Session["User"];
            ViewBag.IdTeatro = new SelectList(db.Teatros.Where(t => t.Id == oUsuario.Personas.IdTeatro), "Id", "Nombre");
            return View(produccion);
        }



        // GET: Presentaciones/Create
        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult CreatePresentacion()
        {
            ViewBag.IdProduccion = new SelectList(db.Producciones, "Id", "NombreObra");
            return View();
        }

        // POST: Presentaciones/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult CreatePresentacion([Bind(Include = "Id,Fecha,Hora,IdProduccion")] Presentaciones presentaciones)
        {
            if (ModelState.IsValid)
            {
                db.Presentaciones.Add(presentaciones);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdProduccion = new SelectList(db.Producciones, "Id", "NombreObra", presentaciones.IdProduccion);
            return View(presentaciones);
        }

        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult IndexProduccion()
        {
            var oUsuario = (Usuarios)System.Web.HttpContext.Current.Session["User"];
            int? idTeatro = (int?)db.spGetIdTeatroFromUsuario(oUsuario.Usuario).FirstOrDefault();

            var producciones = db.spGetProduccionesByTeatro(idTeatro);
            var produccionList = new List<Produccion>();
            foreach (var item in producciones)
            {
                Produccion prod = new Produccion
                {
                    Descripcion = item.Descripcion,
                    NombreObra = item.NombreObra,
                    FechaInit = item.FechaInit.Date,
                    FechaFin = item.FechaFin.Date,
                    Tipo = item.Tipo,
                    Estado = item.Estado,
                    Teatro = item.Nombre

                };
                produccionList.Add(prod);
            }

            return View(produccionList);
        }



    }

}