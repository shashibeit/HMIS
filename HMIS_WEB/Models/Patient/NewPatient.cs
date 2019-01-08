using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HMIS.Models.Patient;
using HMIS.Services.Patient;

namespace HMIS_WEB.Models.Patient
{
    public class NewPatient
    {
        public List<string> CreateNewPatient(ModelNewPatient newPatient) {

            NewPatientService Patient = new NewPatientService();

            return Patient.CreateNewPatient(newPatient); ;
        }


    }
}