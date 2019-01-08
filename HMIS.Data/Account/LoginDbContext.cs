using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Data.Logger;
using HMIS.Models.Logger;
using HMIS.Models.Account;
namespace HMIS.Data.Account
{
    public class LoginDbContext
    {
        SqlConnection con;
         Log4NetLoggerManager _loggerManager=new Log4NetLoggerManager();
        public bool PerformLogin(ModelLogin login)
        {
            Boolean _LoginPass = false;
            ConnectionDbContext objConProvider = new ConnectionDbContext();
            con = objConProvider._getConnection();

            if (con != null)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("SP_LOGIN_PROCESS", con);
                    SqlDataAdapter da;
                    DataTable dt = new DataTable();
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@USERNAME", SqlDbType.VarChar, 100).Value = login.UserName;
                    cmd.Parameters.Add("@PASSWORD", SqlDbType.VarChar, 250).Value = login.Password;
                    cmd.Parameters.Add("@LOGINPASS", SqlDbType.Bit, 1).Direction = ParameterDirection.Output;
                    cmd.ExecuteNonQuery();
                    _LoginPass = Convert.ToBoolean(cmd.Parameters["@LOGINPASS"].Value);
                    con.Close();
                }
                catch (Exception ae)
                {
                    _loggerManager.Error(ae, new BaseLogModel
                    {
                        Level = "ERROR",
                        Module = "PerformLogin",
                        Metadata = "Error In login Function"
                    });
                }
                finally
                {
                    if (con.State == ConnectionState.Open)
                    {
                        con.Close();
                    }
                }
            }
            return _LoginPass;
        }
    }
}
