using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HMIS.Data.Logger;
using HMIS.Models.Logger;
using HMIS.Models.Patient;
using HMIS_WEB.Models.Patient;
using HMIS.Data.Account;
namespace HMIS_WEB.Controllers
{
    public class PatientController : BaseController
    {
        


        // GET: Patient
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult NewPatient()
        {
            
            TempData["patientCreated"] = null;
            TempData.Keep();
            return View();
        }

        [HttpPost]
        public ActionResult NewPatient(FormCollection collection)
        {


            try
            {
                ModelNewPatient patient = new ModelNewPatient();
                patient.PatientName = collection["inputPatientName"];
                patient.Address = collection["inputAddress"];
                patient.City = collection["inputCity"];
                patient.Pin = collection["inputPin"];
                patient.BirthDate = collection["inputBirthDate"];
                patient.Age = collection["inputAge"];
                patient.ConceptionPeriod = collection["inputConceptionPeriod"];
                patient.Gender = collection["ddlGender"];
                patient.MobileNo = collection["inputMobileNo"];
                patient.PhoneNo = collection["inputPhoneNo"];
                patient.Nadi = collection["inputNadi"];
                patient.Mala = collection["inputMala"];
                patient.Mutra = collection["inputMutra1"];
                patient.Avastha = collection["ddlAvastha"];
                patient.Prakruti = collection["inputPrakruti"];
                patient.MensturalHistory = collection["inputMensturalHistory"];

                NewPatient pt = new NewPatient();
                var responseList = new List<string>();
                responseList = pt.CreateNewPatient(patient);

                if (responseList[0].ToString() == "true")
                {
                    Session["Patient_ID"] = responseList[2].ToString();
                    TempData["patientCreated"] = true;
                }
                else
                {
                    TempData["patientCreated"] = false;
                }
                TempData.Keep();
            }
            catch (Exception ae)
            {
                
                BaseLogModel model = new BaseLogModel();
                model.Module = "Patinet";
                model.StackTrace = ae.StackTrace;
                model.Message = ae.Message;
                DataAccess db = new DataAccess();
                db.LogError(model);
            }
           
            return View();
        }
    }
}