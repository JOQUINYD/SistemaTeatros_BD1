using SistemaTeatroWebApp.Filters;
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
            bool res = db.Usuarios.Any(x => x.Usuario == Usuario);
            if (res)
                return Json(false, JsonRequestBehavior.AllowGet);
            else
                return Json(true, JsonRequestBehavior.AllowGet);

        }

    }
}