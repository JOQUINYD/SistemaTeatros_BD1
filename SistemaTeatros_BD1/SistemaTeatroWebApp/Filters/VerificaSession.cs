using SistemaTeatroWebApp.Controllers;
using SistemaTeatroWebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SistemaTeatroWebApp.Filters
{
    public class VerificaSession : ActionFilterAttribute
    {
        private VwUsuarios oUsuario;
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            try
            {
                base.OnActionExecuting(filterContext);

                //oUsuario = (Usuarios)HttpContext.Current.Session["User"];
                //if (oUsuario == null)
                //{
                //    if (filterContext.Controller is AccesoController == false)
                //    {
                //        filterContext.HttpContext.Response.Redirect("/Home/Index");
                //    }
                //}
            }
            catch (Exception)
            {
                filterContext.Result = new RedirectResult("~/Home/FrontPage");
            }
        }
    }
}