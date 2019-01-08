using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data.Account;
using HMIS.Data.Logger;
using HMIS.Models.Logger;
using HMIS.Models.Patient;


namespace HMIS.Data.Patient
{
    public class NewPatientDbContext
    {

        public List<string> CreateNewPatient(ModelNewPatient newPatient)
        {
            var responseList = new List<string>();
            try
            {
                DataAccess dbo = new DataAccess();

                List<SqlParameter> parameters = new List<SqlParameter>();

                SqlParameter param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@OPERAION";
                param.Value = "I";
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@PATIENT_NAME";
                param.Value = newPatient.PatientName;
                param.Size = 100;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@ADDRESS";
                param.Value = newPatient.Address;
                param.Size = 100;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CITY";
                param.Value = newPatient.City;
                param.Size = 100;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@PIN";
                param.Value = newPatient.Pin;
                param.SqlDbType = SqlDbType.Decimal;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@BIRTHDATE";
                param.Value = DateTime.ParseExact(newPatient.BirthDate, "dd/MM/yyyy", null);
                param.SqlDbType = SqlDbType.Date;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CONCEPTION_PERIOD";
                param.Value = newPatient.ConceptionPeriod;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@AGE";
                param.Value = newPatient.Age;
                param.SqlDbType = SqlDbType.Decimal;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@GENDER";
                param.Value = newPatient.Gender;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@MOBILE_NO";
                param.Value = newPatient.MobileNo;
                param.SqlDbType = SqlDbType.Decimal;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@PHONE_NO";
                param.Value = newPatient.PhoneNo;
                param.SqlDbType = SqlDbType.Decimal;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@NADI";
                param.Value = newPatient.Nadi;
                param.Size = 15;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@MALA";
                param.Value = newPatient.Mala;
                param.Size = 15;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@MUTRA";
                param.Value = newPatient.Mutra!=null? newPatient.Mutra:"NA";
                param.Size = 15;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@AVASHTA";
                param.Value = newPatient.Avastha;
                param.Size = 15;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@PRAKURTI";
                param.Value = newPatient.Prakruti;
                param.Size = 15;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@MENSTRUAL_HISTORY";
                param.Value = newPatient.MensturalHistory;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Output;
                param.ParameterName = "@CASEID";
                param.SqlDbType = SqlDbType.NVarChar;
                param.Size = 250;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Output;
                param.ParameterName = "@ERROR_MESSAGE";
                param.SqlDbType = SqlDbType.NVarChar;
                param.Size = 250;
                parameters.Add(param);

                dbo._executeScalar("INSERT_PERSONAL_DETAILS", parameters);

                var parameter = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();

                string error = parameter.Value.ToString();
                var caseParam = parameters.Where(a => a.ParameterName == "@CASEID").FirstOrDefault();

                string Patient_ID = caseParam.Value.ToString();


                if (error == "TRUE")
                {
                    responseList = new List<string>(new string[] { "true",
                            "Patient details saved successfully..", Patient_ID});


                }
                else
                {
                    BaseLogModel model = new BaseLogModel();
                    model.Module = "Else";
                    model.StackTrace = "Else";
                    model.Message = "Else";
                    DataAccess db = new DataAccess();
                    db.LogError(model);
                    responseList = new List<string>(new string[] { "false",
                            "Error occured while creating patient details..", Patient_ID});
                }


            }
            catch (Exception ae)
            {
                BaseLogModel model = new BaseLogModel();
                model.Module = "Exception";
                model.StackTrace = ae.StackTrace;
                model.Message = ae.Message;
                DataAccess db = new DataAccess();
                db.LogError(model);
                responseList = new List<string>(new string[] { "false",
                            "Error occured while creating patient details..", "0"});
            }

            return responseList;

        }

    }
}
