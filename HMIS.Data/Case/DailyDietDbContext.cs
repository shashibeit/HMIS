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
    public class DailyDietDbContext
    {
        private readonly ILoggerManager _loggerManager;
        public List<string> InsertDailyDietDetails(DailyDiet objdiet, string Case_ID)
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
                param.ParameterName = "@AAHAR";
                param.Value = objdiet.Aahar!= null ? objdiet.Aahar : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@BHAJI";
                param.Value = objdiet.Bhaji != null ? objdiet.Bhaji : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@KOSHIMBIR";
                param.Value = objdiet.Koshimbir != null ? objdiet.Koshimbir : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@AMBAT";
                param.Value = objdiet.Ambat != null ? objdiet.Ambat : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@DAL";
                param.Value = objdiet.Dal != null ? objdiet.Dal : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CHATANI";
                param.Value = objdiet.Chatani != null ? objdiet.Chatani : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@VIDAHI";
                param.Value = objdiet.Vidahi != null ? objdiet.Vidahi : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@FASTFOOD";
                param.Value = objdiet.FastFood != null ? objdiet.FastFood : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@NONVEG";
                param.Value = objdiet.NonVeg != null ? objdiet.NonVeg : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@COLDDRINK";
                param.Value = objdiet.ColdDrink != null ? objdiet.ColdDrink : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@PUYRISHITHA";
                param.Value = objdiet.Puyrishitha != null ? objdiet.Puyrishitha : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@FASTINGFOOD";
                param.Value = objdiet.FastingFood != null ? objdiet.FastingFood : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@OILYFOOD";
                param.Value = objdiet.OilyFood != null ? objdiet.OilyFood : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@AAHARNIYAM";
                param.Value = objdiet.AaharNiyam != null ? objdiet.AaharNiyam : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@OPPOSITE";
                param.Value = objdiet.Opposite != null ? objdiet.Opposite : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@BAKERY";
                param.Value = objdiet.Bakery != null ? objdiet.Bakery : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@WATER";
                param.Value = objdiet.Water != null ? objdiet.Water : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@FRUITS";
                param.Value = objdiet.Fruits != null ? objdiet.Fruits : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@OTHER";
                param.Value = objdiet.Other != null ? objdiet.Other : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@VEGDHARAN";
                param.Value = objdiet.VegDharan != null ? objdiet.VegDharan : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@HABBIT";
                param.Value = objdiet.Habbit != null ? objdiet.Habbit : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@KOSHTAEXAM";
                param.Value = objdiet.KoshtaExam != null ? objdiet.KoshtaExam : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@SLEEP";
                param.Value = objdiet.Sleep != null ? objdiet.Sleep : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@OJAEXAM";
                param.Value = objdiet.OjaExam != null ? objdiet.OjaExam : "NA";
                param.Size = 250;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);               



                param = new SqlParameter();
                param.Direction = ParameterDirection.Output;
                param.ParameterName = "@ERROR_MESSAGE";
                param.SqlDbType = SqlDbType.NVarChar;
                param.Size = 250;
                parameters.Add(param);

                dbo._executeScalar("INSERT_DAILY_DIET_DETAILS", parameters);

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

                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Create Case",
                    Metadata = "Error In InsertDailyDietDetails Function"
                });
                responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
            }
            return responseList;
        }

    }
}
