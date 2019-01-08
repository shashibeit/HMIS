using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HMIS.Models.Logger
{
    public interface ILoggerManager
    {
        void Error(object msg, BaseLogModel baseLogModel);
        void Error(object msg, Exception ex, BaseLogModel baseLogModel);
        void Error(Exception ex, BaseLogModel baseLogModel);
        void Warn(object msg, BaseLogModel baseLogModel);
        void Warn(object msg, Exception ex, BaseLogModel baseLogModel);
        void Warn(Exception ex, BaseLogModel baseLogModel);
        void Info(object msg, BaseLogModel baseLogModel);
        void Info(object msg, Exception ex, BaseLogModel baseLogModel);
        void Info(Exception ex, BaseLogModel baseLogModel);
        void Fatal(object msg, BaseLogModel baseLogModel);
        void Fatal(object msg, Exception ex, BaseLogModel baseLogModel);
        void Fatal(Exception ex, BaseLogModel baseLogModel);
    }
}
