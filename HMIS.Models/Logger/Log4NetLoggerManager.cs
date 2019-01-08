using System;
using System.Runtime.Remoting.Messaging;
using log4net;
using log4net.Config;


namespace HMIS.Models.Logger
{
    public class Log4NetLoggerManager : ILoggerManager
    {
        private static ILog Log { get; set; }

        static Log4NetLoggerManager()
        {
            XmlConfigurator.Configure();
            Log = LogManager.GetLogger(typeof(Log4NetLoggerManager));
        }

        /// <summary>
        /// This methods used for logging errors.
        /// </summary>
        /// <param name="msg">Error message which is to be logged.</param>
        /// <param name="baseLogModel">BaseLogModel details</param>
        public void Error(object msg, BaseLogModel baseLogModel)
        {
            LogicalThreadContext.Properties["BaseLogModel"] = baseLogModel;
            Log.Error(msg);
            FreeNamedDataSlot();
        }

        /// <summary>
        /// This methods used for logging errors with exception.
        /// </summary>
        /// <param name="msg">Error message which is to be logged.</param>
        /// <param name="ex">Exception which is to be logged.</param>
        /// <param name="baseLogModel">BaseLogModel details</param>
        public void Error(object msg, Exception ex, BaseLogModel baseLogModel)
        {
            LogicalThreadContext.Properties["BaseLogModel"] = baseLogModel;
            Log.Error(msg, ex);
            FreeNamedDataSlot();
        }

        /// <summary>
        /// This methods used for logging errors.
        /// </summary>
        /// <param name="ex">Exception which is to be logged.</param>
        /// <param name="baseLogModel">BaseLogModel details</param>
        public void Error(Exception ex, BaseLogModel baseLogModel)
        {
            LogicalThreadContext.Properties["BaseLogModel"] = baseLogModel;
            Log.Error(ex.Message, ex);
            FreeNamedDataSlot();
        }

        /// <summary>
        /// This methods used for logging wranings.
        /// </summary>
        /// <param name="msg">Warning message</param>
        /// <param name="baseLogModel">BaseLogModel Details</param>
        public void Warn(object msg, BaseLogModel baseLogModel)
        {
            LogicalThreadContext.Properties["BaseLogModel"] = baseLogModel;
            Log.Warn(msg);
            FreeNamedDataSlot();
        }

        /// <summary>
        /// This methods used for logging wranings with exceptions.
        /// </summary>
        /// <param name="msg">Warning message</param>
        /// <param name="ex">Exception which is to be logged.</param>
        /// <param name="baseLogModel">BaseLogModel details</param>
        public void Warn(object msg, Exception ex, BaseLogModel baseLogModel)
        {
            LogicalThreadContext.Properties["BaseLogModel"] = baseLogModel;
            Log.Warn(msg, ex);
            FreeNamedDataSlot();
        }

        /// <summary>
        /// This methods used for logging wranings with exceptions and baseLogModel.
        /// </summary>
        /// <param name="ex">Exception which is to be logged.</param>
        /// <param name="baseLogModel">BaseLogModel details</param>
        public void Warn(Exception ex, BaseLogModel baseLogModel)
        {
            LogicalThreadContext.Properties["BaseLogModel"] = baseLogModel;
            Log.Warn(ex.Message, ex);
            FreeNamedDataSlot();
        }

        /// <summary>
        /// This methods used for logging info messages.
        /// </summary>
        /// <param name="msg">Informative message</param>
        /// <param name="baseLogModel">BaseLogModel details</param>
        public void Info(object msg, BaseLogModel baseLogModel)
        {
            LogicalThreadContext.Properties["BaseLogModel"] = baseLogModel;
            Log.Info(msg);
            FreeNamedDataSlot();
        }

        /// <summary>
        /// This methods used for logging info messages.
        /// </summary>
        /// <param name="msg">Informative message</param>
        /// <param name="ex">Exception which is to be logged.</param>
        /// <param name="baseLogModel">BaseLogModel details</param>
        public void Info(object msg, Exception ex, BaseLogModel baseLogModel)
        {
            LogicalThreadContext.Properties["BaseLogModel"] = baseLogModel;
            Log.Info(msg, ex);
            FreeNamedDataSlot();
        }

        /// <summary>
        /// This methods used for logging info messages.
        /// </summary>
        /// <param name="ex">Exception which is to be logged.</param>
        /// <param name="baseLogModel">BaseLogModel details</param>
        public void Info(Exception ex, BaseLogModel baseLogModel)
        {
            LogicalThreadContext.Properties["BaseLogModel"] = baseLogModel;
            Log.Info(ex.Message, ex);
            FreeNamedDataSlot();
        }

        /// <summary>
        /// This methods used for logging fatal errors.
        /// </summary>
        /// <param name="msg">Fatal error message.</param>
        /// <param name="baseLogModel">BaseLogModel details</param>
        public void Fatal(object msg, BaseLogModel baseLogModel)
        {
            LogicalThreadContext.Properties["BaseLogModel"] = baseLogModel;
            Log.Fatal(msg);
            FreeNamedDataSlot();
        }

        /// <summary>
        /// This methods used for logging fatal errors with exceptions.
        /// </summary>
        /// <param name="msg">Fatal error message.</param>
        /// <param name="ex">Exception which is to be logged.</param>
        /// <param name="baseLogModel">BaseLogModel details</param>
        public void Fatal(object msg, Exception ex, BaseLogModel baseLogModel)
        {
            LogicalThreadContext.Properties["BaseLogModel"] = baseLogModel;
            Log.Fatal(msg, ex);
            FreeNamedDataSlot();
        }

        /// <summary>
        /// This methods used for logging fatal errors.
        /// </summary>
        /// <param name="ex">Exception which is to be logged.</param>
        /// <param name="baseLogModel">BaseLogModel details</param>
        public void Fatal(Exception ex, BaseLogModel baseLogModel)
        {
            LogicalThreadContext.Properties["BaseLogModel"] = baseLogModel;
            Log.Fatal(ex.Message, ex);
            FreeNamedDataSlot();
        }

        /// <summary>
        /// This methods used for logging debug info.
        /// </summary>
        /// <param name="msg">Debug info message.</param>
        /// <param name="baseLogModel">BaseLogModel details</param>
        public void Debug(object msg, BaseLogModel baseLogModel)
        {
            LogicalThreadContext.Properties["BaseLogModel"] = baseLogModel;
            Log.Debug(msg);
            FreeNamedDataSlot();
        }

        /// <summary>
        /// This method is use to free named data slots in log4net.dll
        /// </summary>
        private void FreeNamedDataSlot()
        {
            CallContext.FreeNamedDataSlot("log4net.Util.LogicalThreadContextProperties");
        }
    }
}
