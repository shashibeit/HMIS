using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data.Masters;
using HMIS.Models.Masters;


namespace HMIS.Services.Masters
{
    public class MedicineMasterService
    {
        public List<string> InserMedicineDetails(List<MedicineMasterModel> modelList)
        {
            return new MedicineMasterDbContext().InserMedicineDetails(modelList);
        }

    }
}
