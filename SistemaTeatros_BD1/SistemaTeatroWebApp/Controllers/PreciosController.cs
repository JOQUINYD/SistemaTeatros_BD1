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
    public class PreciosController : Controller
    {
        private SistemaTeatros_BD1Entities db = new SistemaTeatros_BD1Entities();

        // GET: Precios
        public ActionResult Index()
        {
            var precios = db.Precios.Include(p => p.Bloques).Include(p => p.Producciones);
            return View(precios.ToList());
        }

        // GET: Precios/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Precios precios = db.Precios.Find(id);
            if (precios == null)
            {
                return HttpNotFound();
            }
            return View(precios);
        }

        // GET: Precios/Create
        public ActionResult Create()
        {
            ViewBag.IdBloque = new SelectList(db.Bloques, "Id", "NombreBloque");
            ViewBag.IdProduccion = new SelectList(db.Producciones, "Id", "NombreObra");
            return View();
        }

        // POST: Precios/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Precio,IdProduccion,IdBloque")] Precios precios)
        {
            if (ModelState.IsValid)
            {
                db.Precios.Add(precios);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdBloque = new SelectList(db.Bloques, "Id", "NombreBloque", precios.IdBloque);
            ViewBag.IdProduccion = new SelectList(db.Producciones, "Id", "NombreObra", precios.IdProduccion);
            return View(precios);
        }

        // GET: Precios/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Precios precios = db.Precios.Find(id);
            if (precios == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdBloque = new SelectList(db.Bloques, "Id", "NombreBloque", precios.IdBloque);
            ViewBag.IdProduccion = new SelectList(db.Producciones, "Id", "NombreObra", precios.IdProduccion);
            return View(precios);
        }

        // POST: Precios/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Precio,IdProduccion,IdBloque")] Precios precios)
        {
            if (ModelState.IsValid)
            {
                db.Entry(precios).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdBloque = new SelectList(db.Bloques, "Id", "NombreBloque", precios.IdBloque);
            ViewBag.IdProduccion = new SelectList(db.Producciones, "Id", "NombreObra", precios.IdProduccion);
            return View(precios);
        }

        // GET: Precios/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Precios precios = db.Precios.Find(id);
            if (precios == null)
            {
                return HttpNotFound();
            }
            return View(precios);
        }

        // POST: Precios/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Precios precios = db.Precios.Find(id);
            db.Precios.Remove(precios);
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
