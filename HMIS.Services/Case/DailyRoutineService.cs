using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data.Case;
using HMIS.Models.Case;

namespace HMIS.Services.Case
{
   public  class DailyRoutineService
    {
        public List<string> InserRoutineDetails(DailyRoutine routine, string Case_ID)
        {
            return new DailyRoutineDbContext().InserRoutineDetails(routine, Case_ID);
        }
    }
}
