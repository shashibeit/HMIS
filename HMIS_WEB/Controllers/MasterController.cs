using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HMIS.Models.Patient;
using Newtonsoft.Json.Linq;
using HMIS_WEB.Models.Case;
using HMIS_WEB.Models.Master;
using HMIS.Models.Case;
using HMIS.Models.Masters;
using Newtonsoft.Json;

namespace HMIS_WEB.Controllers
{
    public class MasterController : BaseController
    {
        // GET: Master
        public ActionResult Index()
        {
            return View();
        }


        public ActionResult MedicineMaster()
        {
            return View();
        }

        public ActionResult GheeMaster()
        {
            return View();
        }

        public ActionResult OilMaster()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GetAllMedicines(FormCollection collection)
        {

            Int32 start = Convert.ToInt32(collection["start"]);
            Int32 legnth = Convert.ToInt32(collection["length"]);

            string serchval = collection["search[value]"];

            List<ModelAllMedicine> medicileList = new MedicineModel().GetAllMedicineList( start, legnth, serchval);
            var obj = new { data = medicileList };
          
            return Json(obj, JsonRequestBehavior.AllowGet); ;
        }

        [HttpPost]
        public JsonResult GetAllGheeDetails(FormCollection collection)
        {

            
            Int32 start = Convert.ToInt32(collection["start"]);
            Int32 legnth = Convert.ToInt32(collection["length"]);

            string serchval = collection["search[value]"];

            List<ModelAllMedicine> medicileList = new ModelOilGheeMaster()._getAllOilGheeDetails("Ghee",start, legnth, serchval);
            var obj = new { data = medicileList };

            return Json(obj, JsonRequestBehavior.AllowGet); ;
        }

        [HttpPost]
        public JsonResult GetAllOilDetails(FormCollection collection)
        {


            Int32 start = Convert.ToInt32(collection["start"]);
            Int32 legnth = Convert.ToInt32(collection["length"]);

            string serchval = collection["search[value]"];

            List<ModelAllMedicine> medicileList = new ModelOilGheeMaster()._getAllOilGheeDetails("Oil", start, legnth, serchval);
            var obj = new { data = medicileList };

            return Json(obj, JsonRequestBehavior.AllowGet); ;
        }

        [HttpPost]
        public JsonResult SaveMedicineDetails(string PostData)
        {


            List<string> respList = new List<string>();
            try
            {

                var parsed = JObject.Parse(PostData);
                List<MedicineMasterModel> modelList = new List<MedicineMasterModel>();

                JArray Medicines = (JArray)parsed["Data"];

                foreach (var item in Medicines.Children())
                {
                    MedicineMasterModel model = new MedicineMasterModel();
                    var itemProperties = item.Children<JProperty>();
                    //you could do a foreach or a linq here depending on what you need to do exactly with the value
                    var MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "MedicineName");
                    model.MedicineName = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "MedicineType");
                    model.MedicineType = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "MedicineFor");
                    model.MedicineFor = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "PanchakarmaType");
                    model.PanchakarmaType = MedicineProperty.Value.ToString(); ////This is a JValue type


                    modelList.Add(model);
                }

                if (modelList.Count > 0)
                {
                    respList = new ModelMedicineMaster().InserMedicineDetails(modelList);
                }

            }
            catch (Exception ae)
            {

            }

            return Json(respList, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public JsonResult SaveGheeOilDetails(string PostData)
        {


            List<string> respList = new List<string>();
            try
            {

                var parsed = JObject.Parse(PostData);
                List<MedicineMasterModel> modelList = new List<MedicineMasterModel>();

                JArray Medicines = (JArray)parsed["Data"];

                foreach (var item in Medicines.Children())
                {
                    MedicineMasterModel model = new MedicineMasterModel();
                    var itemProperties = item.Children<JProperty>();
                    //you could do a foreach or a linq here depending on what you need to do exactly with the value
                    var MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Name");
                    model.MedicineName = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Type");
                    model.MedicineType = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "For");
                    model.MedicineFor = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "PanchakarmaType");
                    model.PanchakarmaType = MedicineProperty.Value.ToString(); ////This is a JValue type


                    modelList.Add(model);
                }

                if (modelList.Count > 0)
                {
                    respList = new ModelOilGheeMaster().InsertOilGheeDetails(modelList);
                }

            }
            catch (Exception ae)
            {

            }

            return Json(respList, JsonRequestBehavior.AllowGet);
        }
    }
}