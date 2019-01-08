using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Models.Patient;
using HMIS.Data.Patient;

namespace HMIS.Services.Patient
{
   public class NewPatientService
    {
        public List<string> CreateNewPatient(ModelNewPatient newPatient) {           

            NewPatientDbContext patientContext = new NewPatientDbContext();


            return patientContext.CreateNewPatient(newPatient);
        }


    }
}
