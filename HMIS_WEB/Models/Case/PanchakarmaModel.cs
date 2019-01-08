using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mirabeau.MsSql;
using HMIS.Models.Case;
using HMIS.Models.Patient;
using HMIS.Services.Case;
namespace HMIS_WEB.Models.Case
{
    public class PanchakarmaModel
    {

        PanchakarmaService ps = new PanchakarmaService();


        public List<string> GetGheeDetails(string type) {

            return ps._getGheeDetails(type);
        }


        public List<string> GetOilDetails(string type)
        {

            return ps._getOilDetails(type);
        }

        public List<ModelVaman> _getVamanDetails(string CaseID) {
            return ps._getVamanDetails(CaseID);
        }

        public List<string> _insertVamanPurvaKarmaDetails(List<ModelVaman> modelList, string FollowupRequired, string FollowupDate, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = ps._insertVamanPurvaKarmaDetails(modelList,  FollowupRequired,  FollowupDate,  Case_ID);
            return oilList;
        }


        public List<string> _insertVamanPradhanKarmaDetails(ModelPradhanVaman model, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = ps._insertVamanPradhanKarmaDetails(model, Case_ID);
            return oilList;
        }


        public List<string> _insertVirechanaPurvaKarmaDetails(List<ModelVirechana> modelList, string FollowupRequired, string FollowupDate, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = ps._insertVirechanaPurvaKarmaDetails(modelList, FollowupRequired, FollowupDate, Case_ID);
            return oilList;
        }


        public List<string> _insertVirechanaPradhanKarmaDetails(ModelPradhanVirechana model, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = ps._insertVirechanaPradhanKarmaDetails(model, Case_ID);
            return oilList;
        }

        public List<ModelVirechana> _getVirechanaDetails(string CaseID)
        {
            return ps._getVirechanaDetails(CaseID);
        }


        public List<ModelNasya> _getNasyaDetails(string CaseID)
        {
            return ps._getNasyaDetails(CaseID);
        }

        public List<string> _insertNasyaDetails(List<ModelNasya> modelList, string FollowupRequired, string FollowupDate, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = ps._insertNasyaDetails(modelList, FollowupRequired, FollowupDate, Case_ID);
            return oilList;
        }


        public List<Object> _getRaktaMokshanaDetails(string CaseID)
        {
            return ps._getRaktaMokshanaDetails(CaseID);
        }

        public List<string> _insertRaktaMokshanaBasicDetails(ModelRaktaMokshanaBasic model,string Case_ID)
        {
            List<string> respList = new List<string>();
            respList = ps._insertRaktaMokshanaBasicDetails(model, Case_ID);
            return respList;
        }


        public List<string> _insertRaktaMokshanaDignosisDetails(ModelRaktaMokshanaDignosis model, string Case_ID)
        {
            List<string> respList = new List<string>();
            respList = ps._insertRaktaMokshanaDignosisDetails(model, Case_ID);
            return respList;
        }


        public List<string> _insertRaktaMokshanaDetails(List<ModelRaktaMokshana> modelList, string FollowupRequired, string FollowupDate, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = ps._insertRaktaMokshanaDetails(modelList, FollowupRequired, FollowupDate, Case_ID);
            return oilList;
        }

        public List<string> _insertBastiPurvaKarmaDetails(List<ModelBasti> modelList, string FollowupRequired, string FollowupDate, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = ps._insertBastiPurvaKarmaDetails(modelList, FollowupRequired, FollowupDate, Case_ID);
            return oilList;
        }

        public List<string> _insertUttarBastiDetails(List<ModelBasti> modelList, string FollowupRequired, string FollowupDate, string Case_ID)
        {
            List<string> oilList = new List<string>();
            oilList = ps._insertUttarBastiDetails(modelList, FollowupRequired, FollowupDate, Case_ID);
            return oilList;
        }

        public List<string> _getMedicineByType(string Type, string MedicineFor, string MedicineTypeFor)
        {           
            return new MedicineService()._getMedicineByType(Type, MedicineFor, MedicineTypeFor);

        }

        public List<ModelBasti> _getBastiDetails(string CaseID)
        {
            return ps._getBastiDetails(CaseID);
        }

        public List<ModelBasti> _getUttarBastiDetails(string CaseID)
        {
            return ps._getUttarBastiDetails(CaseID);
        }
    }
}