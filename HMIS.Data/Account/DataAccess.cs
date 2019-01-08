using System;
using System.Collections.Generic;
using System.Data;
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
    public class DataAccess
    {
        private readonly ILoggerManager _loggerManager;
        public DataTable ExecuteStoredProcedure(string spName, string[] paramNames, string[] paramValues)
        {
            DataTable dt = new DataTable();
            ConnectionDbContext objConProvider = new ConnectionDbContext();

            SqlConnection conn = objConProvider._getConnection();

            try
            {
                //create a command and assign it to the passed stored procedure name
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn; // new SqlConnection(connString); ;
                cmd.CommandText = spName;

                //add any and all parameters to the command
                for (int i = 0; i < paramNames.Length; i++)
                {
                    SqlParameter temp = new SqlParameter(paramNames[i], paramValues[i]);
                    cmd.Parameters.Add(temp);
                    //cmd.Parameters.AddWithValue(paramNames[i], paramValues[i]);
                }

                //get the data and return it
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                return dt;
            }
            catch (Exception ae)
            {

                return dt;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
            }
        }


        public DataSet GetDataSet(string commandName, List<SqlParameter> param)
        {
            DataSet ds = new DataSet();
            ConnectionDbContext objConProvider = new ConnectionDbContext();

            SqlConnection con = objConProvider._getConnection();
            try
            {
                //create a command and assign it to the passed stored procedure name
                SqlCommand cmd = new SqlCommand();
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                cmd.Connection = con; // new SqlConnection(connString); ;
                cmd.CommandText = commandName;
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddRange(param.ToArray());
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                return ds;
            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "GetDataSet",
                    Metadata = "Error In GetDataSet Function"
                });
                return ds;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }


        public List<SqlParameter> _executeScalar(string commandName, List<SqlParameter> param)
        {
            ConnectionDbContext objConProvider = new ConnectionDbContext();

            SqlConnection con = objConProvider._getConnection();
            try
            {
                //create a command and assign it to the passed stored procedure name
                SqlCommand cmd = new SqlCommand();
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                cmd.Parameters.Clear();
                cmd.Connection = con; // new SqlConnection(connString); ;
                cmd.CommandText = commandName;
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddRange(param.ToArray());

                cmd.ExecuteReader();
                cmd.Parameters.Clear();
            }
            catch (Exception ae)
            {
                _loggerManager.Error(ae, new BaseLogModel
                {
                    Level = "ERROR",
                    Module = "_executeScalar",
                    Metadata = "Error In ExecuteScalar Function"
                });
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return param;
        }


        public void LogError(BaseLogModel model)
        {
            try
            {
                DataAccess dbo = new DataAccess();

                List<SqlParameter> parameters = new List<SqlParameter>();

                SqlParameter param = new SqlParameter();
               
                
                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@module";
                param.Value =model.Module;
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@process_name";
                param.Value = model.Message != "" ? model.Message : "";
                param.Size = 50;
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@error_message";
                param.Value = model.Message!=""? model.Message:"";
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);

                param = new SqlParameter();
                param.Direction = ParameterDirection.Input;
                param.ParameterName = "@stack_trace";
                param.Value =model.StackTrace!=null? model.StackTrace:"NA";
                param.SqlDbType = SqlDbType.NVarChar;
                parameters.Add(param);
                
                dbo._executeScalar("sp_LogApplicationError1", parameters);
            }
            catch (Exception ae)
            {
                string filePath = @"D:\Server\HMIS_WEB\Error.txt";

                using (StreamWriter writer = new StreamWriter(filePath, true))
                {
                    writer.WriteLine("Message :" + model.Message + "<br/>" + Environment.NewLine + "StackTrace :" + model.StackTrace +
                       "" + Environment.NewLine + "Date :" + DateTime.Now.ToString());
                    writer.WriteLine(Environment.NewLine + "-----------------------------------------------------------------------------" + Environment.NewLine);
                }
            }
        }

    }
}
