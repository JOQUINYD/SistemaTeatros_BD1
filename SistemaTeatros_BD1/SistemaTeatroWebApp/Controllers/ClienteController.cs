using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using SistemaTeatroWebApp.Models;
using SistemaTeatroWebApp.Models.AppModels;

namespace SistemaTeatroWebApp.Controllers
{
    public class ClienteController : Controller
    {
        private SistemaTeatros_BD1Entities db = new SistemaTeatros_BD1Entities();

        // GET: Cliente
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Cartelera(DateTime? FechaInicio, DateTime? FechaFinal)
        {
            if (FechaInicio == null || FechaFinal == null){
                return View(this.getProduccionesCartelera());
            }
            else
            {
                return View(this.getProduccionesEnFechas(FechaInicio, FechaFinal));
            }

        }

        private List<Produccion> getProduccionesEnFechas(DateTime? FechaInicio, DateTime? FechaFinal)
        {
            var producciones = db.spGetProduccionesInFechas(FechaInicio, FechaFinal);
            List<Produccion> produccionList = new List<Produccion>();
            DateTime fechaActual = DateTime.Today;
            foreach (var item in producciones)
            {
                if(!((item.IdProduccionEstado == 5 || item.IdProduccionEstado == 4) && fechaActual > item.FechaFin.AddSeconds(1)))
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
                        IdTeatro = item.IdTeatro,
                        IdProduccionEstado = item.IdProduccionEstado,
                        FechaBusquedaInicio = FechaInicio,
                        FechaBusquedaFinal = FechaFinal
                    };
                    produccionList.Add(prod);
                }
            }
            return produccionList;
        }

        private List<Produccion> getProduccionesCartelera()
        {
            var producciones = db.spGetProduccionesCartelera();
            List<Produccion> produccionList = new List<Produccion>();
            DateTime fechaActual = DateTime.Today;
            foreach (var item in producciones)
            {
                if (!((item.IdProduccionEstado == 5 || item.IdProduccionEstado == 4) && fechaActual > item.FechaFin.AddSeconds(1)))
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
                        IdTeatro = item.IdTeatro,
                        IdProduccionEstado = item.IdProduccionEstado
                    };
                    produccionList.Add(prod);
                }
            }
            return produccionList;
        }

        public ActionResult DetailsProduccion(int? IdProduccion, DateTime? FechaInicio, DateTime? FechaFinal)
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
                if(FechaInicio != null && FechaFinal != null)
                {
                    if(item.Fecha >= FechaInicio && item.Fecha <= FechaFinal)
                    {
                        presentaciones.Add(new Presentacion
                        {
                            IdPresentacion = item.Id,
                            Fecha = item.Fecha,
                            Hora = item.Hora
                        });
                    }
                }
                else
                {
                    presentaciones.Add(new Presentacion
                    {
                        IdPresentacion = item.Id,
                        Fecha = item.Fecha,
                        Hora = item.Hora
                    });
                }
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
                IdTeatro = pro.IdTeatro,
                FechaBusquedaInicio = FechaInicio,
                FechaBusquedaFinal = FechaFinal
            };

            if (pro == null)
            {
                return HttpNotFound();
            }
            return View(produccion);
        }

        public ActionResult AsientosDisponibles(int? IdPresentacion, string NombreObra, DateTime? FechaI, DateTime? FechaF, int? IdTeatro, string NombreTeatro, int? IdProduccion)
        {
            Presentaciones pre = db.Presentaciones.Where(p => p.Id == IdPresentacion).FirstOrDefault();

            PageAsientosDisponibles pad = new PageAsientosDisponibles
            {
                IdTeatro = IdTeatro,
                NombreTeatro = NombreTeatro,
                IdPresentacion = IdPresentacion,
                NombreObra = NombreObra,
                Fecha = pre.Fecha,
                Hora = pre.Hora,
                FechaBusquedaInicio = FechaI,
                FechaBusquedaFinal = FechaF,
                IdProduccion = IdProduccion
            };

            ViewBag.IdBloque = new SelectList(db.Bloques.Where(b => b.IdTeatro == IdTeatro), "Id", "NombreBloque");
            return View(pad);
        }

        [HttpPost]
        public ActionResult AsientosDisponibles(PageAsientosDisponibles pad)
        {
            pad.asientos = new List<AsientosDisponibles>();

            var bloque = db.spGetInfoBloqueById(pad.IdBloque).FirstOrDefault();
            pad.NombreBloque = bloque.NombreBloque;

            var filas = db.spGetFilasByBloque(pad.IdBloque);
            foreach (var item in filas)
            {
                string asientosDisp = db.spGetAsientosVaciosFila(pad.IdPresentacion, pad.IdBloque, item.Letra).ToString();
                pad.asientos.Add(new AsientosDisponibles
                {
                    Letra = item.Letra,
                    asientos =asientosDisp
                });
            }
            
            ViewBag.IdBloque = new SelectList(db.Bloques.Where(b => b.IdTeatro == pad.IdTeatro), "Id", "NombreBloque");
            return View(pad);
        }
    }
}