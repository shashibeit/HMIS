using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mirabeau.MsSql;
using HMIS.Models.Case;
using HMIS.Models.Patient;
using HMIS.Services.Case;


namespace HMIS_WEB.Models.Case
{
    public class CreateCase
    {
        public ModelNewPatient GetPatientDetails(Int64 Patient_ID) {
            ModelNewPatient patient = new ModelNewPatient();

            NewCaseService newCase = new NewCaseService();

            patient  = newCase.GetPatientDetails(Patient_ID);

            return patient;
        }

        public List<ModelNewPatient> GetPatients(string SearchName, string SearchCity, string SearchContact)
        {

            List<ModelNewPatient> patientList = new List<ModelNewPatient>();

            NewCaseService newCase = new NewCaseService();

            patientList = newCase.GetPatients(SearchName, SearchCity, SearchContact);

            return patientList;
        }



        public List<string> GenerateCase(NadiDetails nadi,ComplaintsDetaills cmp,DailyRoutine routine,DailyDiet diet,Int64 Patient_ID)
        {
            List<string> responseList = new List<string>();
            NewCaseService newCase = new NewCaseService();
            responseList = newCase.GenerateCase(Patient_ID);

            string Case_ID = responseList[2].ToString();

            if (Case_ID != "" && Case_ID != "0")
            {
                
                NadiDetailsService nadiService = new NadiDetailsService();
                responseList = nadiService.InserNadiDetails(nadi, Case_ID);
                if (responseList[0].ToString() == "true")
                {
                    responseList = new List<string>();
                    responseList = new ComplaintsService().InserComplaintDetails(cmp, Case_ID);
                }

                if (responseList[0].ToString() == "true")
                {
                    responseList = new List<string>();
                    responseList = new DailyRoutineService().InserRoutineDetails(routine, Case_ID);
                }

                if (responseList[0].ToString() == "true")
                {
                    responseList = new List<string>();
                    responseList = new DailyDietService().InsertDailyDietDetails(diet, Case_ID);
                }

                if (responseList[0].ToString() == "true")
                {
                    responseList.Add(Case_ID);
                    responseList.Add("Case Created Successfully...");
                }
            }
            else {
                responseList = new List<string>(new string[] { "false",
                            "Case Id is not created","0"});
            }

            return responseList;
        }


    }
}