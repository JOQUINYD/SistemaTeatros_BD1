using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using SistemaTeatroWebApp.Models;

namespace SistemaTeatroWebApp.Controllers
{
    public class ProduccionesController : Controller
    {
        private SistemaTeatros_BD1Entities db = new SistemaTeatros_BD1Entities();

        // GET: Producciones
        public ActionResult Index()
        {
            var producciones = db.Producciones.Include(p => p.ProduccionEstados).Include(p => p.Teatros);
            return View(producciones.ToList());
        }

        // GET: Producciones/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Producciones producciones = db.Producciones.Find(id);
            if (producciones == null)
            {
                return HttpNotFound();
            }
            return View(producciones);
        }

        // GET: Producciones/Create
        public ActionResult Create()
        {
            ViewBag.IdProduccionEstado = new SelectList(db.ProduccionEstados, "Id", "Estado");
            ViewBag.IdTeatro = new SelectList(db.Teatros, "Id", "Nombre");
            return View();
        }

        // POST: Producciones/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,NombreObra,FechaInit,FechaFin,Tipo,IdTeatro,Descripcion,IdProduccionEstado")] Producciones producciones)
        {
            if (ModelState.IsValid)
            {
                db.Producciones.Add(producciones);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdProduccionEstado = new SelectList(db.ProduccionEstados, "Id", "Estado", producciones.IdProduccionEstado);
            ViewBag.IdTeatro = new SelectList(db.Teatros, "Id", "Nombre", producciones.IdTeatro);
            return View(producciones);
        }

        // GET: Producciones/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Producciones producciones = db.Producciones.Find(id);
            if (producciones == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdProduccionEstado = new SelectList(db.ProduccionEstados, "Id", "Estado", producciones.IdProduccionEstado);
            ViewBag.IdTeatro = new SelectList(db.Teatros, "Id", "Nombre", producciones.IdTeatro);
            return View(producciones);
        }

        // POST: Producciones/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,NombreObra,FechaInit,FechaFin,Tipo,IdTeatro,Descripcion,IdProduccionEstado")] Producciones producciones)
        {
            if (ModelState.IsValid)
            {
                db.Entry(producciones).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdProduccionEstado = new SelectList(db.ProduccionEstados, "Id", "Estado", producciones.IdProduccionEstado);
            ViewBag.IdTeatro = new SelectList(db.Teatros, "Id", "Nombre", producciones.IdTeatro);
            return View(producciones);
        }

        // GET: Producciones/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Producciones producciones = db.Producciones.Find(id);
            if (producciones == null)
            {
                return HttpNotFound();
            }
            return View(producciones);
        }

        // POST: Producciones/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Producciones producciones = db.Producciones.Find(id);
            db.Producciones.Remove(producciones);
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
