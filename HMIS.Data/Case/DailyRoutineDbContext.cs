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
    public class DailyRoutineDbContext
    {

        public List<string> InserRoutineDetails(DailyRoutine objRoutine, string Case_ID)
        {
            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            try
            {
                DataAccess dbo = new DataAccess();

                param = new SqlParameter();
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
                param.ParameterName = "@WAKEUPTIME";
                param.Value = objRoutine.WakeupTime != null ? objRoutine.WakeupTime : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@WATERBEFORETEA";
                param.Value = objRoutine.WaterBeforeTea != null ? objRoutine.WaterBeforeTea : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@WATERQUANTITY";
                param.Value = objRoutine.WaterQuantity != null ? objRoutine.WaterQuantity : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@MORNINGDRINK";
                param.Value = objRoutine.MorningDrink != null ? objRoutine.MorningDrink : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@DIVASVAAP";
                param.Value = objRoutine.Divasvaap != null ? objRoutine.Divasvaap : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@NATUREOFWORK";
                param.Value = objRoutine.NatureofWork != null ? objRoutine.NatureofWork : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@WORKINGHOURS";
                param.Value = objRoutine.WorkingHours != null ? objRoutine.WorkingHours : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@BREAKFAST";
                param.Value = objRoutine.Breakfast != null ? objRoutine.Breakfast : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Output;
                param.ParameterName = "@ERROR_MESSAGE";
                param.SqlDbType = SqlDbType.NVarChar;
                param.Size = 250;
                parameters.Add(param);

                dbo._executeScalar("INSERT_DAILY_ROUTINE_DETAILS", parameters);

                var parameter = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();

                error = parameter.Value.ToString();

                if (error == "TRUE")
                {
                    responseList = new List<string>(new string[] { "true",
                            "Daily Routine Saved", Case_ID.ToString()});

                }
                else
                {
                    responseList = new List<string>(new string[] { "false",
                            "Daily Routine Save Falied", Case_ID.ToString()});
                }



            }
            catch (Exception ae)
            {
                responseList = new List<string>(new string[] { "false",
                            "Exception Daily Raoutine", Case_ID.ToString()});
            }


            return responseList;
        }

    }
}
