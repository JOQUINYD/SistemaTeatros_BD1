using System;
using System.Net;
using System.Net.Mail;
using System.Web.Mvc;

namespace SistemaTeatroWebApp.Controllers
{
    public class Email : Controller
    {
        MailMessage message = new MailMessage();
        SmtpClient smtp = new SmtpClient();

        public bool SendEmail(string mFrom, string pFrom, string mTo, string subject, string text)
        {
            try
            {
                this.message.From = new MailAddress(mFrom);
                this.message.To.Add(new MailAddress(mTo));

                this.message.Body = text;
                this.message.BodyEncoding = System.Text.Encoding.UTF8;
                this.smtp.UseDefaultCredentials = true;

                this.message.Subject = subject;

                this.smtp.Credentials = new NetworkCredential(mFrom, pFrom);
                this.smtp.Port = 587;
                this.smtp.Host = "smtp.gmail.com";
                this.smtp.EnableSsl = true;
                this.smtp.Send(message);
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.StackTrace);
                return false;

            }
        }


        // GET: Email
        public ActionResult Index()
        {
            return View();
        }
    }
}