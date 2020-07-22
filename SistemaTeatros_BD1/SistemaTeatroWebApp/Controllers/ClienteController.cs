using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
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
                        IdProduccionEstado = item.IdProduccionEstado
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
    }
}