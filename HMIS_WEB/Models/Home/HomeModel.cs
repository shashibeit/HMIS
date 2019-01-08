using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mirabeau.MsSql;
using HMIS.Models.Home;
using HMIS.Models.Case;
using HMIS.Services.Home;
using HMIS.Services.Case;

namespace HMIS_WEB.Models.Home
{
    public class HomeModel
    {
        public ModelDashboard _getDashboardData()
        {
            ModelDashboard dash = new ModelDashboard();

            dash = new DashboardService()._getDashboardData();

            return dash;
        }

        public List<ModelFollowup> _getFollowupDetails()
        {
            List<ModelFollowup> followupList = new List<ModelFollowup>();

            followupList = new FollowupService()._getFollowupDetails();

            return followupList;
        }
    }
}