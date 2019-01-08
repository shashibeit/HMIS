using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data;
using HMIS.Data.Logger;
using HMIS.Models.Logger;

namespace HMIS.Data.Account
{
   public class ConnectionDbContext
    {
        private readonly ILoggerManager _loggerManager;
        static string GetConnectionStrings()
        {
            ConfigurationManager.RefreshSection("connectionStrings");
            //  var connetionString = ConfigurationManager.ConnectionStrings["connString"].ToString();
           
            string txtpath = @"D:\Server\HMIS_WEB\HMIS_WEB\Properties\ConnectionString.txt";
            StreamReader sr = new StreamReader(txtpath);
            String line = sr.ReadToEnd();
            var connetionString = line;


            if (connetionString != "")
                return connetionString;
            else
                return "";
        }

        public SqlConnection _getConnection()
        {
            SqlConnection con = null; ;
            try
            {
                con = new SqlConnection(GetConnectionStrings());
            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "_getConnection",
                    Metadata = "Error In get connection Function"
                });
            }
            return con;
        }
    }
}
