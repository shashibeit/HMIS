using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HMIS.Models.Case
{
    public class ModelVirechana
    {
        public Int64 SrNo;
        public string Date;
        public string Oil_Ghee;
        public string Oil_Ghee_Name;
        public string Dose;
        public string Massage;
        public string Massage_Oil;
        public string Symptoms;
    }

    public class ModelPradhanVirechana
    {

        public string PradhanKarmaDate ;      
        public string MedicineName ;
        public string MedicineQty;
        public string Symptoms;
        public string VirechnaVeg;
    }

}
