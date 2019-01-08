using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HMIS.Models.Account
{
    public class ModelLogin
    {

        private string userName;
        public string UserName
        {
            get
            {
                return this.userName;
            }
            set
            {
                this.userName = value;
            }
        }

        private string userPassword;
        public string Password
        {
            get
            {
                return this.userPassword;
            }
            set
            {
                this.userPassword = value;
            }
        }

    }
}
