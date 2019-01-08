using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HMIS.Services.Masters;
using HMIS.Models.Masters;
using HMIS.Models.Case;
namespace HMIS_WEB.Models.Master
{
    public class ModelOilGheeMaster
    {
        public List<string> InsertOilGheeDetails(List<MedicineMasterModel> modelList)
        {
            return new OilGheeMasterService().InsertOilGheeDetails(modelList);
        }

        public List<ModelAllMedicine> _getAllOilGheeDetails(string type,Int32 start, Int32 legnth, string serchval)
        {

            List<ModelAllMedicine> medicileList = new OilGheeMasterService()._getAllOilGheeDetails(type,start, legnth, serchval);
            return medicileList;
        }

    }
}