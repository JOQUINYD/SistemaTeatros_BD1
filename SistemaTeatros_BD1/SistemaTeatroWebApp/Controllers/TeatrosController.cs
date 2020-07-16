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
    public class TeatrosController : Controller
    {
        private SistemaTeatros_BD1Entities db = new SistemaTeatros_BD1Entities();

        // GET: Teatros
        public ActionResult Index()
        {
            return View(db.Teatros.ToList());
        }

        // GET: Teatros/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Teatros teatros = db.Teatros.Find(id);
            if (teatros == null)
            {
                return HttpNotFound();
            }
            return View(teatros);
        }

        // GET: Teatros/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Teatros/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Nombre,Boleteria,Email,SitioWeb,Telefono")] Teatros teatros)
        {
            if (ModelState.IsValid)
            {
                db.Teatros.Add(teatros);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(teatros);
        }

        // GET: Teatros/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Teatros teatros = db.Teatros.Find(id);
            if (teatros == null)
            {
                return HttpNotFound();
            }
            return View(teatros);
        }

        // POST: Teatros/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Nombre,Boleteria,Email,SitioWeb,Telefono")] Teatros teatros)
        {
            if (ModelState.IsValid)
            {
                db.Entry(teatros).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(teatros);
        }

        // GET: Teatros/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Teatros teatros = db.Teatros.Find(id);
            if (teatros == null)
            {
                return HttpNotFound();
            }
            return View(teatros);
        }

        // POST: Teatros/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Teatros teatros = db.Teatros.Find(id);
            db.Teatros.Remove(teatros);
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
