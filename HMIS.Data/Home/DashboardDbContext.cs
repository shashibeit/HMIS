using System;
using System.Collections.Generic;
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

namespace HMIS.Data.Home
{
    public class DashboardDbContext
    {

        private readonly ILoggerManager _loggerManager;
        static object locker = new object();
        public DataSet _getDashboardData()
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();          

            param = new SqlParameter();
            param.Direction = ParameterDirection.Output;
            param.ParameterName = "@ERROR_MESSAGE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 250;
            parameters.Add(param);

            ds = dbo.GetDataSet("GET_DASHBOARD_DATA", parameters);


            return ds;
        }
    }
}
