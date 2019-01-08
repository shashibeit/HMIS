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
    public class MedicineMasterDbContext
    {
        private readonly ILoggerManager _loggerManager;

        public List<string> InserMedicineDetails(List<MedicineMasterModel> modelList)
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

                        dbo._executeScalar("MASTER_SAVE_MEDICINE_DETAILS", parameters);

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

    }
}
