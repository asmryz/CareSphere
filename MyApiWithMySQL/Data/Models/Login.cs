using System.ComponentModel.DataAnnotations;

namespace MyApiWithMySQL.Data.Models
{
    public class Login
    {
        internal readonly string PasswordHash;

        [Required]
        public string Username { get; set; }

        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }
    }
}
