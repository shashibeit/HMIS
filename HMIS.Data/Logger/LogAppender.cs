using System;
using HMIS.Data.Account;
using HMIS.Models.Logger;
using log4net;
using log4net.Appender;
using log4net.Core;

namespace HMIS.Data.Logger
{
    public class LogAppender : AppenderSkeleton
    {
        /// <summary>
        /// Apend using LogViewModel 
        /// </summary>
        /// <param name="loggingEvent"></param>
        protected override void Append(LoggingEvent loggingEvent)
        {
            DateTimeOffset utcDate = DateTime.UtcNow;

            var logViewModel = new BaseLogModel()
            {
                MonthYear = Convert.ToInt32(DateTime.UtcNow.Month + "" + DateTime.UtcNow.Year),
                Message = loggingEvent.RenderedMessage,
                //StackTrace = loggingEvent.ExceptionObject != null ? $"{loggingEvent.GetExceptionString()}" : string.Empty,
                //StackTrace = loggingEvent.ExceptionObject != null ? $"{loggingEvent.GetExceptionString()}" : string.Empty,
                Level = loggingEvent.Level.Name,
                TimestampUtc = utcDate
            };

            if (LogicalThreadContext.Properties["BaseLogModel"] != null)
            {
                var logModel = (BaseLogModel)LogicalThreadContext.Properties["BaseLogModel"];
                logViewModel.Metadata = logModel.Metadata;
                logViewModel.Source = logModel.Source;
                logViewModel.Module = Convert.ToString(logModel.Module);

            }

            new DataAccess().LogError(logViewModel);

        }
    }
}