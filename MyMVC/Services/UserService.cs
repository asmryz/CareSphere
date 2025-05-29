using MyApiWithMySQL.Data.Models;
using System.Net.Http;
using System.Text.Json;
namespace MyMVC.Services
{
    

    public class UserService
    {
        private readonly HttpClient client;

        public UserService(HttpClient httpClient)
        {
            client = httpClient;
        }

        public async Task<List<User>> GetUsers()
        {
            var response = await client.GetAsync("http://localhost:5056/api/Users");
            response.EnsureSuccessStatusCode();

            var json = await response.Content.ReadAsStringAsync();
            var users = JsonSerializer.Deserialize<List<User>>(json, new JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true
            });

            return users ?? new List<User>();
        }

        public async Task<User> Authenticate(Login login)
        {
            // Serialize the Login object to JSON and send it as HttpContent
            string url = $"http://localhost:5056/api/Users/authenticate?Email={login.Email}&PasswordHash={login.PasswordHash}";
            var response = await client.GetAsync(url);
            response.EnsureSuccessStatusCode();

            var json = await response.Content.ReadAsStringAsync();
            var user = JsonSerializer.Deserialize<User>(json, new JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true
            });

            return user ?? new User();
        }
    }
}
