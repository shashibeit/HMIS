using HMIS.Models.Home;
using System.Web.Mvc;
using HMIS_WEB.Models.Home;
using HMIS.Models.Case;
using System.Collections.Generic;

namespace HMIS_WEB.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DashBoard()
        {

            ModelDashboard model = new ModelDashboard();
          

            model = new HomeModel()._getDashboardData();

            ViewBag.TodaysPatient = model.TodaysPatients;
            ViewBag.TodaysCases = model.TodaysCases;
            ViewBag.TotalPatient = model.TotalPatients;
            ViewBag.TotalCases = model.TotalCases;


            return View();
        }

        [HttpPost]
        public JsonResult GetFollowupDetails() {
            List<ModelFollowup> followupList = new List<ModelFollowup>();
            return Json(new HomeModel()._getFollowupDetails(), JsonRequestBehavior.AllowGet);
        }


        public ActionResult AnotherLink()
        {
            return View("Index");
        }
    }
}
