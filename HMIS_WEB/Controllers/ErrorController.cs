﻿using System.Web.Mvc;

namespace HMIS_WEB.Controllers
{
    public class ErrorController : Controller
    {
        public ActionResult InternalServerError()
        {

            return View();
        }

        public ActionResult NotFound()
        {
            return View();
        }
    }
}
