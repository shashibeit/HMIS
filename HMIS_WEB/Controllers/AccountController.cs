using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HMIS_WEB.Models.Account;


namespace HMIS_WEB.Controllers
{
    public class AccountController : Controller
    {
        // GET: Account
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        public ActionResult DashBoard()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(FormCollection form)
        {
            string txtUserName = form["txtUserName"];
            string txtPassword = form["txtPassword"];
            LoginModel objLogin = new LoginModel();

            var loginPass = objLogin.PerformLogin(txtUserName, txtPassword);

            if (loginPass == true)
            {
                TempData["loginpass"] = true;
                TempData["userid"] = txtUserName;
                Session["userid"] = txtUserName;
                TempData.Keep();
                return this.RedirectToAction("Dashboard", "Home");
            }
            else {
                TempData["loginpass"] = false;
                TempData["userid"] = "";
                Session["userid"] = "";
                TempData.Keep();
                return this.RedirectToAction("Login", "Account");
            }

        }


    }
}