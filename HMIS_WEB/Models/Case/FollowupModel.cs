using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HMIS.Models.Case;
using HMIS.Services.Case;
using System.Data;
namespace HMIS_WEB.Models.Case
{
    public class FollowupModel
    {
        public List<ModelFollowup> _getFollowupDetailsByCase(string Case_ID)
        {

            List<ModelFollowup> list = new FollowupService()._getFollowupDetailsByCase(Case_ID);
            return list;
        }

    }
}