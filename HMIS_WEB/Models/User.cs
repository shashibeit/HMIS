namespace HMIS_WEB.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("USERS")]
    public partial class User
    {
        public int id { get; set; }

        [StringLength(100)]
        public string user_name { get; set; }

        [StringLength(250)]
        public string password { get; set; }

        [StringLength(250)]
        public string user_role { get; set; }

        [Column(TypeName = "date")]
        public DateTime? created_on { get; set; }
    }
}
