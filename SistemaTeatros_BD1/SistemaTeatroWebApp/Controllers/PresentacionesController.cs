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
    public class PresentacionesController : Controller
    {
        private SistemaTeatros_BD1Entities db = new SistemaTeatros_BD1Entities();

        // GET: Presentaciones
        public ActionResult Index()
        {
            var presentaciones = db.Presentaciones.Include(p => p.Producciones);
            return View(presentaciones.ToList());
        }

        // GET: Presentaciones/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Presentaciones presentaciones = db.Presentaciones.Find(id);
            if (presentaciones == null)
            {
                return HttpNotFound();
            }
            return View(presentaciones);
        }

        // GET: Presentaciones/Create
        public ActionResult Create()
        {
            ViewBag.IdProduccion = new SelectList(db.Producciones, "Id", "NombreObra");
            return View();
        }

        // POST: Presentaciones/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Fecha,Hora,IdProduccion")] Presentaciones presentaciones)
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

        // GET: Presentaciones/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Presentaciones presentaciones = db.Presentaciones.Find(id);
            if (presentaciones == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdProduccion = new SelectList(db.Producciones, "Id", "NombreObra", presentaciones.IdProduccion);
            return View(presentaciones);
        }

        // POST: Presentaciones/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Fecha,Hora,IdProduccion")] Presentaciones presentaciones)
        {
            if (ModelState.IsValid)
            {
                db.Entry(presentaciones).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdProduccion = new SelectList(db.Producciones, "Id", "NombreObra", presentaciones.IdProduccion);
            return View(presentaciones);
        }

        // GET: Presentaciones/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Presentaciones presentaciones = db.Presentaciones.Find(id);
            if (presentaciones == null)
            {
                return HttpNotFound();
            }
            return View(presentaciones);
        }

        // POST: Presentaciones/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Presentaciones presentaciones = db.Presentaciones.Find(id);
            db.Presentaciones.Remove(presentaciones);
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
