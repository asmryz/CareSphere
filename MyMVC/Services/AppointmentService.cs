using MyApiWithMySQL.Models;
using System.Net.Http;
using System.Text.Json;
namespace MyMVC.Services
{
    

    public class AppointmentService
    {
        private readonly HttpClient client;

        public AppointmentService(HttpClient httpClient)
        {
            client = httpClient;
        }

        public async Task<List<Appointment>> GetAppointments()
        {
            var response = await client.GetAsync("http://localhost:5056/api/Appointments\r\n");
            response.EnsureSuccessStatusCode();

            var json = await response.Content.ReadAsStringAsync();
            var appointments = JsonSerializer.Deserialize<List<Appointment>>(json, new JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true
            });

            return appointments ?? new List<Appointment>();
        }

    }
}
