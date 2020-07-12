using SistemaTeatroWebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SistemaTeatroWebApp.Filters
{
    [AttributeUsage(AttributeTargets.Method, AllowMultiple = false)]
    public class AuthorizeUser : AuthorizeAttribute
    {
        private Usuarios oUsuario;
        private SistemaTeatros_BD1Entities db = new SistemaTeatros_BD1Entities();
        private int IdAcceso;

        public AuthorizeUser(int IdAcceso = 0)
        {
            this.IdAcceso = IdAcceso; 
        }

        public override void OnAuthorization(AuthorizationContext filterContext)
        {

            try
            {
                oUsuario = (Usuarios)HttpContext.Current.Session["User"];

                if(oUsuario.IdAcceso != this.IdAcceso)
                {
                    filterContext.Result = new RedirectResult("~/Home/Index");
                }
            }
            catch (Exception ex)
            {
                filterContext.Result = new RedirectResult("~/Home/Index");
            }
        }

    }
}