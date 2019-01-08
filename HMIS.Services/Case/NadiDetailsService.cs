using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data.Case;
using HMIS.Models.Case;

namespace HMIS.Services.Case
{
  public  class NadiDetailsService
    {
        public List<string> InserNadiDetails(NadiDetails nadi,string Case_ID)
        {
            return new NadiDbContext().InserNadiDetails(nadi,Case_ID);
        }
    }
}
