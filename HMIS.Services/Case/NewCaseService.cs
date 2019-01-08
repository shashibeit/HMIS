using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Models.Case;
using HMIS.Models.Patient;
using HMIS.Data.Case;
using System.Data;

namespace HMIS.Services.Case
{
    public class NewCaseService
    {
        public ModelNewPatient GetPatientDetails(Int64 Patient_ID)
        {

            ModelNewPatient patient = new ModelNewPatient();

            NewCaseDbContext objCase = new NewCaseDbContext();

            DataSet ds = objCase._getPatinetData(Patient_ID);

            if (ds != null)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                foreach (DataRow row in dt.Rows)
                {
                    patient.PatientName = row["PatientName"].ToString();
                    patient.Address = row["Address"].ToString();
                    patient.City = row["City"].ToString();
                    patient.Pin = row["Pin"].ToString();
                    patient.MobileNo = row["MobileNo"].ToString();
                    patient.BirthDate = row["BirthDate"].ToString();
                    patient.Age = row["Age"].ToString();
                   patient.Gender= row["Gender"].ToString();
                }
            }
            return patient;
        }

        public List<ModelNewPatient> GetPatients(string SearchName, string SearchCity, string SearchContact)
        {

           List<ModelNewPatient> patientList = new List<ModelNewPatient>();

            NewCaseDbContext objCase = new NewCaseDbContext();

            DataSet ds = objCase._getPatinets( SearchName,  SearchCity,  SearchContact);

            if (ds != null)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                foreach (DataRow row in dt.Rows)
                {
                    ModelNewPatient patient = new ModelNewPatient();
                    patient.PatientId = row["PATIENT_ID"].ToString();
                    patient.PatientName = row["PATIENTNAME"].ToString();
                    patient.Address = row["ADDRESS"].ToString();
                    patient.City = row["CITY"].ToString();
                    patient.Pin = row["PIN"].ToString();
                    patient.MobileNo = row["MOBILENO"].ToString();
                    patient.BirthDate = row["BIRTHDATE"].ToString();
                    patient.Age = row["AGE"].ToString();
                    patientList.Add(patient);
                }
            }
            return patientList;
        }

        public List<string> GenerateCase(Int64 Patient_ID)
        {
            return new NewCaseDbContext().GenerateCase(Patient_ID);
        }
    }
}