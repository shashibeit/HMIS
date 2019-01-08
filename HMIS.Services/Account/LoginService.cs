using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HMIS.Models.Account;
using HMIS.Data.Account;
namespace HMIS.Services.Account
{
    public class LoginService
    {
        public bool PerformLogin(ModelLogin login) {
            LoginDbContext loginContext = new LoginDbContext();


            return loginContext.PerformLogin(login);
        }

    }
}
