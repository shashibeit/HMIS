using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data.Masters;
using HMIS.Data.Case;
using HMIS.Models.Masters;
using HMIS.Models.Case;
using System.Data;


namespace HMIS.Services.Masters
{
    public class OilGheeMasterService
    {
        public List<string> InsertOilGheeDetails(List<MedicineMasterModel> modelList)
        {
            return new OilGheeDbContext().InsertOilGheeDetails(modelList);
        }

         public List<ModelAllMedicine> _getAllOilGheeDetails(string type,Int32 start, Int32 legnth, string serchval)
        {
            List<ModelAllMedicine> medicineList = new List<ModelAllMedicine>();
            DataSet ds = new OilGheeDbContext()._getAllOilGheeDetails(type, start,  legnth, serchval);
            if (ds != null)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                int i = 1;
                foreach (DataRow row in dt.Rows)
                {
                    ModelAllMedicine model = new ModelAllMedicine();
                    model.ID = i.ToString(); 
                    model.Name = row["NAME"].ToString();
                    model.For = row["FOR"].ToString();
                    model.TypeFor = row["TYPE_FOR"].ToString();
                    medicineList.Add(model);
                    i++;
                }
            }

            return medicineList;
        }

    }
}
