using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HMIS.Models.Case
{
    public class ModelRaktaMokshana
    {
        public Int64 SrNo;
        public string Date;
        public string RaktaMokshanaType ;
        public string SnehaPaanYesNo;
        public string SnehaPaanDetails ;
        public string Place ;
        public string Quantity ;
        public string Symptoms ;
    }


    public class ModelRaktaMokshanaBasic
    {   
        public string BleedingTime;
        public string ClotingTime;
        public string HB;
        public string BloodPressure;
    }


    public class ModelRaktaMokshanaDignosis
    {
        public string Days;
        public string Quantity;
        public string Symptoms;
    }

}
