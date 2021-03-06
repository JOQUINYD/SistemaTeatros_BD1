﻿using SistemaTeatroWebApp.Filters;
using SistemaTeatroWebApp.Models;
using SistemaTeatroWebApp.Models.AppModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Security.Policy;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace SistemaTeatroWebApp.Controllers
{
    public class SystemAdminController : Controller
    {
        private SistemaTeatros_BD1Entities db = new SistemaTeatros_BD1Entities();

        // GET: SystemAdmin
        [AuthorizeUser(IdAcceso: 0)]
        public ActionResult Index()
        {
            return View();
        }

        // GET: Usuarios/Create
        [AuthorizeUser(IdAcceso: 0)]
        public ActionResult CreateUsuario()
        {
            ViewBag.IdAcceso = new SelectList(db.Accesos, "Id", "Tipo");
            ViewBag.IdTeatro = new SelectList(db.spGetTeatros(), "Id", "Nombre");
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

                if (usuarioCompleto.IdAcceso == 0)
                {
                    usuarioCompleto.IdTeatro = null;
                }

                string password = HashController.ComputeHash(usuarioCompleto.Password, null);

                db.spAddPersonaAndUsuario(usuarioCompleto.Nombre, usuarioCompleto.FechaNac, usuarioCompleto.Cedula, usuarioCompleto.Direccion, usuarioCompleto.TelefonoCelular, usuarioCompleto.TelefonoCelular,
                                            usuarioCompleto.TelefonoOtro, usuarioCompleto.Email, usuarioCompleto.IdTeatro, usuarioCompleto.Sexo, usuarioCompleto.Usuario, password, usuarioCompleto.IdAcceso);

                return RedirectToAction("Index");
            }

            ViewBag.IdAcceso = new SelectList(db.spGetAccesoById(1), "Id", "Tipo");
            ViewBag.IdTeatro = new SelectList(db.spGetTeatros(), "Id", "Nombre");
            return View(usuarioCompleto);
        }



        // GET: Teatros/Create
        [AuthorizeUser(IdAcceso: 0)]
        public ActionResult CreateTeatro()
        {
            return View();
        }

        // POST: Teatros/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [AuthorizeUser(IdAcceso: 0)]
        public ActionResult CreateTeatro( Teatro teatro)
        {
            if (ModelState.IsValid)
            {

                db.spAddTeatro(teatro.Nombre, teatro.Boleteria, teatro.Email, teatro.SitioWeb, teatro.Telefono);

                return RedirectToAction("IndexTeatro");
            }

            return View(teatro);
        }


        // GET: Teatros
        [AuthorizeUser(IdAcceso: 0)]
        public ActionResult IndexTeatro()
        {
            var teatrosDB = db.spGetTeatros().ToList();

            List<Teatro> teatros = new List<Teatro>();
            foreach (var item in teatrosDB)
            {
                teatros.Add(new Teatro
                {
                    Id = item.Id,
                    Nombre = item.Nombre,
                    Boleteria = item.Boleteria,
                    Email = item.Email,
                    SitioWeb = item.SitioWeb,
                    Telefono = item.Telefono
                });
            }
            return View(teatros);
        }

        // GET: Teatros/Details/5
        [AuthorizeUser(IdAcceso: 0)]
        public ActionResult DetailsTeatro(int? IdTeatro)
        {
            if (IdTeatro == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var teatroDB = db.spGetTeatroById(IdTeatro).FirstOrDefault();

            if (teatroDB == null)
            {
                return HttpNotFound();
            }

            var bloquesBD = db.spGetBloqueByTeatro(IdTeatro);
            List<Bloque> bloques = new List<Bloque>();
            List<Fila> filas = null;
            foreach (var bloque in bloquesBD)
            {
                filas = new List<Fila>();
                var filasDB = db.spGetFilasByBloque(bloque.Id);
                foreach (var fila in filasDB)
                {
                    filas.Add(new Fila
                    {
                        Letra = fila.Letra,
                        NumAsientos = fila.NumAsientos,
                        IdBloque = fila.IdBloque,
                        Bloque = bloque.NombreBloque,
                        Teatro = teatroDB.Nombre
                    });
                }

                bloques.Add(new Bloque
                {
                    Id = bloque.Id,
                    NombreBloque = bloque.NombreBloque,
                    IdTeatro = bloque.IdTeatro,
                    Teatro = teatroDB.Nombre,
                    Filas = filas
                });
            }

            Teatro teatro = new Teatro
            {
                Id = teatroDB.Id,
                Nombre = teatroDB.Nombre,
                Email = teatroDB.Email,
                Boleteria = teatroDB.Boleteria,
                SitioWeb = teatroDB.SitioWeb,
                Telefono = teatroDB.Telefono,
                Bloques = bloques
            };

            return View(teatro);
        }

        // GET: Bloques/Create
        [AuthorizeUser(IdAcceso: 0)]
        public ActionResult CreateBloque(int? IdTeatro, string NombreTeatro)
        {
            Bloque bloque = new Bloque
            {
                IdTeatro = IdTeatro,
                Teatro = NombreTeatro
            };
            return View(bloque);
        }

        // POST: Bloques/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [AuthorizeUser(IdAcceso: 0)]
        public ActionResult CreateBloque(Bloque bloque)
        {
            if (ModelState.IsValid)
            {
                db.spAddBloque(bloque.NombreBloque, bloque.IdTeatro);
                return RedirectToAction("DetailsTeatro", new { IdTeatro = bloque.IdTeatro});
            }

            return View(bloque);
        }

        // GET: Filas/Create
        [AuthorizeUser(IdAcceso: 0)]
        public ActionResult CreateFila(int? IdBloque, string NombreBloque, int? IdTeatro, string NombreTeatro)
        {
            var lastFila = db.spGetFilasByBloque(IdBloque).ToList();
            char letra = 'A';

            if(lastFila.Any())
            {
                letra = lastFila.Last().Letra.ToCharArray().First();
                
                if (letra == 'Z')
                {
                    return RedirectToAction("DetailsTeatro", new { IdTeatro = IdTeatro });
                }
                letra = (char)(((int)letra) + 1);
            }
            
            Fila fila = new Fila
            {
                Letra = letra.ToString(),
                IdBloque = IdBloque,
                Bloque = NombreBloque,
                IdTeatro = IdTeatro,
                Teatro = NombreTeatro,
                NumAsientos = 10
            };

            return View(fila);
        }

        // POST: Filas/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [AuthorizeUser(IdAcceso: 0)]
        public ActionResult CreateFila(Fila fila)
        {
            if (ModelState.IsValid)
            {
                db.spAddFila(fila.IdBloque, fila.Letra, fila.NumAsientos);
                return RedirectToAction("DetailsTeatro", new { IdTeatro = fila.IdTeatro });
            }

            return View(fila);
        }

        [HttpPost]
        [AllowAnonymous]
        public JsonResult doesCedulaExist(long Cedula)
        {
            bool res = db.Usuarios.Any(x => x.CedulaPersona == Cedula);
            if (res)
                return Json(false, JsonRequestBehavior.AllowGet);
            else
                return Json(true, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        [AllowAnonymous]
        public JsonResult doesUsuarioExist(string Usuario)
        {
            bool res = db.spGetMatchingUser(Usuario).Any();
            if (res)
                return Json(false, JsonRequestBehavior.AllowGet);
            else
                return Json(true, JsonRequestBehavior.AllowGet);

        }

    }
}