using SistemaTeatroWebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SistemaTeatroWebApp.Controllers
{
    public class AccesoController : Controller
    {
        private SistemaTeatros_BD1Entities db = new SistemaTeatros_BD1Entities();

        // GET: Acceso
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string User, string Pass)
        {
            try
            {
                var oUser = db.spGetMatchingUser(User, Pass).FirstOrDefault();

                //var oUser = (from d in db.Usuarios
                //             where d.Usuario == User.Trim()
                //             && d.Password == Pass.Trim()
                //             select d).FirstOrDefault();

                if (oUser == null)
                {
                    ViewBag.Error = "Usuario o contraseña invalida";
                    return View();
                }

                Usuarios uUser = new Usuarios
                {
                    Usuario = oUser.Usuario,
                    Password = oUser.Password,
                    IdAcceso = oUser.IdAcceso,
                    CedulaPersona = oUser.CedulaPersona
                };

                Session["User"] = uUser;
                if(uUser.IdAcceso == 0)
                {
                    return RedirectToAction("Index", "SystemAdmin");
                }
                return View();
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                return View();
            }
        }
    }
}