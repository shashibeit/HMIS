using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Models.Home;
using HMIS.Data.Home;
using System.Data;

namespace HMIS.Services.Home
{
    public class DashboardService
    {

        public ModelDashboard _getDashboardData()
        {

            ModelDashboard dash = new ModelDashboard();
            DashboardDbContext objDashboard = new DashboardDbContext();

            DataSet ds = objDashboard._getDashboardData();

            if (ds != null)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                foreach (DataRow row in dt.Rows)
                {
                    dash.TotalCases = row["TOTAL_CASES"].ToString();
                    dash.TotalPatients = row["TOTAL_PATIENTS"].ToString();
                    dash.TodaysPatients = row["TODAYS_PATIENTS"].ToString();
                    dash.TodaysCases = row["TODAYS_CASES"].ToString();

                }
            }
            return dash;
        }
    }
}
