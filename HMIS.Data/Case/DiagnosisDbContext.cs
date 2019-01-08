using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data.Account;
using HMIS.Models.Case;
using HMIS.Data.Logger;
using HMIS.Models.Logger;

namespace HMIS.Data.Case
{
    public class DiagnosisDbContext
    {

        private readonly ILoggerManager _loggerManager;

        #region Insrt Diagnosis Details
        public List<string> InserDiagnosisDetails(ModelDiagnosis model, string Case_ID)
        {
            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            try
            {
                DataAccess dbo = new DataAccess();
              
                parameters = new List<SqlParameter>();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@OPERAION";
                param.Value = "I";
                param.SqlDbType = SqlDbType.VarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CASE_ID";
                param.Value = Case_ID;
                param.Size = 25;
                param.SqlDbType = SqlDbType.VarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@RUGNABAL";
                param.Value = model.Rugnabal == "" ? "NA" : model.Rugnabal;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@VYADHIBAL";
                param.Value = model.VyadhiBal == "" ? "NA" : model.VyadhiBal;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@VAAT";
                param.Value = model.Vaat == "" ? "NA" : model.Vaat;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@PITTA";
                param.Value = model.Pitta == "" ? "NA" : model.Pitta;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@COUGH";
                param.Value = model.Cough == "" ? "NA" : model.Cough;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@DOSHA";
                param.Value = model.Dosha == "" ? "NA" : model.Dosha;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@STROTAS";
                param.Value = model.Strotas == "" ? "NA" : model.Strotas;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@AVASTHA";
                param.Value = model.Avastha == "" ? "NA" : model.Avastha;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@JATHRAAGNI";
                param.Value = model.JathraAgni == "" ? "NA" : model.JathraAgni;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@DWHTAAGNI";
                param.Value = model.DwhtaAgni == "" ? "NA" : model.DwhtaAgni;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@MAHABHUTAAGNI";
                param.Value = model.MahaBhutaAgni == "" ? "NA" : model.MahaBhutaAgni;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@VYAHINIDAN";
                param.Value = model.VyahiNidan == "" ? "NA" : model.VyahiNidan;
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Output;
                param.ParameterName = "@ERROR_MESSAGE";
                param.SqlDbType = SqlDbType.NVarChar;
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
                            "error occured", Case_ID.ToString()});

                }


            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "InserDiagnosisDetails",
                    Metadata = "Error In InserDiagnosisDetails Function"
                });
                responseList = new List<string>(new string[] { "false",
                            "Error occured", Case_ID.ToString()});
            }


            return responseList;
        }
        #endregion

    }
}
