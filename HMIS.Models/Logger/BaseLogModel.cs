using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HMIS.Models.Logger
{
    public class BaseLogModel
    {
        public int MonthYear { get; set; }

        public string Level { get; set; }
        public DateTimeOffset TimestampUtc { get; set; }

        public string Message { get; set; }
        public string StackTrace { get; set; }
        public string Metadata { get; set; }
        public string Source { get; set; }
        public string Module { get; set; }
        public string ProcessName { get; set; }
    }
}
