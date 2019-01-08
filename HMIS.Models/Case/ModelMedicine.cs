using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HMIS.Models.Case
{
    public class ModelMedicine
    {
        public string ID;
        public string Name;
        public string Type;
        public string Duration;
        public string Frequency;
        public string WhenToTake;
        public string WithToTake;
        public string Quantity;
    }


    public class ModelAllMedicine {
        public string ID;
        public string Name;
        public string Type;
        public string Unit;
        public string For;
        public string TypeFor;

    }

}
