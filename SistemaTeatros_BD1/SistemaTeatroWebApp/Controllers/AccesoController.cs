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
                var oUser = db.Usuarios.Where(u => u.Usuario == User).FirstOrDefault();

                //var oUser = (from d in db.Usuarios
                //             where d.Usuario == User.Trim()
                //             && d.Password == Pass.Trim()
                //             select d).FirstOrDefault();

                if (oUser == null)
                {
                    ViewBag.Error = "Usuario invalido";
                    return View();
                }
                else
                {
                    Usuarios uUser = new Usuarios
                    {
                        Usuario = oUser.Usuario,
                        Password = oUser.Password,
                        IdAcceso = oUser.IdAcceso,
                        CedulaPersona = oUser.CedulaPersona
                    };

                    if (HashController.ConfirmPassword(Pass, uUser.Password))
                    {
                        Session["User"] = uUser;

                        switch (uUser.IdAcceso)
                        {
                            case 0:
                                return RedirectToAction("Index", "SystemAdmin");
                            case 1:
                                return RedirectToAction("Index", "TeatroAdmin");
                            case 2:
                                return RedirectToAction("Index", "TeatroAgente");
                            default:
                                return RedirectToAction("FrontPage", "Home"); // Direccionar a Index Cliente 
                        }
                    }
                    else
                    {
                        ViewBag.Error = "Contraseña invalida";
                        return View();
                    }
                }
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                return View();
            }
        }


        public ActionResult Logout()
        {
            try
            {
                Session["User"] = null;
                return RedirectToAction("FrontPage", "Home");
            }
            catch (Exception ex)
            {
                return RedirectToAction("FrontPage", "Home");
                throw;
            }
        }
    }
}