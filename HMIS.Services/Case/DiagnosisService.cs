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
    public class DiagnosisService
    {
        public List<string> InserDiagnosisDetails(ModelDiagnosis model, string Case_ID)
        {
            return new DiagnosisDbContext().InserDiagnosisDetails(model, Case_ID);
        }

    }
}
