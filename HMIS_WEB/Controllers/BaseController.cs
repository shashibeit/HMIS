using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HMIS_WEB.Controllers
{
    public class BaseController : Controller
    {
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (Session["userid"] == null)
            {
                filterContext.Result = new RedirectResult("~/Account/Login");
                return;
            }
            
        }

    }
}