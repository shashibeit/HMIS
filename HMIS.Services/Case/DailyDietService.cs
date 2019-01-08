using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data.Case;
using HMIS.Models.Case;

namespace HMIS.Services.Case
{
   public class DailyDietService
    {
        public List<string> InsertDailyDietDetails(DailyDiet diet, string Case_ID)
        {
            return new DailyDietDbContext().InsertDailyDietDetails(diet, Case_ID);
        }

    }
}
