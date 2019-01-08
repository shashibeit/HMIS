using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data.Account;
using HMIS.Data.Case;
using HMIS.Models.Case;

namespace HMIS.Services.Case
{
    public class FollowupService
    {

        public List<ModelFollowup> _getFollowupDetails()
        {
            List<ModelFollowup> FollowupList = new List<ModelFollowup>();


            FollowupDbContext objFollowup = new FollowupDbContext();

            DataSet ds = objFollowup._getFollowupDetails();

            if (ds != null)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                foreach (DataRow row in dt.Rows)
                {
                    ModelFollowup followup = new ModelFollowup();
                    followup.FOLLOWUP_ID = row["FOLLOWUP_ID"].ToString();
                    followup.PATIENT_ID = row["PATIENT_ID"].ToString();
                    followup.CASE_ID = row["CASE_ID"].ToString();
                    followup.PATIENT_NAME = row["PATIENT_NAME"].ToString();
                    followup.MOBILE_NO = row["MOBILE_NO"].ToString();
                    followup.FOLLOWUP_FOR = row["FOLLOWUP_FOR"].ToString();
                    FollowupList.Add(followup);
                }
            }
            return FollowupList;
        }


        public List<ModelFollowup> _getFollowupDetailsByCase(string CaseID)
        {
            List<ModelFollowup> FollowupList = new List<ModelFollowup>();


            FollowupDbContext objFollowup = new FollowupDbContext();

            DataSet ds = objFollowup._getFollowupDetailsByCase(CaseID);
            try
            {
                if (ds != null)
                {
                    DataTable dt = new DataTable();
                    dt = ds.Tables[0];
                    foreach (DataRow row in dt.Rows)
                    {
                        ModelFollowup followup = new ModelFollowup();
                        followup.FOLLOWUP_ID = row["FOLLOWUP_ID"].ToString();
                        followup.PATIENT_ID = row["PATIENT_ID"].ToString();
                        followup.CASE_ID = row["CASE_ID"].ToString();
                        followup.PATIENT_NAME = row["PATIENT_NAME"].ToString();
                        followup.MOBILE_NO = row["MOBILE_NO"].ToString();
                        followup.FOLLOWUP_FOR = row["FOLLOWUP_FOR"].ToString();
                        followup.FOLLOWUP_DATE = row["FOLLOWUP_DATE"].ToString();
                        followup.FOLLOWUP_DONE_DATE = row["FOLLOWUP_DONE_DATE"].ToString();
                        followup.FOLLOWUP_STATUS = row["FOLLOWUP_STATUS"].ToString();
                        FollowupList.Add(followup);
                    }
                }
            }
            catch(Exception ae)
            {

            }
            return FollowupList;
        }
    }
}
