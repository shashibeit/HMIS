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
using HMIS.Models.Case;

namespace HMIS.Data.Case
{
    public class FollowupDbContext
    {

        private readonly ILoggerManager _loggerManager;
        static object locker = new object();

        public DataSet _getFollowupDetails()
        {
            DataSet ds = new DataSet();

            try
            {

                DataAccess dbo = new DataAccess();

                List<SqlParameter> parameters = new List<SqlParameter>();

                SqlParameter param = new SqlParameter();
                param = new SqlParameter();
                param.Direction = ParameterDirection.Output;
                param.ParameterName = "@ERROR_MESSAGE";
                param.SqlDbType = SqlDbType.VarChar;
                param.Size = 250;
                parameters.Add(param);

                ds = dbo.GetDataSet("GET_FOLLOWUP_DETAILS", parameters);
            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Panchakarma",
                    Metadata = "Error In _getFollowupDetails Function"
                });

            }

            return ds;
        }

        public DataSet _getFollowupDetailsByCase(string Case_ID)
        {
            DataSet ds = new DataSet();
            try
            {

                DataAccess dbo = new DataAccess();

                List<SqlParameter> parameters = new List<SqlParameter>();

                SqlParameter param = new SqlParameter();


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CASE_ID";
                param.SqlDbType = SqlDbType.VarChar;
                param.Value = Case_ID;
                param.Size = 50;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Output;
                param.ParameterName = "@ERROR_MESSAGE";
                param.SqlDbType = SqlDbType.VarChar;
                param.Size = 250;
                parameters.Add(param);

                ds = dbo.GetDataSet("GET_FOLLOWUP_DETAILS_BY_CASE", parameters);

               
            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Followup",
                    Metadata = "Error In _getFollowupDetailsByCase Function"
                });

            }

            return ds;
        }
    }
}
