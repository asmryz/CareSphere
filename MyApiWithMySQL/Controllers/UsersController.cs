using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.Web.CodeGenerators.Mvc.Templates.BlazorIdentity.Pages;
using MyApiWithMySQL.Data;
using MyApiWithMySQL.Data.Models;
using Login = MyApiWithMySQL.Data.Models.Login;

namespace MyApiWithMySQL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UsersController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/Users  
        [HttpGet]
        public async Task<ActionResult<IEnumerable<User>>> GetUsers()
        {
            return await _context.Users.ToListAsync();
        }

        // Fixed method signature and implementation to resolve CS1061 error  
        [HttpGet("authenticate")]
        public async Task<ActionResult<User>> Authenticate(string username, string password)
        {
            // Fix: Use FirstOrDefaultAsync to retrieve a single user asynchronously  
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Username.ToString() == username);

            if (user == null)
            {
                return Unauthorized();
            }

            return user;
        }

        // GET: api/Users/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Appointment>> GetUser(int id)
        {
            var appointment = await _context.Appointments.FindAsync(id);

            if (appointment == null)
            {
                return NotFound();
            }

            return appointment;
        }
    }

}

        //// GET: api/Users/5
        //[HttpGet("{id}")]
        //public async Task<ActionResult<Appointment>> GetUser(int id)
        //{
        //    var appointment = await _context.Appointments.FindAsync(id);

        //    if (appointment == null)
        //    {
        //        return NotFound();
        //    }

        //    return appointment;
        //}
//    }
//}
