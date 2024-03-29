﻿using SistemaTeatroWebApp.Filters;
using SistemaTeatroWebApp.Models;
using SistemaTeatroWebApp.Models.AppModels;
using System;
using System.Collections.Generic;
using System.Drawing.Printing;
using System.Linq;
using System.Net;
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
            ViewBag.IdAcceso = new SelectList(db.spGetAccesoById(2), "Id", "Tipo");

            var oUsuario = (VwUsuarios)System.Web.HttpContext.Current.Session["User"];
            var idTeatro = (int?)db.spGetIdTeatroFromUsuario(oUsuario.Usuario).FirstOrDefault();

            ViewBag.IdTeatro = new SelectList(db.spGetTeatroById(idTeatro), "Id", "Nombre");
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
                string password = HashController.ComputeHash(usuarioCompleto.Password, null);

                db.spAddPersonaAndUsuario(usuarioCompleto.Nombre, usuarioCompleto.FechaNac, usuarioCompleto.Cedula, usuarioCompleto.Direccion, usuarioCompleto.TelefonoCelular, usuarioCompleto.TelefonoCelular,
                                            usuarioCompleto.TelefonoOtro, usuarioCompleto.Email, usuarioCompleto.IdTeatro, usuarioCompleto.Sexo, usuarioCompleto.Usuario, password, usuarioCompleto.IdAcceso);

                return RedirectToAction("Index");
            }

            ViewBag.IdAcceso = new SelectList(db.spGetAccesoById(2), "Id", "Tipo");

            var oUsuario = (VwUsuarios)System.Web.HttpContext.Current.Session["User"];
            var idTeatro = (int?)db.spGetIdTeatroFromUsuario(oUsuario.Usuario).FirstOrDefault();

            ViewBag.IdTeatro = new SelectList(db.spGetTeatroById(idTeatro), "Id", "Nombre");
            return View(usuarioCompleto);
        }

        // GET: Producciones/Create
        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult CreateProduccion()
        {
            ViewBag.IdProduccionEstado = new SelectList(db.ProduccionEstados.Where(e => e.Id == 0).ToList(), "Id", "Estado");
            //var oUsuario = (Usuarios)Session["User"];
            var oUsuario = (VwUsuarios) System.Web.HttpContext.Current.Session["User"];
            var idTeatro = (int?)db.spGetIdTeatroFromUsuario(oUsuario.Usuario).FirstOrDefault();

            ViewBag.IdTeatro = new SelectList(db.spGetTeatroById(idTeatro), "Id", "Nombre");
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
                return RedirectToAction("IndexProduccion");
            }

            ViewBag.IdProduccionEstado = new SelectList(db.spGetProduccionesEstadoById(0), "Id", "Estado");
            var oUsuario = (VwUsuarios)Session["User"];
            var idTeatro = (int?)db.spGetIdTeatroFromUsuario(oUsuario.Usuario).FirstOrDefault();

            ViewBag.IdTeatro = new SelectList(db.spGetTeatroById(idTeatro), "Id", "Nombre");
            return View(produccion);
        }



        // GET: Presentaciones/Create
        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult CreatePresentacion(int? IdProduccion, string NombreProduccion, DateTime FechaInit, DateTime FechaFin)
        {
            Presentacion presentacion = new Presentacion
            {
                IdProduccion = IdProduccion,
                Produccion = NombreProduccion,
                FechaInit = FechaInit.Date,
                FechaFin = FechaFin.Date,
                Fecha = FechaInit,
                Hora = DateTime.Now.TimeOfDay
            };
            return View(presentacion);
        }

        // POST: Presentaciones/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult CreatePresentacion(Presentacion presentacion)
        {
            if (ModelState.IsValid)
            {
                if(presentacion.Fecha >= presentacion.FechaInit && presentacion.Fecha <= presentacion.FechaFin)
                {
                    var oUsuario = (VwUsuarios)System.Web.HttpContext.Current.Session["User"];
                    int? idTeatro = (int?)db.spGetIdTeatroFromUsuario(oUsuario.Usuario).FirstOrDefault();
                    if (!db.spGetPresentacionesByFechaHora(presentacion.Fecha, presentacion.Hora, idTeatro).Any())
                    {
                        db.spAddPresentacion(presentacion.Fecha, presentacion.Hora, presentacion.IdProduccion);
                        return RedirectToAction("IndexProduccion");
                    }
                    ViewBag.Error = "Ya existe alguna presentacion con la misma hora";
                    return View(presentacion);
                }
                ViewBag.Error = "Fecha Fuera del rango de la produccion";
                return View(presentacion);
            }
            return View(presentacion);
        }

        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult IndexProduccion()
        {
            var oUsuario = (VwUsuarios)System.Web.HttpContext.Current.Session["User"];
            int? idTeatro = (int?)db.spGetIdTeatroFromUsuario(oUsuario.Usuario).FirstOrDefault();

            var producciones = db.spGetProduccionesByTeatro(idTeatro);
            var produccionList = new List<Produccion>();
            foreach (var item in producciones)
            {
                Produccion prod = new Produccion
                {
                    Id = item.Id,
                    Descripcion = item.Descripcion,
                    NombreObra = item.NombreObra,
                    FechaInit = item.FechaInit.Date,
                    FechaFin = item.FechaFin.Date,
                    Tipo = item.Tipo,
                    Estado = item.Estado,
                    Teatro = item.Nombre,
                    IdTeatro = idTeatro
                };
                produccionList.Add(prod);
            }

            return View(produccionList);
        }

        // GET: Producciones/Details/5
        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult DetailsProduccion(int? IdProduccion)
        {
            if (IdProduccion == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var pro = db.spGetProduccionById(IdProduccion).FirstOrDefault();
            var presentacionesDB = db.spGetPresentacionesByProduccion(IdProduccion);

            List<Presentacion> presentaciones = new List<Presentacion>();
            foreach (var item in presentacionesDB)
            {
                presentaciones.Add(new Presentacion
                {
                    Fecha = item.Fecha,
                    Hora = item.Hora
                });
            }

            var preciosDB = db.spGetPreciosByProduccion(IdProduccion);
            List<PreciosModel> precios = new List<PreciosModel>();
            foreach (var item in preciosDB)
            {
                PreciosModel p = new PreciosModel
                {
                    NombreBloque = item.NombreBloque,
                    Precio = item.Precio
                };
                precios.Add(p);
            }

            Produccion produccion = new Produccion
            {
                Id = IdProduccion,
                NombreObra = pro.NombreObra,
                FechaInit = pro.FechaInit,
                FechaFin = pro.FechaFin,
                Tipo = pro.Tipo,
                Descripcion = pro.Descripcion,
                Teatro = pro.Nombre,
                Estado = pro.Estado,
                presentaciones = presentaciones,
                precios = precios,
                IdTeatro = pro.IdTeatro
            };

            if (pro == null)
            {
                return HttpNotFound();
            }
            return View(produccion);
        }

        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult UpdateStateProduccion(int? id, string nombreTeatro )
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var produccion = db.spGetProduccionById(id).FirstOrDefault();
            Produccion prod = new Produccion
            {
                Id = produccion.Id,
                NombreObra = produccion.NombreObra,
                IdProduccionEstado = produccion.IdProduccionEstado, 
                Teatro = nombreTeatro                
            };
            if (prod == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdProduccionEstado = new SelectList(db.spGetProduccionesEstados(), "Id", "Estado", prod.IdProduccionEstado);

            return View(prod);
        }

        // POST: Producciones/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult UpdateStateProduccion(Produccion produccion)
        {
            Console.WriteLine(ModelState.IsValid);
            Console.WriteLine(produccion.Id);
            Console.WriteLine(produccion.IdProduccionEstado);
            try
            {
                db.spCambiarEstadoProduccion(produccion.IdProduccionEstado, produccion.Id);
                return RedirectToAction("DetailsProduccion", new { IdProduccion = produccion.Id });
            }
            catch (Exception)
            {
                ViewBag.IdProduccionEstado = new SelectList(db.spGetProduccionesEstados(), "Id", "Estado", produccion.IdProduccionEstado);
                return View(produccion);
                throw;
            }
        }

        // GET: Precios/Create
        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult CreatePrecio(int? IdProduccion, string NombreProduccion, int? IdTeatro)
        {
            ViewBag.IdBloque = new SelectList(db.spGetBloqueByTeatro(IdTeatro), "Id", "NombreBloque");

            PreciosModel precioM = new PreciosModel
            {
                IdProduccion = IdProduccion,
                NombreProduccion = NombreProduccion,
                IdTeatro = IdTeatro
            };
            return View(precioM);
        }

        // POST: Precios/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [AuthorizeUser(IdAcceso: 1)]
        public ActionResult CreatePrecio(PreciosModel precioM)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    db.spAddPrecio(precioM.IdProduccion, precioM.IdBloque, precioM.Precio);
                    return RedirectToAction("DetailsProduccion", new { IdProduccion = precioM.IdProduccion });
                }
                catch (Exception)
                {
                    ViewBag.IdBloque = new SelectList(db.spGetBloqueByTeatro(precioM.IdTeatro), "Id", "NombreBloque", precioM.IdBloque);
                    return View(precioM);
                    throw;
                }
                
            }

            ViewBag.IdBloque = new SelectList(db.spGetBloqueByTeatro(precioM.IdTeatro), "Id", "NombreBloque", precioM.IdBloque);
            return View(precioM);
        }

        [HttpPost]
        [AllowAnonymous]
        public JsonResult isDateInRange(DateTime Fecha, DateTime FechaInit, DateTime FechaFin)
        {
            bool res = Fecha >= FechaInit && Fecha <= FechaFin;
            if (res)
                return Json(false, JsonRequestBehavior.AllowGet);
            else
                return Json(true, JsonRequestBehavior.AllowGet);

        }

    }

}