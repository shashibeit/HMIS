using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using HMIS.Models.Account;
using HMIS.Services.Account;
namespace HMIS_WEB.Models.Account
{
    public class LoginModel
    {
       
        public bool PerformLogin(string username, string password) {


            ModelLogin login = new ModelLogin();
            login.UserName = username;
            login.Password = CalculateMD5Hash(password);
            LoginService service = new LoginService();
            var loginPass = service.PerformLogin(login);

            return loginPass;
        }


        static string CalculateMD5Hash(string input)
        {
            // step 1, calculate MD5 hash from input

            MD5 md5 = MD5.Create();

            byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);

            byte[] hash = md5.ComputeHash(inputBytes);

            // step 2, convert byte array to hex string

            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < hash.Length; i++)
            {
                sb.Append(hash[i].ToString("X2"));
            }
            return sb.ToString();
        }


    }
    public enum Gender
    {
        Male,
        Female
    }

    public enum Avastha
    {
        साम,
        निराम
    }
}