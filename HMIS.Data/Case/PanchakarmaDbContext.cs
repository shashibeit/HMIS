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
    public class PanchakarmaDbContext
    {
        private readonly ILoggerManager _loggerManager;
        public List<string> _getGheeDetails(string type)
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@GHEE_FOR";
            param.SqlDbType = SqlDbType.VarChar;
            param.Value = "PANCHAKARMA";
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@GHEE_FOR_TYPE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Value = type;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Output;
            param.ParameterName = "@ERROR_MESSAGE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 250;
            parameters.Add(param);

            ds = dbo.GetDataSet("FETCH_GHEE_DETAILS", parameters);

            List<string> gheeList = ds.Tables[0].AsEnumerable()
                            .Select(r => r.Field<string>(0))
                            .ToList();

            return gheeList;
        }

        public List<string> _getOilDetails(string type)
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@OIL_FOR";
            param.SqlDbType = SqlDbType.VarChar;
            param.Value = "PANCHAKARMA";
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@OIL_FOR_TYPE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Value = type;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Output;
            param.ParameterName = "@ERROR_MESSAGE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 250;
            parameters.Add(param);

            ds = dbo.GetDataSet("FETCH_OIL_DETAILS", parameters);

            List<string> oilList = ds.Tables[0].AsEnumerable()
                          .Select(r => r.Field<string>(0))
                          .ToList();

            return oilList;
        }


        public DataSet _getVamanDetails(string CaseID)
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@CASE_ID";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 50;
            param.Value = CaseID;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Output;
            param.ParameterName = "@ERROR_MESSAGE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 250;
            parameters.Add(param);

            ds = dbo.GetDataSet("FETCH_VAMAN_DATA", parameters);


            return ds;
        }


        public List<string> _insertVamanPurvaKarmaDetails(List<ModelVaman> model, string FollowupRequired, string FollowupDate, string Case_ID)
        {

            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            try
            {
                DataAccess dbo = new DataAccess();
                string FollowuRequired = FollowupRequired == "" ? "NO" : "YES";
                string FollowuDate = FollowupDate == "" ? DateTime.Now.ToString("dd/MM/yyyy") : FollowupDate;

                foreach (var item in model)
                {


                    parameters = new List<SqlParameter>();
                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@CASE_ID";
                    param.Value = Case_ID;
                    param.SqlDbType = SqlDbType.VarChar;
                    param.Size = 50;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@SrNo";
                    param.Value = item.SrNo;
                    param.SqlDbType = SqlDbType.Int;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@Date";
                    param.Value = DateTime.ParseExact(item.Date, "dd/MM/yyyy", null);
                    param.SqlDbType = SqlDbType.Date;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@OIL_GHEE";
                    param.Value = item.Oil_Ghee;
                    param.Size = 5;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@OIL_GHEE_NAME";
                    param.Value = item.Oil_Ghee_Name;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@DOSE";
                    param.Value = item.Dose;
                    param.Size = 5;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@MASSAGE";
                    param.Value = item.Massage;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@MASSAGE_OIL";
                    param.Value = item.Massage_Oil;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@SYMPTOMS";
                    param.Value = item.Symptoms;
                    param.Size = 250;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Output;
                    param.ParameterName = "@ERROR_MESSAGE";
                    param.SqlDbType = SqlDbType.VarChar;
                    param.Size = 250;
                    parameters.Add(param);

                    dbo._executeScalar("INSERT_VAMAN_DETAILS", parameters);

                    var prm = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                    error = prm.Value.ToString();


                    if (error == "TRUE")
                    {
                        responseList = new List<string>(new string[] { "true",
                            "Vaman Details Saved", Case_ID.ToString()});
                        continue;
                    }
                    else
                    {
                        responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
                        break;
                    }
                }

            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Panchakarma",
                    Metadata = "Error In _insertVamanPurvaKarmaDetails Function"
                });
                responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
            }
            return responseList;
        }


        public List<string> _insertVamanPradhanKarmaDetails(ModelPradhanVaman model, string Case_ID)
        {

            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            try
            {
                DataAccess dbo = new DataAccess();




                parameters = new List<SqlParameter>();
                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CASE_ID";
                param.Value = Case_ID;
                param.SqlDbType = SqlDbType.VarChar;
                param.Size = 50;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@PRADHANKARMADATE";
                param.Value = DateTime.ParseExact(model.PradhanKarmaDate, "dd/MM/yyyy", null);
                param.SqlDbType = SqlDbType.Date;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@UATKLESHAAHAR";
                param.Value = model.UatkleshaAhar;
                param.SqlDbType = SqlDbType.NVarChar;
                param.Size = 50;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@VAMANDRAVYA";
                param.Value = model.VamanDravya;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@SNEHANSVEDAN";
                param.Value = model.SnehanSvedan;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@DUDHAPANTIME";
                param.Value = model.DudhapanTime;
                param.SqlDbType = SqlDbType.NVarChar;
                param.Size = 50;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@DUDHPANQTY";
                param.Value = model.DudhpanQty;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CHATANTIME";
                param.Value = model.ChatanTime;
                param.SqlDbType = SqlDbType.NVarChar;
                param.Size = 50;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CHATANQTY";
                param.Value = model.ChatanQty;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@AKANTHAPANSTART";
                param.Value = model.AkanthapanStart;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@SAIVADHJAL";
                param.Value = model.SaivadhJal;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@DHUMPAN";
                param.Value = model.Dhumpan;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@SNEHANSVEDANTIME";
                param.Value = model.SnehanSvedanTime;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CHATAN";
                param.Value = model.Chatan;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@AKANTHAPAN";
                param.Value = model.Akanthapan;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@SAIVADHJALTIME";
                param.Value = model.SaivadhJalTime;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Output;
                param.ParameterName = "@ERROR_MESSAGE";
                param.SqlDbType = SqlDbType.VarChar;
                param.Size = 250;
                parameters.Add(param);

                dbo._executeScalar("INSERT_VAMAN_PRADHANKARMA_DETAILS", parameters);

                var prm = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                error = prm.Value.ToString();


                if (error == "TRUE")
                {
                    responseList = new List<string>(new string[] { "true",
                            "Vaman Details Saved", Case_ID.ToString()});

                }
                else
                {
                    responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});

                }


            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Panchakarma",
                    Metadata = "Error In _insertVamanPurvaKarmaDetails Function"
                });
                responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
            }



            return responseList;
        }


        public List<string> _insertVirechanaPurvaKarmaDetails(List<ModelVirechana> model, string FollowupRequired, string FollowupDate, string Case_ID)
        {

            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            try
            {
                DataAccess dbo = new DataAccess();
                string FollowuRequired = FollowupRequired == "" ? "NO" : "YES";
                string FollowuDate = FollowupDate == "" ? DateTime.Now.ToString("dd/MM/yyyy") : FollowupDate;

                foreach (var item in model)
                {


                    parameters = new List<SqlParameter>();
                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@CASE_ID";
                    param.Value = Case_ID;
                    param.SqlDbType = SqlDbType.VarChar;
                    param.Size = 50;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@SrNo";
                    param.Value = item.SrNo;
                    param.SqlDbType = SqlDbType.Int;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@Date";
                    param.Value = DateTime.ParseExact(item.Date, "dd/MM/yyyy", null);
                    param.SqlDbType = SqlDbType.Date;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@OIL_GHEE";
                    param.Value = item.Oil_Ghee;
                    param.Size = 5;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@OIL_GHEE_NAME";
                    param.Value = item.Oil_Ghee_Name;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@DOSE";
                    param.Value = item.Dose;
                    param.Size = 5;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@MASSAGE";
                    param.Value = item.Massage;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@MASSAGE_OIL";
                    param.Value = item.Massage_Oil;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@SYMPTOMS";
                    param.Value = item.Symptoms;
                    param.Size = 250;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Output;
                    param.ParameterName = "@ERROR_MESSAGE";
                    param.SqlDbType = SqlDbType.VarChar;
                    param.Size = 250;
                    parameters.Add(param);

                    dbo._executeScalar("INSERT_VIRECHANA_DETAILS", parameters);

                    var prm = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                    error = prm.Value.ToString();


                    if (error == "TRUE")
                    {
                        responseList = new List<string>(new string[] { "true",
                            "Virechana Details Saved", Case_ID.ToString()});
                        continue;
                    }
                    else
                    {
                        responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
                        break;
                    }
                }

            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Panchakarma",
                    Metadata = "Error In _insertVirechanaPurvaKarmaDetails Function"
                });
                responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
            }
            return responseList;
        }


        public List<string> _insertVirechanaPradhanKarmaDetails(ModelPradhanVirechana model, string Case_ID)
        {

            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            try
            {
                DataAccess dbo = new DataAccess();




                parameters = new List<SqlParameter>();
                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CASE_ID";
                param.Value = Case_ID;
                param.SqlDbType = SqlDbType.VarChar;
                param.Size = 50;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@PRADHANKARMADATE";
                param.Value = DateTime.ParseExact(model.PradhanKarmaDate, "dd/MM/yyyy", null);
                param.SqlDbType = SqlDbType.Date;
                parameters.Add(param);


                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@MEDICINENAME";
                param.Value = model.MedicineName;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@MEDICINEQTY";
                param.Value = model.MedicineQty;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@SYMPTOMS";
                param.Value = model.Symptoms;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@VIRECHNAVEG";
                param.Value = model.VirechnaVeg;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Output;
                param.ParameterName = "@ERROR_MESSAGE";
                param.SqlDbType = SqlDbType.VarChar;
                param.Size = 250;
                parameters.Add(param);

                dbo._executeScalar("INSERT_VIRECHANA_PRADHANKARMA_DETAILS", parameters);

                var prm = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                error = prm.Value.ToString();


                if (error == "TRUE")
                {
                    responseList = new List<string>(new string[] { "true",
                            "Virechana Details Saved", Case_ID.ToString()});

                }
                else
                {
                    responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});

                }


            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Panchakarma",
                    Metadata = "Error In _insertVirechanaPradhanKarmaDetails Function"
                });
                responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
            }



            return responseList;
        }


        public DataSet _getVirechanaDetails(string CaseID)
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@CASE_ID";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 50;
            param.Value = CaseID;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Output;
            param.ParameterName = "@ERROR_MESSAGE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 250;
            parameters.Add(param);

            ds = dbo.GetDataSet("FETCH_VIRECHANA_DATA", parameters);


            return ds;
        }

        public DataSet _getNasyaDetails(string CaseID)
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@CASE_ID";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 50;
            param.Value = CaseID;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Output;
            param.ParameterName = "@ERROR_MESSAGE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 250;
            parameters.Add(param);

            ds = dbo.GetDataSet("FETCH_NASYA_DATA", parameters);


            return ds;
        }

        public List<string> _insertNasyaDetails(List<ModelNasya> model, string FollowupRequired, string FollowupDate, string Case_ID)
        {

            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            try
            {
                DataAccess dbo = new DataAccess();
                string FollowuRequired = FollowupRequired == "" ? "NO" : "YES";
                string FollowuDate = FollowupDate == "" ? DateTime.Now.ToString("dd/MM/yyyy") : FollowupDate;

                foreach (var item in model)
                {


                    parameters = new List<SqlParameter>();
                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@CASE_ID";
                    param.Value = Case_ID;
                    param.SqlDbType = SqlDbType.VarChar;
                    param.Size = 50;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@SrNo";
                    param.Value = item.SrNo;
                    param.SqlDbType = SqlDbType.Int;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@Date";
                    param.Value = DateTime.ParseExact(item.Date, "dd/MM/yyyy", null);
                    param.SqlDbType = SqlDbType.Date;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@OIL_GHEE";
                    param.Value = item.Oil_Ghee;
                    param.Size = 5;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@OIL_GHEE_NAME";
                    param.Value = item.Oil_Ghee_Name;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@DOSE";
                    param.Value = item.Dose;
                    param.Size = 5;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@MASSAGE";
                    param.Value = item.Massage;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@MASSAGE_OIL";
                    param.Value = item.Massage_Oil;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@SYMPTOMS";
                    param.Value = item.Symptoms;
                    param.Size = 250;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Output;
                    param.ParameterName = "@ERROR_MESSAGE";
                    param.SqlDbType = SqlDbType.VarChar;
                    param.Size = 250;
                    parameters.Add(param);

                    dbo._executeScalar("INSERT_NASYA_DETAILS", parameters);

                    var prm = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                    error = prm.Value.ToString();


                    if (error == "TRUE")
                    {
                        responseList = new List<string>(new string[] { "true",
                            "Vaman Details Saved", Case_ID.ToString()});
                        continue;
                    }
                    else
                    {
                        responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
                        break;
                    }
                }

            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Panchakarma",
                    Metadata = "Error In _insertNasyaDetails Function"
                });
                responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
            }
            return responseList;
        }

        public DataSet _getRaktaMokshanaDetails(string CaseID)
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@CASE_ID";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 50;
            param.Value = CaseID;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Output;
            param.ParameterName = "@ERROR_MESSAGE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 250;
            parameters.Add(param);

            ds = dbo.GetDataSet("FETCH_RAKTAMOKSHANA_DATA", parameters);


            return ds;
        }

        public List<string> _insertRaktaMokshanaBasicDetails(ModelRaktaMokshanaBasic model, string Case_ID)
        {

            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            try
            {
                DataAccess dbo = new DataAccess();
                parameters = new List<SqlParameter>();
                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CASE_ID";
                param.Value = Case_ID;
                param.SqlDbType = SqlDbType.VarChar;
                param.Size = 50;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@BLEEDING_TIME";
                param.Value = model.BleedingTime;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CLOTING_TIME";
                param.Value = model.ClotingTime;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@BLOOD_PRESSURE";
                param.Value = model.BloodPressure;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@HB";
                param.Value = model.HB;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Output;
                param.ParameterName = "@ERROR_MESSAGE";
                param.SqlDbType = SqlDbType.VarChar;
                param.Size = 250;
                parameters.Add(param);

                dbo._executeScalar("INSERT_RAKTAMOKSHANA_BASIC_DETAILS", parameters);

                var prm = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                error = prm.Value.ToString();


                if (error == "TRUE")
                {
                    responseList = new List<string>(new string[] { "true",
                            "RaktaMokshana Details Saved", Case_ID.ToString()});

                }
                else
                {
                    responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});

                }


            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Panchakarma",
                    Metadata = "Error In _insertRaktaMokshanaBasicDetails Function"
                });
                responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
            }
            return responseList;
        }

        public List<string> _insertRaktaMokshanaDignosisDetails(ModelRaktaMokshanaDignosis model, string Case_ID)
        {

            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            try
            {
                DataAccess dbo = new DataAccess();
                parameters = new List<SqlParameter>();
                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@CASE_ID";
                param.Value = Case_ID;
                param.SqlDbType = SqlDbType.VarChar;
                param.Size = 50;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@DAYS";
                param.Value = model.Days;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@QUANTITY";
                param.Value = model.Quantity;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@SYMPTOMS";
                param.Value = model.Symptoms;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);
                

                param = new SqlParameter();
                param.Direction = ParameterDirection.Output;
                param.ParameterName = "@ERROR_MESSAGE";
                param.SqlDbType = SqlDbType.VarChar;
                param.Size = 250;
                parameters.Add(param);

                dbo._executeScalar("INSERT_RAKTAMOKSHANA_DIGNOSIS_DETAILS", parameters);

                var prm = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                error = prm.Value.ToString();


                if (error == "TRUE")
                {
                    responseList = new List<string>(new string[] { "true",
                            "RaktaMokshana Details Saved", Case_ID.ToString()});

                }
                else
                {
                    responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});

                }


            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Panchakarma",
                    Metadata = "Error In _insertRaktaMokshanaBasicDetails Function"
                });
                responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
            }
            return responseList;
        }

        public List<string> _insertRaktaMokshanaDetails(List<ModelRaktaMokshana> model, string FollowupRequired, string FollowupDate, string Case_ID)
        {

            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            try
            {
                DataAccess dbo = new DataAccess();
                string FollowuRequired = FollowupRequired == "" ? "NO" : "YES";
                string FollowuDate = FollowupDate == "" ? DateTime.Now.ToString("dd/MM/yyyy") : FollowupDate;

                foreach (var item in model)
                {


                    parameters = new List<SqlParameter>();
                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@CASE_ID";
                    param.Value = Case_ID;
                    param.SqlDbType = SqlDbType.VarChar;
                    param.Size = 50;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@SrNo";
                    param.Value = item.SrNo;
                    param.SqlDbType = SqlDbType.Int;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@Date";
                    param.Value = DateTime.ParseExact(item.Date, "dd/MM/yyyy", null);
                    param.SqlDbType = SqlDbType.Date;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@RAKTAMOKSHANATYPE";
                    param.Value = item.RaktaMokshanaType;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@SNEHAPAANYESNO";
                    param.Value = item.SnehaPaanYesNo;
                    param.Size = 5;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@SNEHAPAANDETAILS";
                    param.Value = item.SnehaPaanDetails;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@PLACE";
                    param.Value = item.Place;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@QUANTITY";
                    param.Value = item.Quantity;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@SYMPTOMS";
                    param.Value = item.Symptoms;
                    param.Size = 250;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);                   

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Output;
                    param.ParameterName = "@ERROR_MESSAGE";
                    param.SqlDbType = SqlDbType.VarChar;
                    param.Size = 250;
                    parameters.Add(param);

                    dbo._executeScalar("INSERT_RAKTAMOKSHANA_DETAILS", parameters);

                    var prm = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                    error = prm.Value.ToString();


                    if (error == "TRUE")
                    {
                        responseList = new List<string>(new string[] { "true",
                            "RaktaMokshana Details Saved", Case_ID.ToString()});
                        continue;
                    }
                    else
                    {
                        responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
                        break;
                    }
                }

            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Panchakarma",
                    Metadata = "Error In _insertRaktaMokshanaDetails Function"
                });
                responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
            }
            return responseList;
        }

        public List<string> _insertBastiPurvaKarmaDetails(List<ModelBasti> model, string FollowupRequired, string FollowupDate, string Case_ID)
        {

            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            try
            {
                DataAccess dbo = new DataAccess();
                string FollowuRequired = FollowupRequired == "" ? "NO" : "YES";
                string FollowuDate = FollowupDate == "" ? DateTime.Now.ToString("dd/MM/yyyy") : FollowupDate;

                foreach (var item in model)
                {


                    parameters = new List<SqlParameter>();
                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@CASE_ID";
                    param.Value = Case_ID;
                    param.SqlDbType = SqlDbType.VarChar;
                    param.Size = 50;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@SrNo";
                    param.Value = item.SrNo;
                    param.SqlDbType = SqlDbType.Int;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@Date";
                    param.Value = DateTime.ParseExact(item.Date, "dd/MM/yyyy", null);
                    param.SqlDbType = SqlDbType.Date;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@OIL_GHEE";
                    param.Value = item.Oil_Ghee;
                    param.Size = 5;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@OIL_GHEE_NAME";
                    param.Value = item.Oil_Ghee_Name;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@DOSE";
                    param.Value = item.Dosa;
                    param.Size = 5;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@MASSAGE";
                    param.Value = item.Massage;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@MASSAGE_OIL";
                    param.Value = item.Massage_Oil;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@SYMPTOMS";
                    param.Value = item.Symptoms;
                    param.Size = 250;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@DATTA";
                    param.Value = item.Datta;
                    param.Size = 20;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@PRATYAGAMAN";
                    param.Value = item.PratyaGaman;
                    param.Size = 250;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);


                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Output;
                    param.ParameterName = "@ERROR_MESSAGE";
                    param.SqlDbType = SqlDbType.VarChar;
                    param.Size = 250;
                    parameters.Add(param);

                    dbo._executeScalar("INSERT_BASTI_DETAILS", parameters);

                    var prm = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                    error = prm.Value.ToString();


                    if (error == "TRUE")
                    {
                        responseList = new List<string>(new string[] { "true",
                            "Basti Details Saved", Case_ID.ToString()});
                        continue;
                    }
                    else
                    {
                        responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
                        break;
                    }
                }

            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Panchakarma",
                    Metadata = "Error In _insertBastiPurvaKarmaDetails Function"
                });
                responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
            }
            return responseList;
        }

        public DataSet _getBastiDetails(string CaseID)
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@CASE_ID";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 50;
            param.Value = CaseID;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Output;
            param.ParameterName = "@ERROR_MESSAGE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 250;
            parameters.Add(param);

            ds = dbo.GetDataSet("FETCH_BASTI_DATA", parameters);


            return ds;
        }

        public List<string> _insertUttarBastiDetails(List<ModelBasti> model, string FollowupRequired, string FollowupDate, string Case_ID)
        {

            List<string> responseList = new List<string>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            SqlParameter param = new SqlParameter();
            string error = "";
            try
            {
                DataAccess dbo = new DataAccess();
                string FollowuRequired = FollowupRequired == "" ? "NO" : "YES";
                string FollowuDate = FollowupDate == "" ? DateTime.Now.ToString("dd/MM/yyyy") : FollowupDate;

                foreach (var item in model)
                {


                    parameters = new List<SqlParameter>();
                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@CASE_ID";
                    param.Value = Case_ID;
                    param.SqlDbType = SqlDbType.VarChar;
                    param.Size = 50;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@SrNo";
                    param.Value = item.SrNo;
                    param.SqlDbType = SqlDbType.Int;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@Date";
                    param.Value = DateTime.ParseExact(item.Date, "dd/MM/yyyy", null);
                    param.SqlDbType = SqlDbType.Date;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@MEDICINE";
                    param.Value = item.Oil_Ghee;
                    param.Size = 5;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@MEDICINE_NAME";
                    param.Value = item.Oil_Ghee_Name;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@DOSE";
                    param.Value = item.Dosa;
                    param.Size = 5;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@MASSAGE";
                    param.Value = item.Massage;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@MASSAGE_OIL";
                    param.Value = item.Massage_Oil;
                    param.Size = 50;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@SYMPTOMS";
                    param.Value = item.Symptoms;
                    param.Size = 250;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@DATTA";
                    param.Value = item.Datta;
                    param.Size = 20;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);

                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Input;
                    param.ParameterName = "@PRATYAGAMAN";
                    param.Value = item.PratyaGaman;
                    param.Size = 250;
                    param.SqlDbType = SqlDbType.NVarChar;
                    parameters.Add(param);


                    param = new SqlParameter();
                    param.Direction = ParameterDirection.Output;
                    param.ParameterName = "@ERROR_MESSAGE";
                    param.SqlDbType = SqlDbType.VarChar;
                    param.Size = 250;
                    parameters.Add(param);

                    dbo._executeScalar("INSERT_UTTAR_BASTI_DETAILS", parameters);

                    var prm = parameters.Where(a => a.ParameterName == "@ERROR_MESSAGE").FirstOrDefault();
                    error = prm.Value.ToString();


                    if (error == "TRUE")
                    {
                        responseList = new List<string>(new string[] { "true",
                            "UttarBasti Details Saved", Case_ID.ToString()});
                        continue;
                    }
                    else
                    {
                        responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
                        break;
                    }
                }

            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "Panchakarma",
                    Metadata = "Error In _insertUttarBastiDetails Function"
                });
                responseList = new List<string>(new string[] { "false",
                            "error occured", Case_ID.ToString()});
            }
            return responseList;
        }

        public DataSet _getUttarBastiDetails(string CaseID)
        {
            DataSet ds = new DataSet();


            DataAccess dbo = new DataAccess();

            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.ParameterName = "@CASE_ID";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 50;
            param.Value = CaseID;
            parameters.Add(param);

            param = new SqlParameter();
            param.Direction = ParameterDirection.Output;
            param.ParameterName = "@ERROR_MESSAGE";
            param.SqlDbType = SqlDbType.VarChar;
            param.Size = 250;
            parameters.Add(param);

            ds = dbo.GetDataSet("FETCH_UTTAR_BASTI_DATA", parameters);


            return ds;
        }

    }
}
