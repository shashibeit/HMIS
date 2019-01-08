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
    public class ComplaintsDbContext
    {

        private readonly ILoggerManager _loggerManager;

        public List<string> InserComplaintDetails(ComplaintsDetaills objComplaints, string Case_ID)
        {
            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            var flag = false;
            try
            {
                DataAccess dbo = new DataAccess();
                if (objComplaints.ComplaintList.Count > 0)
                {
                    foreach (var item in objComplaints.ComplaintList)
                    {
                        string Complaint = item.Complaint;
                        string DurationYear = item.DurationYears;
                        string DurationMonth = item.DurationMonths;
                        string DurationDays = item.DurationDays;

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
                        param.ParameterName = "@COMPLAINT";
                        param.Value = Complaint;
                        param.Size = 250;
                        param.SqlDbType = SqlDbType.NVarChar;
                        parameters.Add(param);

                        param = new SqlParameter();
                        param.Direction = ParameterDirection.Input;
                        param.ParameterName = "@DURATIONYEAR";
                        param.Value = DurationYear;
                        param.Size = 15;
                        param.SqlDbType = SqlDbType.NVarChar;
                        parameters.Add(param);

                        param = new SqlParameter();
                        param.Direction = ParameterDirection.Input;
                        param.ParameterName = "@DURATIONMONTH";
                        param.Value = DurationMonth;
                        param.Size = 15;
                        param.SqlDbType = SqlDbType.NVarChar;
                        parameters.Add(param);

                        param = new SqlParameter();
                        param.Direction = ParameterDirection.Input;
                        param.ParameterName = "@DURATIONDAYS";
                        param.Value = DurationDays;
                        param.Size = 15;
                        param.SqlDbType = SqlDbType.NVarChar;
                        parameters.Add(param);


                        param = new SqlParameter();
                        param.Direction = ParameterDirection.Output;
                        param.ParameterName = "@ERROR_MESSAGE";
                        param.SqlDbType = SqlDbType.NVarChar;
                        param.Size = 250;
                        parameters.Add(param);

                        dbo._executeScalar("INSERT_COMPLAINT_DETAILS", parameters);

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
                }
                else {
                    flag = true;
                }

                parameters = new List<SqlParameter>();
                if (flag == true)
                {
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
                    param.ParameterName = "@MEDICALHISTORY";
                    param.Value = objComplaints.PastMedicalHistory != null ? objComplaints.PastMedicalHistory : "NA"; 
                    param.Size = 250;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@DRUGSHISTORY";
                    param.Value = objComplaints.PastDrugsHistory != null ? objComplaints.PastDrugsHistory : "NA";
                    param.Size = 250;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@FAMILYHISTORY";
                    param.Value = objComplaints.FamilyHistory != null ? objComplaints.FamilyHistory : "NA";
                    param.Size = 250;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);       


                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Output;
                    param.ParameterName = "@ERROR_MESSAGE";
                    param.SqlDbType = SqlDbType.NVarChar;
                    param.Size = 250;
                    parameters.Add(param);

                    dbo._executeScalar("INSERT_PAST_HISTORY_DETAILS", parameters);

                    var parameter = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();

                    error = parameter.Value.ToString();

                    if (error == "TRUE")
                    {
                        responseList = new List<string>(new string[] { "true",
                            "Patient details saved successfully..", Case_ID.ToString()});

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
                    Module = "Compalint",
                    Metadata = "Error In InserComplaintDetails Function"
                });

                responseList = new List<string>(new string[] { "true",
                            "error occured while creating patient details..", Case_ID.ToString()});
            }


            return responseList;
        }


    }
}
