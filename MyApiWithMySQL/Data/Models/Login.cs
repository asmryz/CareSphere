using System.ComponentModel.DataAnnotations;

namespace MyApiWithMySQL.Data.Models
{
    public class Login
    {
        [Required]
        public string Email { get; set; }

        [Required]
        [DataType(DataType.Password)]
        public string PasswordHash { get; set; } // Changed from field to property to ensure proper initialization handling
    }
}
