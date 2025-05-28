using Microsoft.AspNetCore.Mvc;
using MyMVC.Models;
using MyMVC.Services;
using System.Diagnostics;

namespace MyMVC.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly AppointmentService _service;

        public HomeController(
            ILogger<HomeController> logger,
            AppointmentService service
            )
        {
            _logger = logger;
            _service = service;
        }

        public async Task<IActionResult> Index()
        {
            var appointments = await _service.GetAppointments();
            return View(appointments);
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
