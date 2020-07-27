using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using SistemaTeatroWebApp.Filters;
using SistemaTeatroWebApp.Models;
using SistemaTeatroWebApp.Models.AppModels;

namespace SistemaTeatroWebApp.Controllers
{
    public class TeatroAgenteController : Controller
    {
        private SistemaTeatros_BD1Entities db = new SistemaTeatros_BD1Entities();

        // GET: Cliente
        [AuthorizeUser(IdAcceso: 2)]
        public ActionResult Index()
        {
            return View();
        }

        [AuthorizeUser(IdAcceso: 2)]
        public ActionResult Cartelera(DateTime? FechaInicio, DateTime? FechaFinal)
        {
            if (FechaInicio == null || FechaFinal == null)
            {
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

            var oUsuario = (VwUsuarios)System.Web.HttpContext.Current.Session["User"];
            var idTeatro = (int?)db.spGetIdTeatroFromUsuario(oUsuario.Usuario).FirstOrDefault();

            foreach (var item in producciones)
            {
                if (!((item.IdProduccionEstado == 5 || item.IdProduccionEstado == 4) && fechaActual > item.FechaFin.AddMonths(1)))
                {
                    if (idTeatro == item.IdTeatro)
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
            }
            return produccionList;
        }

        private List<Produccion> getProduccionesCartelera()
        {
            var producciones = db.spGetProduccionesCartelera();
            List<Produccion> produccionList = new List<Produccion>();
            DateTime fechaActual = DateTime.Today;

            var oUsuario = (VwUsuarios)System.Web.HttpContext.Current.Session["User"];
            var idTeatro = (int?)db.spGetIdTeatroFromUsuario(oUsuario.Usuario).FirstOrDefault();

            foreach (var item in producciones)
            {
                if (!((item.IdProduccionEstado == 5 || item.IdProduccionEstado == 4) && fechaActual > item.FechaFin.AddSeconds(1)))
                {
                    if (idTeatro == item.IdTeatro)
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
            }
            return produccionList;
        }

        [AuthorizeUser(IdAcceso: 2)]
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
                if (FechaInicio != null && FechaFinal != null)
                {
                    if (item.Fecha >= FechaInicio && item.Fecha <= FechaFinal)
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

        [AuthorizeUser(IdAcceso: 2)]
        public ActionResult AsientosDisponibles(int? IdPresentacion, string NombreObra, DateTime? FechaI, DateTime? FechaF, int? IdTeatro, string NombreTeatro, int? IdProduccion)
        {
            var pre = db.spGetPresentacionById(IdPresentacion).FirstOrDefault();

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

            ViewBag.IdBloque = new SelectList(db.spGetBloquesByTeatroConPrecio(pad.IdTeatro, pad.IdPresentacion), "Id", "NombreBloque");
            return View(pad);
        }

        [HttpPost]
        [AuthorizeUser(IdAcceso: 2)]
        public ActionResult AsientosDisponibles(PageAsientosDisponibles pad)
        {
            pad.asientos = new List<AsientosDisponibles>();

            var bloque = db.spGetInfoBloqueById(pad.IdBloque).FirstOrDefault();
            pad.NombreBloque = bloque.NombreBloque;

            var filas = db.spGetFilasByBloque(pad.IdBloque);
            foreach (var item in filas)
            {

                string asientosDisp = string.Join(" - ", db.spGetAsientosVaciosFila(pad.IdPresentacion, pad.IdBloque, item.Letra));

                pad.asientos.Add(new AsientosDisponibles
                {
                    Letra = item.Letra,
                    asientos = asientosDisp
                });
            }

            ViewBag.IdBloque = new SelectList(db.spGetBloquesByTeatroConPrecio(pad.IdTeatro, pad.IdPresentacion), "Id", "NombreBloque");
            return View(pad);
        }

        [AuthorizeUser(IdAcceso: 2)]
        public ActionResult EscogerBloque(int? IdPresentacion)
        {
            var presentacionInfo = db.spGetPresentacionById(IdPresentacion).FirstOrDefault();
            CompraBoleto cp = new CompraBoleto
            {
                IdPresentacion = IdPresentacion,
                NombreObra = presentacionInfo.NombreObra,
                NombreTeatro = presentacionInfo.NombreTeatro,
                IdTeatro = presentacionInfo.IdTeatro,
                Fecha = presentacionInfo.Fecha,
                Hora = presentacionInfo.Hora,
                cantidadAsientos = 1
            };

            ViewBag.IdBloque = new SelectList(db.spGetBloquesByTeatroConPrecio(cp.IdTeatro, cp.IdPresentacion), "Id", "NombreBloque");
            return View(cp);
        }

        [HttpPost]
        [AuthorizeUser(IdAcceso: 2)]
        public ActionResult EscogerBloque(CompraBoleto cp)
        {
            Console.WriteLine(cp.IdPresentacion);
            Console.WriteLine(cp.IdPresentacion);
            if (ModelState.IsValid)
            {
                return RedirectToAction("EscogerFila", new { IdPresentacion = cp.IdPresentacion, IdBloque = cp.IdBloque });
            }

            var presentacionInfo = db.spGetPresentacionById(cp.IdPresentacion).FirstOrDefault();
            cp = new CompraBoleto
            {
                IdPresentacion = presentacionInfo.Id,
                NombreObra = presentacionInfo.NombreObra,
                NombreTeatro = presentacionInfo.NombreTeatro,
                IdTeatro = presentacionInfo.IdTeatro,
                Fecha = presentacionInfo.Fecha,
                Hora = presentacionInfo.Hora
            };
            ViewBag.IdBloque = new SelectList(db.spGetBloquesByTeatroConPrecio(cp.IdTeatro, cp.IdPresentacion), "Id", "NombreBloque");
            return View(cp);
        }

        [AuthorizeUser(IdAcceso: 2)]
        public ActionResult EscogerFila(int? IdPresentacion, int? IdBloque)
        {
            var presentacionInfo = db.spGetPresentacionById(IdPresentacion).FirstOrDefault();
            var bloqueInfo = db.spGetInfoBloqueById(IdBloque).FirstOrDefault();
            CompraBoleto cp = new CompraBoleto
            {
                IdPresentacion = IdPresentacion,
                NombreObra = presentacionInfo.NombreObra,
                NombreTeatro = presentacionInfo.NombreTeatro,
                IdTeatro = presentacionInfo.IdTeatro,
                Fecha = presentacionInfo.Fecha,
                Hora = presentacionInfo.Hora,
                IdBloque = IdBloque,
                NombreBloque = bloqueInfo.NombreBloque,
                asientos = new List<AsientosDisponibles>()
            };

            var filas = db.spGetFilasByBloque(cp.IdBloque);
            foreach (var item in filas)
            {

                string asientosDisp = string.Join(" - ", db.spGetAsientosVaciosFila(cp.IdPresentacion, cp.IdBloque, item.Letra));

                cp.asientos.Add(new AsientosDisponibles
                {
                    Letra = item.Letra,
                    asientos = asientosDisp
                });
            }

            ViewBag.Letra = new SelectList(db.spGetFilasByBloque(IdBloque), "Letra", "Letra");
            string[] pagos = { "Efectivo", "Tarjeta de credito" };
            ViewBag.paymentMethod = new SelectList(pagos);
            return View(cp);
        }

        [HttpPost]
        [AuthorizeUser(IdAcceso: 2)]
        public ActionResult EscogerFila(CompraBoleto cp)
        {
            if (ModelState.IsValid)
            {
                if(cp.paymentMethod == "Tarjeta de credito")
                {
                    return RedirectToAction("ComprarBoletos", new { IdPresentacion = cp.IdPresentacion, IdBloque = cp.IdBloque, Letra = cp.Letra, cantAsientos = cp.cantidadAsientos });
                }
                else
                {
                    return RedirectToAction("ComprarBoletosEfectivo", new { IdPresentacion = cp.IdPresentacion, IdBloque = cp.IdBloque, Letra = cp.Letra, cantAsientos = cp.cantidadAsientos });
                }
            }
            return View();
        }

        [AuthorizeUser(IdAcceso: 2)]
        public ActionResult ComprarBoletos(int? IdPresentacion, int? IdBloque, string Letra, int cantAsientos)
        {
            var presentacionInfo = db.spGetPresentacionById(IdPresentacion).FirstOrDefault();
            var bloqueInfo = db.spGetInfoBloqueById(IdBloque).FirstOrDefault();
            var precioBloque = db.spGetPrecioByPresBloque(IdPresentacion, IdBloque).FirstOrDefault();
            CompraBoleto cp = new CompraBoleto
            {
                IdPresentacion = IdPresentacion,
                NombreObra = presentacionInfo.NombreObra,
                NombreTeatro = presentacionInfo.NombreTeatro,
                IdTeatro = presentacionInfo.IdTeatro,
                IdBloque = IdBloque,
                NombreBloque = bloqueInfo.NombreBloque,
                Letra = Letra,
                Fecha = presentacionInfo.Fecha,
                Hora = presentacionInfo.Hora,
                asientos = new List<AsientosDisponibles>(),
                factura = new Factura(),
                cantidadAsientos = cantAsientos,
                precioTotal = (decimal)precioBloque * cantAsientos
            };


            string asientosDisp = string.Join(" - ", db.spGetAsientosVaciosFila(cp.IdPresentacion, cp.IdBloque, cp.Letra));

            cp.asientos.Add(new AsientosDisponibles
            {
                Letra = cp.Letra,
                asientos = asientosDisp
            });

            return View(cp);
        }

        [HttpPost]
        [AuthorizeUser(IdAcceso: 2)]
        public ActionResult ComprarBoletos(CompraBoleto cp, int[] Dist)
        {
            cp.factura = PaymentController.processPayment(cp.factura, (int)cp.precioTotal);

            if (cp.factura.aprobado)
            {
                try
                {
                    PaymentController.storePayment(cp, Dist);

                    Email email = new Email();

                    email.SendEmail("pruebatecjj@gmail.com", "2019380125", "pruebatecjj@gmail.com", "Factura #" + cp.factura.numeroDeComprobacion, PaymentController.getFacturaEmailBody(cp, Dist));

                    ViewBag.PaymentResult = "Compra realizada con exito. Se le enviara un correo con la factura. Gracias";
                    return View(cp);
                }
                catch (Exception)
                {
                    ViewBag.PaymentResult = "No se pudo realizar la compra. Lo sentimos";
                    return View(cp);
                    throw;
                }
            }
            else
            {
                ViewBag.PaymentResult = "Metodo de pago no aceptado. Compra no realizada. Lo sentimos";
                return View(cp);
            }
        }

        [AuthorizeUser(IdAcceso: 2)]
        public ActionResult ComprarBoletosEfectivo(int? IdPresentacion, int? IdBloque, string Letra, int cantAsientos)
        {
            var presentacionInfo = db.spGetPresentacionById(IdPresentacion).FirstOrDefault();
            var bloqueInfo = db.spGetInfoBloqueById(IdBloque).FirstOrDefault();
            var precioBloque = db.spGetPrecioByPresBloque(IdPresentacion, IdBloque).FirstOrDefault();
            CompraBoleto cp = new CompraBoleto
            {
                IdPresentacion = IdPresentacion,
                NombreObra = presentacionInfo.NombreObra,
                NombreTeatro = presentacionInfo.NombreTeatro,
                IdTeatro = presentacionInfo.IdTeatro,
                IdBloque = IdBloque,
                NombreBloque = bloqueInfo.NombreBloque,
                Letra = Letra,
                Fecha = presentacionInfo.Fecha,
                Hora = presentacionInfo.Hora,
                asientos = new List<AsientosDisponibles>(),
                factura = new Factura(),
                cantidadAsientos = cantAsientos,
                precioTotal = (decimal)precioBloque * cantAsientos
            };


            string asientosDisp = string.Join(" - ", db.spGetAsientosVaciosFila(cp.IdPresentacion, cp.IdBloque, cp.Letra));

            cp.asientos.Add(new AsientosDisponibles
            {
                Letra = cp.Letra,
                asientos = asientosDisp
            });

            return View(cp);
        }

        [HttpPost]
        [AuthorizeUser(IdAcceso: 2)]
        public ActionResult ComprarBoletosEfectivo(CompraBoleto cp, int[] Dist)
        {
            cp.factura = PaymentController.processPaymentEfectivo(cp.factura);

            try
            {
                PaymentController.storePayment(cp, Dist);

                Email email = new Email();

                email.SendEmail("pruebatecjj@gmail.com", "2019380125", "pruebatecjj@gmail.com", "Factura #" + cp.factura.numeroDeComprobacion, PaymentController.getFacturaEmailBody(cp, Dist));

                ViewBag.PaymentResult = "Compra realizada con exito. Se le enviara un correo con la factura. Gracias";
                return View(cp);
            }
            catch (Exception)
            {
                ViewBag.PaymentResult = "No se pudo realizar la compra. Lo sentimos";
                return View(cp);
                throw;
            }
        }
    }
}