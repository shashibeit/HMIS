using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HMIS.Models.Case;
using HMIS.Models.Patient;
using Newtonsoft.Json.Linq;
using HMIS_WEB.Models.Case;

namespace HMIS_WEB.Controllers
{
    public class CaseController : BaseController
    {
        // GET: Case
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Create()
        {
            if (Session["Patient_ID"] != null)
            {
                ModelNewPatient patient = GetPatient(Convert.ToInt64(Session["Patient_ID"]));
                TempData["PatientID"] = Session["Patient_ID"].ToString();
                TempData["PatientName"] = patient.PatientName.ToString();
                TempData["Address"] = patient.Address.ToString();
                TempData["City"] = patient.City.ToString();
                TempData["Pin"] = patient.Pin.ToString();
                TempData["MobileNo"] = patient.MobileNo.ToString();
                TempData["BirthDate"] = patient.BirthDate.ToString();
                TempData["Age"] = patient.Age.ToString();

            }
            else
            {
                TempData["PatientID"] = "";
                TempData["PatientName"] = "";
                TempData["Address"] = "";
                TempData["City"] = ""; ;
                TempData["Pin"] = "";
                TempData["MobileNo"] = "";
                TempData["BirthDate"] = "";
                TempData["Age"] = "";

            }



            return View();
        }

        public ActionResult Diagnosis()
        {
            return View();
        }

        public ActionResult Medicine()
        {
            return View();
        }

        public ActionResult Vaman()
        {
            return View();
        }

        public ActionResult Nasya()
        {
            return View();
        }

        public ActionResult Virechana()
        {
            return View();
        }

        public ActionResult RaktaMokshana()
        {
            return View();
        }

        public ActionResult Basti()
        {
            return View();
        }

        public ModelNewPatient GetPatient(Int64 Patient_ID)
        {
            return new CreateCase().GetPatientDetails(Patient_ID);
        }

        [HttpPost]
        public JsonResult GetPatientDetails(Int64 Patient_ID)
        {
            return Json(new CreateCase().GetPatientDetails(Patient_ID), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GetPatients(string PostData)
        {
            var parsed = JObject.Parse(PostData);

            string SearchName = parsed.SelectToken("SearchData.SearchName").Value<string>();
            string SearchCity = parsed.SelectToken("SearchData.SearchCity").Value<string>();
            string SearchContact = parsed.SelectToken("SearchData.SearchContact").Value<string>();

            return Json(new CreateCase().GetPatients(SearchName, SearchCity, SearchContact), JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public JsonResult GetVamanDetails(string CaseID)
        {
            return Json(new PanchakarmaModel()._getVamanDetails(CaseID), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult CreateCase(string PostData)
        {

            CreateCase caseObj = new CreateCase();
            var parsed = JObject.Parse(PostData);

            Int64 Patient_ID = parsed.SelectToken("PatientDetails.Patient_ID").Value<Int64>();



            NadiDetails nadi = new NadiDetails();


            nadi.Nadi = parsed.SelectToken("NadiDetails.Nadi").Value<string>();
            nadi.Mala = parsed.SelectToken("NadiDetails.Mala").Value<string>();
            nadi.Mutra = parsed.SelectToken("NadiDetails.Mutra").Value<string>();
            nadi.Avastha = parsed.SelectToken("NadiDetails.Avastha").Value<string>();
            nadi.Prakruti = parsed.SelectToken("NadiDetails.Prakruti").Value<string>();


            List<Complaints> complaintsList = new List<Complaints>();
            JArray Complaints = (JArray)parsed["ComplaintDetails"];


            foreach (var item in Complaints.Children())
            {
                Complaints cmp = new Complaints();
                var itemProperties = item.Children<JProperty>();
                //you could do a foreach or a linq here depending on what you need to do exactly with the value
                var ComplaintProperty = itemProperties.FirstOrDefault(x => x.Name == "Complaint");
                cmp.Complaint = ComplaintProperty.Value.ToString(); ////This is a JValue type

                ComplaintProperty = itemProperties.FirstOrDefault(x => x.Name == "DurationDays");
                cmp.DurationDays = ComplaintProperty.Value.ToString(); ////This is a JValue type
                ComplaintProperty = itemProperties.FirstOrDefault(x => x.Name == "DurationMonths");
                cmp.DurationMonths = ComplaintProperty.Value.ToString(); ////This is a JValue type
                ComplaintProperty = itemProperties.FirstOrDefault(x => x.Name == "DurationYears");
                cmp.DurationYears = ComplaintProperty.Value.ToString(); ////This is a JValue type

                complaintsList.Add(cmp);
            }


            ComplaintsDetaills cmpDetails = new ComplaintsDetaills();

            cmpDetails.PastMedicalHistory = parsed.SelectToken("MedicalHistory.PastMedicalHistory").Value<string>();
            cmpDetails.PastDrugsHistory = parsed.SelectToken("MedicalHistory.PastDrugsHistory").Value<string>();
            cmpDetails.FamilyHistory = parsed.SelectToken("MedicalHistory.FamilyHistory").Value<string>();
            cmpDetails.ComplaintList = complaintsList;


            DailyRoutine routine = new DailyRoutine();

            routine.WakeupTime = parsed.SelectToken("DailyRoutine.WakeupTime").Value<string>();
            routine.WaterBeforeTea = parsed.SelectToken("DailyRoutine.WaterBeforeTea").Value<string>(); ;
            routine.WaterQuantity = parsed.SelectToken("DailyRoutine.WaterQuantity").Value<string>(); ;
            routine.MorningDrink = parsed.SelectToken("DailyRoutine.MorningDrink").Value<string>(); ;
            routine.Divasvaap = parsed.SelectToken("DailyRoutine.Divasvaap").Value<string>(); ;
            routine.NatureofWork = parsed.SelectToken("DailyRoutine.NatureofWork").Value<string>(); ;
            routine.WorkingHours = parsed.SelectToken("DailyRoutine.WorkingHours").Value<string>(); ;
            routine.Breakfast = parsed.SelectToken("DailyRoutine.Breakfast").Value<string>(); ;

            DailyDiet diet = new DailyDiet();

            diet.Aahar = String.Join(", ", parsed.SelectToken("DietData.Aahar"));
            diet.Bhaji = String.Join(", ", parsed.SelectToken("DietData.Bhaji"));
            diet.Koshimbir = String.Join(", ", parsed.SelectToken("DietData.Koshimbir"));
            diet.Ambat = String.Join(", ", parsed.SelectToken("DietData.Ambat"));
            diet.Dal = String.Join(", ", parsed.SelectToken("DietData.Dal"));
            diet.Chatani = String.Join(", ", parsed.SelectToken("DietData.Chatani"));
            diet.Vidahi = String.Join(", ", parsed.SelectToken("DietData.Vidahi"));
            diet.FastFood = String.Join(", ", parsed.SelectToken("DietData.FastFood"));
            diet.NonVeg = String.Join(", ", parsed.SelectToken("DietData.NonVeg"));
            diet.ColdDrink = String.Join(", ", parsed.SelectToken("DietData.ColdDrink"));
            diet.Puyrishitha = String.Join(", ", parsed.SelectToken("DietData.Puyrishitha"));
            diet.FastingFood = String.Join(", ", parsed.SelectToken("DietData.FastingFood"));
            diet.OilyFood = String.Join(", ", parsed.SelectToken("DietData.OilyFood"));
            diet.AaharNiyam = String.Join(", ", parsed.SelectToken("DietData.AaharNiyam"));
            diet.Opposite = String.Join(", ", parsed.SelectToken("DietData.Opposite"));
            diet.Bakery = String.Join(", ", parsed.SelectToken("DietData.Bakery"));
            diet.Water = String.Join(", ", parsed.SelectToken("DietData.Water"));
            diet.Fruits = String.Join(", ", parsed.SelectToken("DietData.Fruits"));
            diet.Other = String.Join(", ", parsed.SelectToken("DietData.Other"));
            diet.VegDharan = String.Join(", ", parsed.SelectToken("DietData.VegDharan"));
            diet.Habbit = String.Join(", ", parsed.SelectToken("DietData.Habbit"));
            diet.KoshtaExam = String.Join(", ", parsed.SelectToken("DietData.KoshtaExam"));
            diet.Sleep = String.Join(", ", parsed.SelectToken("DietData.Sleep"));
            diet.OjaExam = String.Join(", ", parsed.SelectToken("DietData.OjaExam"));



            List<string> respList = new List<string>();
            respList = caseObj.GenerateCase(nadi, cmpDetails, routine, diet, Patient_ID);

            if (respList[2] != "0")
            {
                Session["Case_ID"] = respList[2].ToString();

            }


            return Json(respList, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertDiagnosisDetails(string PostData)
        {
            List<string> respList = new List<string>();


            try
            {
                var parsed = JObject.Parse(PostData);
                ModelDiagnosis model = new ModelDiagnosis();
                model.Rugnabal = parsed.SelectToken("DiagnosisData.Rugnabal").Value<string>();
                model.VyadhiBal = parsed.SelectToken("DiagnosisData.VyadhiBal").Value<string>();
                model.Vaat = parsed.SelectToken("DiagnosisData.Vaat").Value<string>();
                model.Pitta = parsed.SelectToken("DiagnosisData.Pitta").Value<string>();
                model.Cough = parsed.SelectToken("DiagnosisData.Cough").Value<string>();
                model.Dosha = parsed.SelectToken("DiagnosisData.Dosha").Value<string>();
                model.Strotas = parsed.SelectToken("DiagnosisData.Strotas").Value<string>();
                model.Avastha = parsed.SelectToken("DiagnosisData.Avastha").Value<string>();
                model.JathraAgni = parsed.SelectToken("DiagnosisData.JathraAgni").Value<string>();
                model.DwhtaAgni = parsed.SelectToken("DiagnosisData.DwhtaAgni").Value<string>();
                model.MahaBhutaAgni = parsed.SelectToken("DiagnosisData.MahaBhutaAgni").Value<string>();
                model.VyahiNidan = parsed.SelectToken("DiagnosisData.CaseID").Value<string>();
                string CaseID = parsed.SelectToken("DiagnosisData.CaseID").Value<string>();


                respList = new DiagnosisModel().InserDiagnosisDetails(model, CaseID);


            }
            catch (Exception ae)
            {

            }


            return Json(respList, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult GetMedicines(string search)
        {

            List<ModelMedicine> MedicineList = new List<ModelMedicine>();

            MedicineList = new MedicineModel().GetMedicineList(search);


            return Json(MedicineList, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertMedicineDetails(string PostData)
        {
            List<string> respList = new List<string>();
            try
            {


                var parsed = JObject.Parse(PostData);



                JArray Medicines = (JArray)parsed["Data"];
                List<ModelMedicine> modelList = new List<ModelMedicine>();

                foreach (var item in Medicines.Children())
                {
                    ModelMedicine model = new ModelMedicine();
                    var itemProperties = item.Children<JProperty>();
                    //you could do a foreach or a linq here depending on what you need to do exactly with the value
                    var MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Name");
                    model.Name = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Type");
                    model.Type = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Duration");
                    model.Duration = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Frequency");
                    model.Frequency = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "WhenToTake");
                    model.WhenToTake = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "WithToTake");
                    model.WithToTake = MedicineProperty.Value.ToString(); ////This is a JValue type
                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Quantity");

                    modelList.Add(model);
                }

                string FollowupRequired = (string)parsed["FollowupRequired"];
                string FollowupDate = (string)parsed["FollowupDate"];
                Int64 FollowupID = (Int64)parsed["FollowupID"];
                Int64 PatientID = (Int64)parsed["PatinetId"];
                string CaseID = (string)parsed["CaseId"];

                if (modelList.Count > 0)
                {
                    respList = new MedicineModel().InsertMedicineDetails(modelList, FollowupRequired, FollowupDate, FollowupID, CaseID);
                }

            }
            catch (Exception ae)
            {

            }

            return Json(respList, JsonRequestBehavior.AllowGet);

        }



        [HttpPost]
        public JsonResult GetGheeDetails(string type)
        {
            return Json(new PanchakarmaModel().GetGheeDetails(type), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GetOilDetails(string type)
        {
            return Json(new PanchakarmaModel().GetOilDetails(type), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GetMedicineByType(string Type, string MedicineFor, string MedicineTypeFor)
        {
            return Json(new PanchakarmaModel()._getMedicineByType(Type, MedicineFor, MedicineTypeFor), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertVamanPurvaKarmaDetails(string PostData)
        {
            List<string> respList = new List<string>();
            try
            {


                var parsed = JObject.Parse(PostData);



                JArray Medicines = (JArray)parsed["Data"];
                List<ModelVaman> modelList = new List<ModelVaman>();

                foreach (var item in Medicines.Children())
                {

                    ModelVaman model = new ModelVaman();

                    var itemProperties = item.Children<JProperty>();
                    //you could do a foreach or a linq here depending on what you need to do exactly with the value
                    var MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "SrNo");
                    model.SrNo = Convert.ToInt64(MedicineProperty.Value.ToString()); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Date");
                    model.Date = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Oil_Ghee");
                    model.Oil_Ghee = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Oil_Ghee_Name");
                    model.Oil_Ghee_Name = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Dose");
                    model.Dose = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Massage");
                    model.Massage = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Massage_Oil");
                    model.Massage_Oil = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Symptoms");
                    model.Symptoms = MedicineProperty.Value.ToString(); ////This is a JValue type

                    modelList.Add(model);
                }

                string FollowupRequired = (string)parsed["FollowupRequired"];
                string FollowupDate = (string)parsed["FollowupDate"];
                Int64 PatientID = (Int64)parsed["PatinetId"];
                string CaseID = (string)parsed["CaseId"];

                if (modelList.Count > 0)
                {
                    respList = new PanchakarmaModel()._insertVamanPurvaKarmaDetails(modelList, FollowupRequired, FollowupDate, CaseID);
                }

            }
            catch (Exception ae)
            {

            }

            return Json(respList, JsonRequestBehavior.AllowGet);

        }



        [HttpPost]
        public JsonResult InsertVamanPradhanKarmaDetails(string PostData)
        {
            List<string> respList = new List<string>();


            try
            {
                var parsed = JObject.Parse(PostData);
                ModelPradhanVaman model = new ModelPradhanVaman();
                model.PradhanKarmaDate = parsed.SelectToken("VamanData.PradhanKarmaDate").Value<string>();
                model.UatkleshaAhar = parsed.SelectToken("VamanData.UatkleshaAhar").Value<string>();
                model.VamanDravya = parsed.SelectToken("VamanData.VamanDravya").Value<string>();
                model.SnehanSvedan = "NA";
                model.DudhapanTime = parsed.SelectToken("VamanData.DudhapanTime").Value<string>();
                model.DudhpanQty = parsed.SelectToken("VamanData.DudhpanQty").Value<string>();
                model.ChatanTime = parsed.SelectToken("VamanData.ChatanTime").Value<string>();
                model.ChatanQty = parsed.SelectToken("VamanData.ChatanQty").Value<string>();
                model.AkanthapanStart = parsed.SelectToken("VamanData.AkanthapanStart").Value<string>();
                model.SaivadhJal = parsed.SelectToken("VamanData.SaivadhJal").Value<string>();
                model.Dhumpan = parsed.SelectToken("VamanData.Dhumpan").Value<string>();
                model.SnehanSvedanTime = parsed.SelectToken("VamanData.SnehanSvedanTime").Value<string>();
                model.Chatan = parsed.SelectToken("VamanData.Chatan").Value<string>();
                model.Akanthapan = parsed.SelectToken("VamanData.Akanthapan").Value<string>();
                model.SaivadhJalTime = parsed.SelectToken("VamanData.SaivadhJalTime").Value<string>();

                string CaseID = parsed.SelectToken("VamanData.CaseId").Value<string>();
                respList = new PanchakarmaModel()._insertVamanPradhanKarmaDetails(model, CaseID);

            }
            catch (Exception ae)
            {

            }


            return Json(respList, JsonRequestBehavior.AllowGet);
        }



        [HttpPost]
        public JsonResult InsertVirechanaPurvaKarmaDetails(string PostData)
        {
            List<string> respList = new List<string>();
            try
            {


                var parsed = JObject.Parse(PostData);



                JArray Medicines = (JArray)parsed["Data"];
                List<ModelVirechana> modelList = new List<ModelVirechana>();

                foreach (var item in Medicines.Children())
                {

                    ModelVirechana model = new ModelVirechana();

                    var itemProperties = item.Children<JProperty>();
                    //you could do a foreach or a linq here depending on what you need to do exactly with the value
                    var MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "SrNo");
                    model.SrNo = Convert.ToInt64(MedicineProperty.Value.ToString()); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Date");
                    model.Date = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Oil_Ghee");
                    model.Oil_Ghee = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Oil_Ghee_Name");
                    model.Oil_Ghee_Name = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Dose");
                    model.Dose = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Massage");
                    model.Massage = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Massage_Oil");
                    model.Massage_Oil = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Symptoms");
                    model.Symptoms = MedicineProperty.Value.ToString(); ////This is a JValue type

                    modelList.Add(model);
                }

                string FollowupRequired = (string)parsed["FollowupRequired"];
                string FollowupDate = (string)parsed["FollowupDate"];
                Int64 PatientID = (Int64)parsed["PatinetId"];
                string CaseID = (string)parsed["CaseId"];

                if (modelList.Count > 0)
                {
                    respList = new PanchakarmaModel()._insertVirechanaPurvaKarmaDetails(modelList, FollowupRequired, FollowupDate, CaseID);
                }

            }
            catch (Exception ae)
            {

            }

            return Json(respList, JsonRequestBehavior.AllowGet);

        }



        [HttpPost]
        public JsonResult InsertVirechanaPradhanKarmaDetails(string PostData)
        {
            List<string> respList = new List<string>();


            try
            {
                var parsed = JObject.Parse(PostData);
                ModelPradhanVirechana model = new ModelPradhanVirechana();
                model.PradhanKarmaDate = parsed.SelectToken("VirechanaData.PradhanKarmaDate").Value<string>();
                model.MedicineName = parsed.SelectToken("VirechanaData.MedicineName").Value<string>();
                model.MedicineQty = parsed.SelectToken("VirechanaData.MedicineQty").Value<string>();
                model.Symptoms = parsed.SelectToken("VirechanaData.Symptoms").Value<string>();
                model.VirechnaVeg = parsed.SelectToken("VirechanaData.VirechnaVeg").Value<string>();
                string CaseID = parsed.SelectToken("VirechanaData.CaseId").Value<string>();
                respList = new PanchakarmaModel()._insertVirechanaPradhanKarmaDetails(model, CaseID);

            }
            catch (Exception ae)
            {

            }


            return Json(respList, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public JsonResult GetVirechanaDetails(string CaseID)
        {
            return Json(new PanchakarmaModel()._getVirechanaDetails(CaseID), JsonRequestBehavior.AllowGet);
        }



        [HttpPost]
        public JsonResult GetNasyaDetails(string CaseID)
        {
            return Json(new PanchakarmaModel()._getNasyaDetails(CaseID), JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public JsonResult InsertNasyaDetails(string PostData)
        {
            List<string> respList = new List<string>();
            try
            {


                var parsed = JObject.Parse(PostData);



                JArray Medicines = (JArray)parsed["Data"];
                List<ModelNasya> modelList = new List<ModelNasya>();

                foreach (var item in Medicines.Children())
                {

                    ModelNasya model = new ModelNasya();

                    var itemProperties = item.Children<JProperty>();
                    //you could do a foreach or a linq here depending on what you need to do exactly with the value
                    var MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "SrNo");
                    model.SrNo = Convert.ToInt64(MedicineProperty.Value.ToString()); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Date");
                    model.Date = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Oil_Ghee");
                    model.Oil_Ghee = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Oil_Ghee_Name");
                    model.Oil_Ghee_Name = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Dose");
                    model.Dose = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Massage");
                    model.Massage = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Massage_Oil");
                    model.Massage_Oil = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Symptoms");
                    model.Symptoms = MedicineProperty.Value.ToString(); ////This is a JValue type

                    modelList.Add(model);
                }

                string FollowupRequired = (string)parsed["FollowupRequired"];
                string FollowupDate = (string)parsed["FollowupDate"];
                Int64 PatientID = (Int64)parsed["PatinetId"];
                string CaseID = (string)parsed["CaseId"];

                if (modelList.Count > 0)
                {
                    respList = new PanchakarmaModel()._insertNasyaDetails(modelList, FollowupRequired, FollowupDate, CaseID);
                }

            }
            catch (Exception ae)
            {

            }

            return Json(respList, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public JsonResult GetRaktaMokshanaDetails(string CaseID)
        {
            return Json(new PanchakarmaModel()._getRaktaMokshanaDetails(CaseID), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertRaktaMokshanaBasisDetails(string PostData)
        {
            List<string> respList = new List<string>();


            try
            {
                var parsed = JObject.Parse(PostData);
                ModelRaktaMokshanaBasic model = new ModelRaktaMokshanaBasic();
                model.BleedingTime = parsed.SelectToken("RaktaMokshanaObject.BleedingTime").Value<string>();
                model.ClotingTime = parsed.SelectToken("RaktaMokshanaObject.ClotingTime").Value<string>();
                model.BloodPressure = parsed.SelectToken("RaktaMokshanaObject.BloodPressure").Value<string>();
                model.HB = parsed.SelectToken("RaktaMokshanaObject.HB").Value<string>();
               
                string CaseID = parsed.SelectToken("RaktaMokshanaObject.CaseID").Value<string>();

                respList = new PanchakarmaModel()._insertRaktaMokshanaBasicDetails(model, CaseID);


            }
            catch (Exception ae)
            {

            }


            return Json(respList, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertRaktaMokshanaDetails(string PostData)
        {
            List<string> respList = new List<string>();
            try
            {


                var parsed = JObject.Parse(PostData);



                JArray Medicines = (JArray)parsed["Data"];
                List<ModelRaktaMokshana> modelList = new List<ModelRaktaMokshana>();

                foreach (var item in Medicines.Children())
                {

                    ModelRaktaMokshana model = new ModelRaktaMokshana();

                    var itemProperties = item.Children<JProperty>();
                    //you could do a foreach or a linq here depending on what you need to do exactly with the value
                    var MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "SrNo");
                    model.SrNo = Convert.ToInt64(MedicineProperty.Value.ToString()); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Date");
                    model.Date = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "RaktaMokshanaType");
                    model.RaktaMokshanaType = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "SnehaPaanYesNo");
                    model.SnehaPaanYesNo = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "SnehaPaanDetails");
                    model.SnehaPaanDetails = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Place");
                    model.Place = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Quantity");
                    model.Quantity = MedicineProperty.Value.ToString(); ////This is a JValue type

                    MedicineProperty = itemProperties.FirstOrDefault(x => x.Name == "Symptoms");
                    model.Symptoms = MedicineProperty.Value.ToString(); ////This is a JValue type

                    modelList.Add(model);
                }

                string FollowupRequired = (string)parsed["FollowupRequired"];
                string FollowupDate = (string)parsed["FollowupDate"];
                Int64 PatientID = (Int64)parsed["PatinetId"];
                string CaseID = (string)parsed["CaseId"];

                if (modelList.Count > 0)
                {
                    respList = new PanchakarmaModel()._insertRaktaMokshanaDetails(modelList, FollowupRequired, FollowupDate, CaseID);
                }

            }
            catch (Exception ae)
            {

            }

            return Json(respList, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public JsonResult InsertRaktaMokshanaDignosisDetails(string PostData)
        {
            List<string> respList = new List<string>();
            try
            {
                var parsed = JObject.Parse(PostData);
                ModelRaktaMokshanaDignosis model = new ModelRaktaMokshanaDignosis();
                model.Days = parsed.SelectToken("RaktaMokshanaObject.Days").Value<string>();
                model.Quantity = parsed.SelectToken("RaktaMokshanaObject.Quantity").Value<string>();
                model.Symptoms = parsed.SelectToken("RaktaMokshanaObject.Symptoms").Value<string>();

                string CaseID = parsed.SelectToken("RaktaMokshanaObject.CaseID").Value<string>();

                respList = new PanchakarmaModel()._insertRaktaMokshanaDignosisDetails(model, CaseID);
            }
            catch (Exception ae)
            {

            }

            return Json(respList, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public JsonResult GetBastiDetails(string CaseID)
        {
            return Json(new PanchakarmaModel()._getBastiDetails(CaseID), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertBastiPurvaKarmaDetails(string PostData)
        {
            List<string> respList = new List<string>();
            try
            {


                var parsed = JObject.Parse(PostData);



                JArray Medicines = (JArray)parsed["Data"];
                List<ModelBasti> modelList = new List<ModelBasti>();

                foreach (var item in Medicines.Children())
                {

                    ModelBasti model = new ModelBasti();

                    var itemProperties = item.Children<JProperty>();
                    //you could do a foreach or a linq here depending on what you need to do exactly with the value
                    var BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "SrNo");
                    model.SrNo = Convert.ToInt64(BastiProperty.Value.ToString()); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Date");
                    model.Date = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Oil_Ghee");
                    model.Oil_Ghee = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Oil_Ghee_Name");
                    model.Oil_Ghee_Name = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Dosa");
                    model.Dosa = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Massage");
                    model.Massage = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Massage_Oil");
                    model.Massage_Oil = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Symptoms");
                    model.Symptoms = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Datta");
                    model.Datta = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "PratyaGaman");
                    model.PratyaGaman = BastiProperty.Value.ToString(); ////This is a JValue type

                    modelList.Add(model);
                }

                string FollowupRequired = (string)parsed["FollowupRequired"];
                string FollowupDate = (string)parsed["FollowupDate"];
                Int64 PatientID = (Int64)parsed["PatinetId"];
                string CaseID = (string)parsed["CaseId"];

                if (modelList.Count > 0)
                {
                    respList = new PanchakarmaModel()._insertBastiPurvaKarmaDetails(modelList, FollowupRequired, FollowupDate, CaseID);
                }

            }
            catch (Exception ae)
            {

            }

            return Json(respList, JsonRequestBehavior.AllowGet);

        }


        [HttpPost]
        public JsonResult GetUttarBastiDetails(string CaseID)
        {
            return Json(new PanchakarmaModel()._getUttarBastiDetails(CaseID), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertUttarBastiDetails(string PostData)
        {
            List<string> respList = new List<string>();
            try
            {


                var parsed = JObject.Parse(PostData);



                JArray Medicines = (JArray)parsed["Data"];
                List<ModelBasti> modelList = new List<ModelBasti>();

                foreach (var item in Medicines.Children())
                {

                    ModelBasti model = new ModelBasti();

                    var itemProperties = item.Children<JProperty>();
                    //you could do a foreach or a linq here depending on what you need to do exactly with the value
                    var BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "SrNo");
                    model.SrNo = Convert.ToInt64(BastiProperty.Value.ToString()); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Date");
                    model.Date = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Oil_Ghee");
                    model.Oil_Ghee = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Oil_Ghee_Name");
                    model.Oil_Ghee_Name = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Dosa");
                    model.Dosa = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Massage");
                    model.Massage = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Massage_Oil");
                    model.Massage_Oil = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Symptoms");
                    model.Symptoms = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "Datta");
                    model.Datta = BastiProperty.Value.ToString(); ////This is a JValue type

                    BastiProperty = itemProperties.FirstOrDefault(x => x.Name == "PratyaGaman");
                    model.PratyaGaman = BastiProperty.Value.ToString(); ////This is a JValue type

                    modelList.Add(model);
                }

                string FollowupRequired = (string)parsed["FollowupRequired"];
                string FollowupDate = (string)parsed["FollowupDate"];
                Int64 PatientID = (Int64)parsed["PatinetId"];
                string CaseID = (string)parsed["CaseId"];

                if (modelList.Count > 0)
                {
                    respList = new PanchakarmaModel()._insertUttarBastiDetails(modelList, FollowupRequired, FollowupDate, CaseID);
                }

            }
            catch (Exception ae)
            {

            }

            return Json(respList, JsonRequestBehavior.AllowGet);

        }
    }
}