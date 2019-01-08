using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HMIS.Models.Case;
using HMIS.Services.Case;
namespace HMIS_WEB.Models.Case
{
    public class MedicineModel
    {

        public List<string> InsertMedicineDetails(List<ModelMedicine> modelList,string FollowupRequired,string FollowupDate, Int64 FollowupID, string Case_ID)
        {
            List<string> responseList = new List<string>();
            responseList = new MedicineService().InserMedicineDetails(modelList, FollowupRequired, FollowupDate, FollowupID, Case_ID);
            return responseList;
        }

        public List<ModelMedicine> GetMedicineList(string search) {
            List<ModelMedicine> medicineList = new List<ModelMedicine>();
            medicineList = new MedicineService().GetMedicineList(search);
            return medicineList;
        }

        public List<ModelAllMedicine> GetAllMedicineList(Int32 start, Int32 legnth, string serchval)
        {

            List<ModelAllMedicine> medicileList = new MedicineService().GetAllMedicineList(start,  legnth, serchval);
            return medicileList;
        }

        
    }
}