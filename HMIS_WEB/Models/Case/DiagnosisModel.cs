using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HMIS.Models.Case;
using HMIS.Services.Case;

namespace HMIS_WEB.Models.Case
{
    public class DiagnosisModel
    {
        public List<string> InserDiagnosisDetails(ModelDiagnosis model, string Case_ID)
        {
            List<string> responseList = new List<string>();
            responseList = new DiagnosisService().InserDiagnosisDetails(model, Case_ID);
            return responseList;
        }

    }
}