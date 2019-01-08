using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data.Case;
using HMIS.Models.Case;

namespace HMIS.Services.Case
{
    public class MedicineService
    {
        public List<string> InserMedicineDetails(List<ModelMedicine> model, string FollowupRequired, string FollowupDate,Int64 FollowupID, string Case_ID)
        {
            return new MedicineDbContext().InserMedicineDetails(model, FollowupRequired, FollowupDate, FollowupID, Case_ID);
        }

        public List<ModelMedicine> GetMedicineList(string search)
        {
            List<ModelMedicine> medicineList = new List<ModelMedicine>();
            DataSet ds = new MedicineDbContext()._getMedicineList(search);
            if (ds != null)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                int i = 1;
                foreach (DataRow row in dt.Rows)
                {
                    ModelMedicine model = new ModelMedicine();
                    model.ID = i.ToString(); ;
                    model.Name = row["MEDICINE_NAME"].ToString();
                    medicineList.Add(model);
                    i++;
                }
            }

            return medicineList;
        }


        public List<ModelAllMedicine> GetAllMedicineList(Int32 start, Int32 legnth, string serchval)
        {
            List<ModelAllMedicine> medicineList = new List<ModelAllMedicine>();
            DataSet ds = new MedicineDbContext()._getAllMedicineList( start,  legnth, serchval);
            if (ds != null)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                int i = 1;
                foreach (DataRow row in dt.Rows)
                {
                    ModelAllMedicine model = new ModelAllMedicine();
                    model.ID = i.ToString(); ;
                    model.Name = row["MEDICINE_NAME"].ToString();
                    model.Type = row["MEDICINE_TYPE"].ToString();
                    model.Unit = row["MEDICINE_UNIT"].ToString();
                    medicineList.Add(model);
                    i++;
                }
            }

            return medicineList;
        }

        public List<string> _getMedicineByType(string Type, string MedicineFor, string MedicineTypeFor)
        {
            List<string> gheeList = new List<string>();
            return new MedicineDbContext()._getMedicineByType(Type, MedicineFor, MedicineTypeFor);

        }
    }
}
