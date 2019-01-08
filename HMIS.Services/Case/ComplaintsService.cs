using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data.Case;
using HMIS.Models.Case;

namespace HMIS.Services.Case
{
    public class ComplaintsService
    {

        public List<string> InserComplaintDetails(ComplaintsDetaills compalints, string Case_ID)
        {
            return new ComplaintsDbContext().InserComplaintDetails(compalints, Case_ID);
        }
    }
}
