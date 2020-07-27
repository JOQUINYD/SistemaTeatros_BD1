using SistemaTeatroWebApp.Models.AppModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SistemaTeatroWebApp.Controllers
{
    public class PaymentController : Controller
    {
        // GET: Payment
        public ActionResult Index()
        {
            return View();
        }

        public static Factura processPayment(Factura factura, int monto)
        {
            if ((monto % 2 == 0) != (factura.CVC % 2 == 0))
            {
                Random random = new Random();

                factura.FechaHoraAprobacion = DateTime.Now;
                factura.aprobado = true;
                factura.numeroDeComprobacion = random.Next(100000, 999999);
                return factura;
            }
            else
            {
                factura.aprobado = false;
                return factura;
            }
        }

        public static Factura processPaymentEfectivo(Factura factura)
        {
            Random random = new Random();
            factura.FechaHoraAprobacion = DateTime.Now;
            factura.aprobado = true;
            factura.numeroDeComprobacion = random.Next(100000, 999999);
            return factura;
        }

        public static void storePayment(CompraBoleto cp, int[] Dist)
        {
            var builder = new SqlConnectionStringBuilder();
            builder.DataSource = @"DESKTOP-ED7N4A2";
            builder.InitialCatalog = "SistemaTeatros_BD1";
            builder.IntegratedSecurity = true;

            var connectionString = builder.ToString();

            using (SqlConnection sql = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spCompraBoletosYFactura", sql))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@Nombre_Cliente", cp.factura.NombreCliente));
                    cmd.Parameters.Add(new SqlParameter("@Email", cp.factura.Email));
                    cmd.Parameters.Add(new SqlParameter("@Fecha", cp.factura.FechaHoraAprobacion));
                    cmd.Parameters.Add(new SqlParameter("@Telefono", cp.factura.Telefono));
                    cmd.Parameters.Add(new SqlParameter("@Hora", cp.factura.FechaHoraAprobacion.TimeOfDay));
                    cmd.Parameters.Add(new SqlParameter("@Numero_Aprobacion", cp.factura.numeroDeComprobacion));
                    cmd.Parameters.Add(new SqlParameter("@Boletos", getBoletosTable(cp.IdPresentacion, cp.IdBloque, cp.Letra, Dist)));
                    sql.Open();
                    cmd.ExecuteNonQuery();
                    sql.Close();
                }
            }
        }

        public static DataTable getBoletosTable(int? IdPresentacion, int? IdBloque, string Letra, int[] dist)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("IdPresentacion");
            dt.Columns.Add("LetraFila");
            dt.Columns.Add("IdBloqueFila");
            dt.Columns.Add("NumAsiento");

            foreach (var asiento in dist)
            {
                dt.Rows.Add(IdPresentacion, Letra, IdBloque, asiento);
            }

            return dt;
        }


        public static string getFacturaEmailBody(CompraBoleto cp, int[] Dist)
        {
            string body = "----------------- " + cp.NombreTeatro + " -----------------@";
            body += "Produccion: " + cp.NombreObra + "@";
            body += "Fecha: " + cp.Fecha + "@";
            body += "Hora: " + cp.Hora.ToString() + "@";
            body += "Bloque: " + cp.NombreBloque + "@";
            body += "Fila: " + cp.Letra + "@";
            body += "Asientos: " + string.Join(" - ", Dist) + "@";
            body += "----------------- Información de pago -----------------@";
            body += "Precio Total: " + cp.precioTotal.ToString() + "@";
            body += "Cliente: " + cp.factura.NombreCliente + "@";
            body += "Código de Factura: " + cp.factura.numeroDeComprobacion + "@@";
            body += "----------------- Gracias por su compra -----------------";

            body = body.Replace("@", System.Environment.NewLine);

            return body;
        }
    }
}