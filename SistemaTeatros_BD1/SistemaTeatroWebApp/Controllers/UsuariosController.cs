using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using SistemaTeatroWebApp.Filters;
using SistemaTeatroWebApp.Models;
using SistemaTeatroWebApp.Models.AppModels;

namespace SistemaTeatroWebApp.Controllers
{
    public class UsuariosController : Controller
    {
        private SistemaTeatros_BD1Entities db = new SistemaTeatros_BD1Entities();

        // GET: Usuarios
        [AuthorizeUser(IdAcceso: 10)]
        public ActionResult Index()
        {
            var usuarios = db.Usuarios.Include(u => u.Accesos).Include(u => u.Personas);
            return View(usuarios.ToList());
        }

        // GET: Usuarios/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Usuarios usuarios = db.Usuarios.Find(id);
            if (usuarios == null)
            {
                return HttpNotFound();
            }
            return View(usuarios);
        }

        // GET: Usuarios/Create
        [AuthorizeUser(IdAcceso: 0)]
        public ActionResult Create()
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
        public ActionResult Create(UsuarioCompleto usuarioCompleto)
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
                if(usuarioCompleto.IdAcceso == 0)
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

        // GET: Usuarios/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Usuarios usuarios = db.Usuarios.Find(id);
            if (usuarios == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdAcceso = new SelectList(db.Accesos, "Id", "Tipo", usuarios.IdAcceso);
            ViewBag.CedulaPersona = new SelectList(db.Personas, "Cedula", "Nombre", usuarios.CedulaPersona);
            return View(usuarios);
        }

        // POST: Usuarios/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Usuario,Password,IdAcceso,CedulaPersona")] Usuarios usuarios)
        {
            if (ModelState.IsValid)
            {
                db.Entry(usuarios).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdAcceso = new SelectList(db.Accesos, "Id", "Tipo", usuarios.IdAcceso);
            ViewBag.CedulaPersona = new SelectList(db.Personas, "Cedula", "Nombre", usuarios.CedulaPersona);
            return View(usuarios);
        }

        // GET: Usuarios/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Usuarios usuarios = db.Usuarios.Find(id);
            if (usuarios == null)
            {
                return HttpNotFound();
            }
            return View(usuarios);
        }

        // POST: Usuarios/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            Usuarios usuarios = db.Usuarios.Find(id);
            db.Usuarios.Remove(usuarios);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
