using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data.Case;
using HMIS.Models.Case;

namespace HMIS.Services.Case
{
    public class PanchakarmaService
    {
        PanchakarmaDbContext pdo = new PanchakarmaDbContext();
        public List<string> _getGheeDetails(string type)
        {
            List<string> gheeList = new List<string>();
            gheeList = pdo._getGheeDetails(type);
            return gheeList;
        }

        public List<string> _getOilDetails(string type)
        {
            List<string> oilList = new List<string>();
            oilList = pdo._getOilDetails(type);
            return oilList;
        }

        public List<ModelVaman> _getVamanDetails(string CaseID)
        {
            List<ModelVaman> VamanList = new List<ModelVaman>();
            PanchakarmaDbContext objPanchakarma = new PanchakarmaDbContext();

            DataSet ds = objPanchakarma._getVamanDetails(CaseID);

            if (ds != null)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                foreach (DataRow row in dt.Rows)
                {
                    ModelVaman vaman = new ModelVaman();
                    vaman.SrNo = Convert.ToInt64(row["SR_NO"].ToString());
                    vaman.Date = row["DATE"].ToString();
                    vaman.Oil_Ghee = row["OIL_GHEE"].ToString();
                    vaman.Oil_Ghee_Name = row["OIL_GHEE_NAME"].ToString();
                    vaman.Dose = row["DOSE"].ToString();
                    vaman.Massage = row["MASSAGE"].ToString();
                    vaman.Massage_Oil = row["MASSAGE_OIL"].ToString();
                    vaman.Symptoms = row["SYMPTOMS"].ToString();
                    VamanList.Add(vaman);
                }
            }

            return VamanList;
        }


        public List<string> _insertVamanPurvaKarmaDetails(List<ModelVaman> modelList, string FollowupRequired, string FollowupDate, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = pdo._insertVamanPurvaKarmaDetails(modelList, FollowupRequired, FollowupDate, Case_ID);
            return oilList;
        }


        public List<string> _insertVamanPradhanKarmaDetails(ModelPradhanVaman model, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = pdo._insertVamanPradhanKarmaDetails(model, Case_ID);
            return oilList;
        }


        public List<string> _insertVirechanaPurvaKarmaDetails(List<ModelVirechana> modelList, string FollowupRequired, string FollowupDate, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = pdo._insertVirechanaPurvaKarmaDetails(modelList, FollowupRequired, FollowupDate, Case_ID);
            return oilList;
        }


        public List<string> _insertVirechanaPradhanKarmaDetails(ModelPradhanVirechana model, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = pdo._insertVirechanaPradhanKarmaDetails(model, Case_ID);
            return oilList;
        }

        public List<ModelVirechana> _getVirechanaDetails(string CaseID)
        {
            List<ModelVirechana> VamanList = new List<ModelVirechana>();
            PanchakarmaDbContext objPanchakarma = new PanchakarmaDbContext();

            DataSet ds = objPanchakarma._getVirechanaDetails(CaseID);

            if (ds != null)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                foreach (DataRow row in dt.Rows)
                {
                    ModelVirechana vaman = new ModelVirechana();
                    vaman.SrNo = Convert.ToInt64(row["SR_NO"].ToString());
                    vaman.Date = row["DATE"].ToString();
                    vaman.Oil_Ghee = row["OIL_GHEE"].ToString();
                    vaman.Oil_Ghee_Name = row["OIL_GHEE_NAME"].ToString();
                    vaman.Dose = row["DOSE"].ToString();
                    vaman.Massage = row["MASSAGE"].ToString();
                    vaman.Massage_Oil = row["MASSAGE_OIL"].ToString();
                    vaman.Symptoms = row["SYMPTOMS"].ToString();
                    VamanList.Add(vaman);
                }
            }

            return VamanList;
        }



        public List<ModelNasya> _getNasyaDetails(string CaseID)
        {
            List<ModelNasya> VamanList = new List<ModelNasya>();
            PanchakarmaDbContext objPanchakarma = new PanchakarmaDbContext();

            DataSet ds = objPanchakarma._getNasyaDetails(CaseID);

            if (ds != null)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                foreach (DataRow row in dt.Rows)
                {
                    ModelNasya vaman = new ModelNasya();
                    vaman.SrNo = Convert.ToInt64(row["SR_NO"].ToString());
                    vaman.Date = row["DATE"].ToString();
                    vaman.Oil_Ghee = row["OIL_GHEE"].ToString();
                    vaman.Oil_Ghee_Name = row["OIL_GHEE_NAME"].ToString();
                    vaman.Dose = row["DOSE"].ToString();
                    vaman.Massage = row["MASSAGE"].ToString();
                    vaman.Massage_Oil = row["MASSAGE_OIL"].ToString();
                    vaman.Symptoms = row["SYMPTOMS"].ToString();
                    VamanList.Add(vaman);
                }
            }

            return VamanList;
        }


        public List<string> _insertNasyaDetails(List<ModelNasya> modelList, string FollowupRequired, string FollowupDate, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = pdo._insertNasyaDetails(modelList, FollowupRequired, FollowupDate, Case_ID);
            return oilList;
        }


        public List<Object> _getRaktaMokshanaDetails(string CaseID)
        {
            List<Object> objList = new List<object>();
            List<ModelRaktaMokshana> RaktaMokshanaList = new List<ModelRaktaMokshana>();
            List<ModelRaktaMokshanaBasic> ModelRaktaMokshanaBasicList = new List<ModelRaktaMokshanaBasic>();
            List<ModelRaktaMokshanaDignosis> ModelRaktaMokshanaDignosisList = new List<ModelRaktaMokshanaDignosis>();

            PanchakarmaDbContext objPanchakarma = new PanchakarmaDbContext();

            DataSet ds = objPanchakarma._getRaktaMokshanaDetails(CaseID);

            if (ds != null)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                foreach (DataRow row in dt.Rows)
                {
                    ModelRaktaMokshana vaman = new ModelRaktaMokshana();
                    vaman.SrNo = Convert.ToInt64(row["SR_NO"].ToString());
                    vaman.Date = row["DATE"].ToString();
                    vaman.RaktaMokshanaType = row["RAKTAMOKSHANATYPE"].ToString();
                    vaman.SnehaPaanYesNo = row["SNEHAPAANYESNO"].ToString();
                    vaman.SnehaPaanDetails = row["SNEHAPAANDETAILS"].ToString();
                    vaman.Place = row["PLACE"].ToString();
                    vaman.Quantity = row["QUANTITY"].ToString();
                    vaman.Symptoms = row["SYMPTOMS"].ToString();
                    RaktaMokshanaList.Add(vaman);
                }
                
                dt = ds.Tables[1];
                foreach (DataRow row in dt.Rows)
                {
                    ModelRaktaMokshanaBasic model = new ModelRaktaMokshanaBasic();
                    model.BleedingTime = row["BLEEDING_TIME"].ToString();
                    model.ClotingTime = row["CLOTING_TIME"].ToString();
                    model.BloodPressure = row["BLOOD_PRESSURE"].ToString();
                    model.HB = row["HB"].ToString();
                    ModelRaktaMokshanaBasicList.Add(model);
                }

                dt = ds.Tables[2];
                foreach (DataRow row in dt.Rows)
                {
                    ModelRaktaMokshanaDignosis model = new ModelRaktaMokshanaDignosis();
                    model.Days = row["DAYS"].ToString();
                    model.Quantity = row["QUANTITY"].ToString();
                    model.Symptoms = row["SYMPTOMS"].ToString();
                    ModelRaktaMokshanaDignosisList.Add(model);
                }

                objList.Add(RaktaMokshanaList);
                objList.Add(ModelRaktaMokshanaBasicList);
                objList.Add(ModelRaktaMokshanaDignosisList);
            }

            return objList;
        }


        public List<string> _insertRaktaMokshanaBasicDetails(ModelRaktaMokshanaBasic model, string Case_ID)
        {
            List<string> respList = new List<string>();
            respList = pdo._insertRaktaMokshanaBasicDetails(model, Case_ID);
            return respList;
        }


        public List<string> _insertRaktaMokshanaDignosisDetails(ModelRaktaMokshanaDignosis model, string Case_ID)
        {
            List<string> respList = new List<string>();
            respList = pdo._insertRaktaMokshanaDignosisDetails(model, Case_ID);
            return respList;
        }

        public List<string> _insertRaktaMokshanaDetails(List<ModelRaktaMokshana> modelList, string FollowupRequired, string FollowupDate, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = pdo._insertRaktaMokshanaDetails(modelList, FollowupRequired, FollowupDate, Case_ID);
            return oilList;
        }


        public List<string> _insertBastiPurvaKarmaDetails(List<ModelBasti> modelList, string FollowupRequired, string FollowupDate, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = pdo._insertBastiPurvaKarmaDetails(modelList, FollowupRequired, FollowupDate, Case_ID);
            return oilList;
        }

        public List<ModelBasti> _getBastiDetails(string CaseID)
        {
            List<ModelBasti> BastiList = new List<ModelBasti>();
            PanchakarmaDbContext objPanchakarma = new PanchakarmaDbContext();

            DataSet ds = objPanchakarma._getBastiDetails(CaseID);

            if (ds != null)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                foreach (DataRow row in dt.Rows)
                {
                    ModelBasti basti = new ModelBasti();
                    basti.SrNo = Convert.ToInt64(row["SR_NO"].ToString());
                    basti.Date = row["DATE"].ToString();
                    basti.Oil_Ghee = row["OIL_GHEE"].ToString();
                    basti.Oil_Ghee_Name = row["OIL_GHEE_NAME"].ToString();
                    basti.Dosa = row["DOSE"].ToString();
                    basti.Massage = row["MASSAGE"].ToString();
                    basti.Massage_Oil = row["MASSAGE_OIL"].ToString();
                    basti.Symptoms = row["SYMPTOMS"].ToString();
                    basti.Datta = row["DATTA"].ToString();
                    basti.PratyaGaman = row["PRATYAGAMAN"].ToString();
                    BastiList.Add(basti);
                }
            }

            return BastiList;
        }

        public List<string> _insertUttarBastiDetails(List<ModelBasti> modelList, string FollowupRequired, string FollowupDate, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = pdo._insertUttarBastiDetails(modelList, FollowupRequired, FollowupDate, Case_ID);
            return oilList;
        }

        public List<ModelBasti> _getUttarBastiDetails(string CaseID)
        {
            List<ModelBasti> BastiList = new List<ModelBasti>();
            PanchakarmaDbContext objPanchakarma = new PanchakarmaDbContext();

            DataSet ds = objPanchakarma._getUttarBastiDetails(CaseID);

            if (ds != null)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                foreach (DataRow row in dt.Rows)
                {
                    ModelBasti basti = new ModelBasti();
                    basti.SrNo = Convert.ToInt64(row["SR_NO"].ToString());
                    basti.Date = row["DATE"].ToString();
                    basti.Oil_Ghee = row["MEDICINE"].ToString();
                    basti.Oil_Ghee_Name = row["MEDICINE_NAME"].ToString();
                    basti.Dosa = row["DOSE"].ToString();
                    basti.Massage = row["MASSAGE"].ToString();
                    basti.Massage_Oil = row["MASSAGE_OIL"].ToString();
                    basti.Symptoms = row["SYMPTOMS"].ToString();
                    basti.Datta = row["DATTA"].ToString();
                    basti.PratyaGaman = row["PRATYAGAMAN"].ToString();
                    BastiList.Add(basti);
                }
            }

            return BastiList;
        }

    }
}
