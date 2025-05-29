using Microsoft.AspNetCore.Mvc;
using MyMVC.Models;
using MyMVC.Services;
using System.Diagnostics;
using MyApiWithMySQL.Data.Models;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

namespace MyMVC.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly AppointmentService _svcAppointment;
        private readonly UserService _svcUser;

        public HomeController(
            ILogger<HomeController> logger,
            AppointmentService svcAppointment,
            UserService svcUser
            )
        {
            _logger = logger;
            _svcAppointment = svcAppointment;
            _svcUser = svcUser;
        }

        public async Task<IActionResult> Index()
        {
            var appointments = await _svcAppointment.GetAppointments();
            return View(appointments);
        }
        public IActionResult Login()
        {
            //var appointments = await _service.GetAppointments();
            return View();
        }

        public async Task<IActionResult> User()
        {
            var users = await _svcUser.GetUsers();
            return View(users);
        }


        [HttpPost]
        public async Task<IActionResult> AuthenticateAsync(Login login)
        {

            var user = await _svcUser.Authenticate(login);

            if (user != null)
                {
                    ViewData["User"] = user;
                }
            
            return View("Dashboard", user); // Corrected method call
        }

        public IActionResult Dashboard()
        {
            return View();
        }



        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
