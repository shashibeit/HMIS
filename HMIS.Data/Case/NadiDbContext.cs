using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data.Account;
using HMIS.Models.Case;
namespace HMIS.Data.Case
{
    public class NadiDbContext
    {
        public List<string> InserNadiDetails(NadiDetails objNadi,string Case_ID) {
            List<string> responseList = new List<string>();
            try
            {
                DataAccess dbo = new DataAccess();

                List<SqlParameter> parameters = new List<SqlParameter>();

                SqlParameter param = new SqlParameter();
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
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@NADI";
                param.Value = objNadi.Nadi;
                param.Size = 15;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@MALA";
                param.Value = objNadi.Mala;
                param.Size = 15;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@MUTRA";
                param.Value = objNadi.Mala;
                param.Size = 15;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@AVASTHA";
                param.Value = objNadi.Avastha;
                param.Size = 15;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@PRAKRUTI";
                param.Value = objNadi.Prakruti;
                param.Size = 15;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@MENSTURALHISTORY";
                param.Value = objNadi.MensturalHistory!=null?objNadi.MensturalHistory :"NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);
                

                param = new SqlParameter();
                param.Direction = ParameterDirection.Output;
                param.ParameterName = "@ERROR_MESSAGE";
                param.SqlDbType = SqlDbType.NVarChar;
                param.Size = 250;
                parameters.Add(param);

                dbo._executeScalar("INSERT_NADI_DETAILS", parameters);

                var parameter = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();

                string error = parameter.Value.ToString();  
                if (error == "TRUE")
                {
                    responseList = new List<string>(new string[] { "true",
                            "Patient details saved successfully..", Case_ID.ToString()});


                }
                else
                {
                    responseList = new List<string>(new string[] { "false",
                            "error occured while creating patient details..", Case_ID.ToString()});
                }


            }
            catch (Exception ae)
            {
                responseList = new List<string>(new string[] { "false",
                            "error occured while creating patient details..", Case_ID.ToString()});
            }           


            return responseList;
        }


    }
}
