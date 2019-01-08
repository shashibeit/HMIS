using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using HMIS.Data.Account;
using HMIS.Data.Logger;
using HMIS.Models.Logger;
using HMIS.Models.Case;
using HMIS.Models.Patient;
namespace HMIS.Data.Case
{
    public class NewCaseDbContext
    {
        private readonly ILoggerManager _loggerManager;
        static object locker = new object();

        public DataSet _getPatinets(string SearchName, string SearchCity,string SearchContact)
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@NAMESEARCH";
            param.SqlDbType = SqlDbType.VarChar;
            param.Value = SearchName;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@CONTACTSEARCH";
            param.SqlDbType = SqlDbType.VarChar;
            param.Value = SearchContact;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@CITYSEARCH";
            param.SqlDbType = SqlDbType.VarChar;
            param.Value = SearchCity;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Output;
            param.ParameterName = "@ERROR_MESSAGE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 250;
            parameters.Add(param);

            ds = dbo.GetDataSet("SEARCH_PATIENTS", parameters);


            return ds;
        }

        public DataSet _getPatinetData(Int64 Patient_ID)
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@Patient_ID";
            param.SqlDbType = SqlDbType.Int;
            param.Value = Patient_ID;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Output;
            param.ParameterName = "@ERROR_MESSAGE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 250;
            parameters.Add(param);

            ds = dbo.GetDataSet("FETCH_PATIENT_DETAILS", parameters);


            return ds;
        }

        public List<string> GenerateCase(Int64 Patient_ID)
        {
            var responseList = new List<string>();

            string case_ID = GetCaseID();
            try
            {
                DataAccess dbo = new DataAccess();

                List<SqlParameter> parameters = new List<SqlParameter>();

                SqlParameter param = new SqlParameter();
                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CASE_ID";
                param.Value = case_ID;
                param.Size = 100;
                param.SqlDbType = SqlDbType.VarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@PATIENT_ID";
                param.Value = Patient_ID;
                param.Size = 100;
                param.SqlDbType = SqlDbType.Int;
                parameters.Add(param); 

                param = new SqlParameter();
                param.Direction = ParameterDirection.Output;
                param.ParameterName = "@ERROR_MESSAGE";
                param.SqlDbType = SqlDbType.NVarChar;
                param.Size = 250;
                parameters.Add(param);

                dbo._executeScalar("GENERATE_CASE", parameters);

                var parameter = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                string error = parameter.Value.ToString();


                if (error == "TRUE")
                {
                    responseList = new List<string>(new string[] { "true",
                            "Case Created", case_ID});
                }
                else
                {
                    responseList = new List<string>(new string[] { "true",
                            "Error occured while creating case details..", "0"});
                }


            }
            catch (Exception ae)
            {
                responseList = new List<string>(new string[] { "true",
                            "Error occured while creating case details..", "0"});
            }

            return responseList;

        }


        static string GetCaseID()
        {
            string Case_ID="";
            lock (locker)
            {

                Thread.Sleep(100);
                try
                {
                    DataAccess dbo = new DataAccess();

                    List<SqlParameter> parameters = new List<SqlParameter>();

                    SqlParameter param = new SqlParameter();                   
                    param.Direction = ParameterDirection.Output;
                    param.ParameterName = "@CASE_ID";
                    param.Size = 100;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Output;
                    param.ParameterName = "@ERROR_MESSAGE";
                    param.SqlDbType = SqlDbType.NVarChar;
                    param.Size = 250;
                    parameters.Add(param);

                    dbo._executeScalar("GENERATE_CASE_ID", parameters);

                    var parameter = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                    string error = parameter.Value.ToString();


                    if (error == "TRUE")
                    {
                        parameter = parameters.Where(a => a.ParameterName == "@CASE_ID").FirstOrDefault();
                        Case_ID = parameter.Value.ToString();
                    }
                   

                }
                catch (Exception ae)
                {
                  
                }
                return Case_ID;
            }
        }


        public List<string> _insertDiagnosisDetails(ModelDiagnosis model, string Case_ID)
        {

            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            try
            {
                DataAccess dbo = new DataAccess();
                parameters = new List<SqlParameter>();
                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CASE_ID";
                param.Value = Case_ID;
                param.SqlDbType = SqlDbType.VarChar;
                param.Size = 50;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@RUGNABAL";
                param.Value = model.Rugnabal;
                param.SqlDbType = SqlDbType.NVarChar;
                param.Size = 250;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@VYADHIBAL";
                param.Value = model.VyadhiBal;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@VAAT";
                param.Value = model.Vaat;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@PITTA";
                param.Value = model.Pitta;
                param.SqlDbType = SqlDbType.NVarChar;
                param.Size = 250;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@COUGH";
                param.Value = model.Cough;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@DOSHA";
                param.Value = model.Dosha;
                param.SqlDbType = SqlDbType.NVarChar;
                param.Size = 250;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@STROTAS";
                param.Value = model.Strotas;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@AVASTHA";
                param.Value = model.Avastha;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@JATHRAAGNI";
                param.Value = model.JathraAgni;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@DWHTAAGNI";
                param.Value = model.DwhtaAgni;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@MAHABHUTAAGNI";
                param.Value = model.MahaBhutaAgni;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@VYAHINIDAN";
                param.Value = model.VyahiNidan;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);
               

                param = new SqlParameter();
                param.Direction = ParameterDirection.Output;
                param.ParameterName = "@ERROR_MESSAGE";
                param.SqlDbType = SqlDbType.VarChar;
                param.Size = 250;
                parameters.Add(param);

                dbo._executeScalar("INSERT_DIAGNOSIS_DETAILS", parameters);

                var prm = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                error = prm.Value.ToString();


                if (error == "TRUE")
                {
                    responseList = new List<string>(new string[] { "true",
                            "Diagnosis Details Saved", Case_ID.ToString()});

                }
                else
                {
                    responseList = new List<string>(new string[] { "false",
                            "Eerror occured", Case_ID.ToString()});

                }


            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Panchakarma",
                    Metadata = "Error In _insertDiagnosisDetails Function"
                });
                responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
            }



            return responseList;
        }
    }
}
