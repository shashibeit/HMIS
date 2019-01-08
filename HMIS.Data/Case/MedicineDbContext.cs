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
    public class MedicineDbContext
    {
        private readonly ILoggerManager _loggerManager;
        public List<string> InserMedicineDetails(List<ModelMedicine> model, string FollowupRequired, string FollowupDate, Int64 FollowupID, string Case_ID)
        {
            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            var flag = false;
            try
            {
                DataAccess dbo = new DataAccess();
                string FollowuRequired = FollowupRequired == "" ? "NO" : "YES";
                string FollowuDate = FollowupDate == "" ? DateTime.Now.ToString("dd/MM/yyyy") : FollowupDate;

                foreach (var item in model)
                {
                    string Name = item.Name;
                    string Type = item.Type;
                    string Duration = item.Duration;
                    string Frequency = item.Frequency;
                    string WhenToTake = item.WhenToTake;
                    string WithToTake = item.WithToTake;
                    string Quantity = item.Quantity;


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
                    param.ParameterName = "@MEDICINE";
                    param.Value = Name;
                    param.Size = 250;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);


                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@TYPE";
                    param.Value = Type;
                    param.Size = 15;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@DURATION";
                    param.Value = Duration == "" ? "0" : Duration;
                    param.Size = 15;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@FREQUENCY";
                    param.Value = Frequency;
                    param.Size = 10;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@WHENTOTAKE";
                    param.Value = WhenToTake;
                    param.Size = 15;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@WITHTOTAKE";
                    param.Value = WithToTake;
                    param.Size = 10;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);


                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@QUANTITY";
                    param.Value = Quantity == null ? "0" : Quantity;
                    param.Size = 25;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);


                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@FOLLOWUREQUIRED";
                    param.Value = "Yes";
                    param.Size = 5;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@FOLLOWUDATE";
                    param.Value = DateTime.ParseExact(FollowupDate, "dd/MM/yyyy", null);
                    param.SqlDbType = SqlDbType.Date;
                    parameters.Add(param);


                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Output;
                    param.ParameterName = "@ERROR_MESSAGE";
                    param.SqlDbType = SqlDbType.NVarChar;
                    param.Size = 250;
                    parameters.Add(param);

                    dbo._executeScalar("INSERT_MEDICINE_DETAILS", parameters);

                    var prm = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                    error = prm.Value.ToString();


                    if (error == "TRUE")
                    {
                        responseList = new List<string>(new string[] { "true",
                            "Medicine Details Saved", Case_ID.ToString()});
                        flag = true;
                        continue;
                    }
                    else
                    {
                        responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
                        flag = false;
                        break;
                    }

                }
                parameters = new List<SqlParameter>();
                if (flag == true)
                {
                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@OPERAION";
                    param.Value = FollowupID == 0 ? "I" : "U";
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
                    param.ParameterName = "@FOLLOWUPID";
                    param.Value = FollowupID;
                    param.SqlDbType = SqlDbType.Int;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@FOLLOWUREQUIRED";
                    param.Value = FollowupRequired;
                    param.Size = 5;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@FOLLOWUDATE";
                    param.Value = DateTime.ParseExact(FollowupDate, "dd/MM/yyyy", null);
                    param.SqlDbType = SqlDbType.Date;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@FOLLOWUP_FOR";
                    param.Value = "MEDICINE";
                    param.Size = 25;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);


                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Output;
                    param.ParameterName = "@ERROR_MESSAGE";
                    param.SqlDbType = SqlDbType.NVarChar;
                    param.Size = 250;
                    parameters.Add(param);

                    dbo._executeScalar("INSERT_FOLLOWUP_DETAILS", parameters);

                    var parameter = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();

                    error = parameter.Value.ToString();

                    if (error == "TRUE")
                    {
                        responseList = new List<string>(new string[] { "true",
                            "Medicine Details Saved Successfully..", Case_ID.ToString()});

                    }
                    else
                    {
                        responseList = new List<string>(new string[] { "false",
                            "error occured while creating patient details..", Case_ID.ToString()});
                    }

                }
            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "InserMedicineDetails",
                    Metadata = "Error In InserMedicineDetails Function"
                });
                responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
            }


            return responseList;
        }

        #region Get Medicine Details
        public DataSet _getMedicineList(string search)
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@SEARCH";
            param.SqlDbType = SqlDbType.NVarChar;
            param.Value = search == null ? "NULL" : search.ToString();
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Output;
            param.ParameterName = "@ERROR_MESSAGE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 250;
            parameters.Add(param);

            ds = dbo.GetDataSet("GET_MEDICINES", parameters);


            return ds;
        }
        #endregion


        #region Get All Medicine Details
        public DataSet _getAllMedicineList(Int32 start, Int32 legnth,string serchval)
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();

            param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@START";
            param.SqlDbType = SqlDbType.Int;
            param.Value = start;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@LENGTH";
            param.SqlDbType = SqlDbType.Int;
            param.Value = legnth;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@SEARCHVAL";
            param.SqlDbType = SqlDbType.NVarChar;
            param.Size = 50;
            param.Value = serchval;
            parameters.Add(param);


            param = new SqlParameter();
            param.Direction = ParameterDirection.Output;
            param.ParameterName = "@ERROR_MESSAGE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 250;
            parameters.Add(param);

            ds = dbo.GetDataSet("GET_ALL_MEDICINES", parameters);


            return ds;
        }
        #endregion

        #region Get Medicine Details by there type
        public List<string> _getMedicineByType(string Type, string MedicineFor, string MedicineTypeFor)
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();

            param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@TYPE";
            param.SqlDbType = SqlDbType.NVarChar;
            param.Value = Type;
            param.Size = 50;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@MEDICINE_FOR";
            param.SqlDbType = SqlDbType.NVarChar;
            param.Value = MedicineFor;
            param.Size = 50;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@MEDICINE_FOR_TYPE";
            param.SqlDbType = SqlDbType.NVarChar;
            param.Value = MedicineTypeFor;
            param.Size = 50;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Output;
            param.ParameterName = "@ERROR_MESSAGE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 250;
            parameters.Add(param);

            ds = dbo.GetDataSet("GET_MEDICINES_BY_TYPE", parameters);

            List<string> medicinelList = ds.Tables[0].AsEnumerable()
                         .Select(r => r.Field<string>(0))
                         .ToList();

            return medicinelList;

        }
        #endregion

    }

}


