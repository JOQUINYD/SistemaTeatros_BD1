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
    public class BloquesController : Controller
    {
        private SistemaTeatros_BD1Entities db = new SistemaTeatros_BD1Entities();

        // GET: Bloques
        public ActionResult Index()
        {
            var bloques = db.Bloques.Include(b => b.Teatros);
            return View(bloques.ToList());
        }

        // GET: Bloques/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Bloques bloques = db.Bloques.Find(id);
            if (bloques == null)
            {
                return HttpNotFound();
            }
            return View(bloques);
        }

        // GET: Bloques/Create
        public ActionResult Create()
        {
            ViewBag.IdTeatro = new SelectList(db.Teatros, "Id", "Nombre");
            return View();
        }

        // POST: Bloques/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,NombreBloque,IdTeatro")] Bloques bloques)
        {
            if (ModelState.IsValid)
            {
                db.Bloques.Add(bloques);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdTeatro = new SelectList(db.Teatros, "Id", "Nombre", bloques.IdTeatro);
            return View(bloques);
        }

        // GET: Bloques/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Bloques bloques = db.Bloques.Find(id);
            if (bloques == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdTeatro = new SelectList(db.Teatros, "Id", "Nombre", bloques.IdTeatro);
            return View(bloques);
        }

        // POST: Bloques/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,NombreBloque,IdTeatro")] Bloques bloques)
        {
            if (ModelState.IsValid)
            {
                db.Entry(bloques).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdTeatro = new SelectList(db.Teatros, "Id", "Nombre", bloques.IdTeatro);
            return View(bloques);
        }

        // GET: Bloques/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Bloques bloques = db.Bloques.Find(id);
            if (bloques == null)
            {
                return HttpNotFound();
            }
            return View(bloques);
        }

        // POST: Bloques/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Bloques bloques = db.Bloques.Find(id);
            db.Bloques.Remove(bloques);
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
