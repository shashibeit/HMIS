using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data.Account;
using HMIS.Models.Masters;
using HMIS.Data.Logger;
using HMIS.Models.Logger;
namespace HMIS.Data.Masters
{
    public class OilGheeDbContext
    {
        private readonly ILoggerManager _loggerManager;

        public List<string> InsertOilGheeDetails(List<MedicineMasterModel> modelList)
        {
            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";

            var flag = false;
            try
            {
                DataAccess dbo = new DataAccess();
                foreach (var model in modelList)
                    {
                        string MedicineName = model.MedicineName;
                        string MedicineType = model.MedicineType;
                        string MedicineFor = model.MedicineFor;
                        string PanchakarmaType = model.PanchakarmaType;

                        parameters = new List<SqlParameter>();
                        param.Direction = ParameterDirection.Input;
                        param.ParameterName = "@OPERAION";
                        param.Value = "I";
                        param.SqlDbType = SqlDbType.VarChar;
                        parameters.Add(param);                      

                        param = new SqlParameter();
                        param.Direction = ParameterDirection.Input;
                        param.ParameterName = "@MEDICINENAME";
                        param.Value = MedicineName;
                        param.Size = 250;
                        param.SqlDbType = SqlDbType.NVarChar;
                        parameters.Add(param);

                        param = new SqlParameter();
                        param.Direction = ParameterDirection.Input;
                        param.ParameterName = "@MEDICINETYPE";
                        param.Value = MedicineType;
                        param.Size = 15;
                        param.SqlDbType = SqlDbType.NVarChar;
                        parameters.Add(param);

                        param = new SqlParameter();
                        param.Direction = ParameterDirection.Input;
                        param.ParameterName = "@MEDICINEFOR";
                        param.Value = MedicineFor;
                        param.Size = 15;
                        param.SqlDbType = SqlDbType.NVarChar;
                        parameters.Add(param);

                        param = new SqlParameter();
                        param.Direction = ParameterDirection.Input;
                        param.ParameterName = "@PANCHAKARMATYPE";
                        param.Value = PanchakarmaType;
                        param.Size = 15;
                        param.SqlDbType = SqlDbType.NVarChar;
                        parameters.Add(param);


                        param = new SqlParameter();
                        param.Direction = ParameterDirection.Output;
                        param.ParameterName = "@ERROR_MESSAGE";
                        param.SqlDbType = SqlDbType.NVarChar;
                        param.Size = 250;
                        parameters.Add(param);

                        dbo._executeScalar("MASTER_SAVE_OILGHEE_DETAILS", parameters);

                        var prm = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                        error = prm.Value.ToString();


                        if (error == "TRUE")
                        {
                            flag = true;
                            continue;
                        }
                        else
                        {
                            flag = true;
                            break;
                        }
                    }

               

                    if (flag == true)
                    {
                        responseList = new List<string>(new string[] { "true",
                            "Patient details saved successfully.."});

                    }
                    else
                    {
                        responseList = new List<string>(new string[] { "false",
                            "Error occured while saving medicine details..."});
                    }

            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Compalint",
                    Metadata = "Error In InserMedicineDetails Function"
                });

                responseList = new List<string>(new string[] { "true",
                            "error occured while saving medicine details..."});
            }


            return responseList;
        }

        #region Get Oil Ghee Details
        public DataSet _getOilGheeList(string search)
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

            ds = dbo.GetDataSet("GET_OILGHEE", parameters);


            return ds;
        }
        #endregion


        #region Get All Ghee Oil Details
        public DataSet _getAllOilGheeDetails(string type,Int32 start, Int32 legnth, string serchval)
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();

            param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@TYPE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Value = type;
            param.Size = 15;
            parameters.Add(param);

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

            ds = dbo.GetDataSet("GET_ALL_OILGHEE_DETAILS", parameters);


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

            ds = dbo.GetDataSet("GET_OILGHEE_BY_TYPE", parameters);

            List<string> medicinelList = ds.Tables[0].AsEnumerable()
                         .Select(r => r.Field<string>(0))
                         .ToList();

            return medicinelList;

        }
        #endregion
    }
}
