using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HMIS.Services.Masters;
using HMIS.Models.Masters;
namespace HMIS_WEB.Models.Master
{
    public class ModelMedicineMaster
    {
        public List<string> InserMedicineDetails(List<MedicineMasterModel> modelList)
        {
            return new MedicineMasterService().InserMedicineDetails(modelList);
        }

    }

    public enum MedicineTypes
    {
        Tablets,
        Churna,
        Tonic,
        Syrup
    }

    public enum MedicineFor
    {
        Select,
        Panchakarma,
        Medicine,
        Massage,
   }

    public enum PanchakarmaType
    {
        Select,
        Vaman,
        Virechana,
        Basti,
        Nasya,
        RakatMokshana
    }
}