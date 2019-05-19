using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using testFormsNg.Models;

namespace testFormsNg.Controllers
{
    [Route("api/[controller]")]
    public class SampleDataController : Controller
    {
        private static string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        [HttpGet("[action]")]
        public IEnumerable<WeatherForecast> WeatherForecasts()
        {
            var rng = new Random();
            return Enumerable.Range(1, 5).Select(index => new WeatherForecast
            {
                DateFormatted = DateTime.Now.AddDays(index).ToString("d"),
                TemperatureC = rng.Next(-20, 55),
                Summary = Summaries[rng.Next(Summaries.Length)]
            });
        }

        public class WeatherForecast
        {
            public string DateFormatted { get; set; }
            public int TemperatureC { get; set; }
            public string Summary { get; set; }

            public int TemperatureF
            {
                get
                {
                    return 32 + (int)(TemperatureC / 0.5556);
                }
            }
        }

        
        [HttpPost]
        public IActionResult Post([FromBody]Person person)
        {
            // return validation error if required fields aren't filled in
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // return validation error if email already exists
            //Person existingPerson = peopleDataContext.People.Where(p => p.EmailAddress == person.EmailAddress).FirstOrDefault();
            //if (existingPerson != null)
            //{
            //    ModelState.AddModelError("emailAddress", "This email already exists");
            //    return BadRequest(ModelState);
            //}

            //// validation has passed, so, save the person in the database
            //peopleDataContext.People.Add(person);
            //peopleDataContext.SaveChanges();

            // returned the saved person to the client
            return Json(person);
        }
    }
}
