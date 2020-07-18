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
    public class FilasController : Controller
    {
        private SistemaTeatros_BD1Entities db = new SistemaTeatros_BD1Entities();

        // GET: Filas
        public ActionResult Index()
        {
            var filas = db.Filas.Include(f => f.Bloques);
            return View(filas.ToList());
        }

        // GET: Filas/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Filas filas = db.Filas.Find(id);
            if (filas == null)
            {
                return HttpNotFound();
            }
            return View(filas);
        }

        // GET: Filas/Create
        public ActionResult Create()
        {
            ViewBag.IdBloque = new SelectList(db.Bloques, "Id", "NombreBloque");
            return View();
        }

        // POST: Filas/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Letra,NumAsientos,IdBloque")] Filas filas)
        {
            if (ModelState.IsValid)
            {
                db.Filas.Add(filas);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdBloque = new SelectList(db.Bloques, "Id", "NombreBloque", filas.IdBloque);
            return View(filas);
        }

        // GET: Filas/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Filas filas = db.Filas.Find(id);
            if (filas == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdBloque = new SelectList(db.Bloques, "Id", "NombreBloque", filas.IdBloque);
            return View(filas);
        }

        // POST: Filas/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Letra,NumAsientos,IdBloque")] Filas filas)
        {
            if (ModelState.IsValid)
            {
                db.Entry(filas).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdBloque = new SelectList(db.Bloques, "Id", "NombreBloque", filas.IdBloque);
            return View(filas);
        }

        // GET: Filas/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Filas filas = db.Filas.Find(id);
            if (filas == null)
            {
                return HttpNotFound();
            }
            return View(filas);
        }

        // POST: Filas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            Filas filas = db.Filas.Find(id);
            db.Filas.Remove(filas);
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
