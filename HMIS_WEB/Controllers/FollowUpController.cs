using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HMIS_WEB.Models.Case;

namespace HMIS_WEB.Controllers
{
    public class FollowUpController : Controller
    {
        // GET: FollowUp
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult FollowupDetails()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GetFollowupDetilsByCase(string CaseID)
        {
            //List<ModelFollowup> followupList = new List<ModelFollowup>();
            return Json(new FollowupModel()._getFollowupDetailsByCase(CaseID), JsonRequestBehavior.AllowGet);
        }

    }
}