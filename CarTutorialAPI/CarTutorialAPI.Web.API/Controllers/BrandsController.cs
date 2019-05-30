using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using CarTutorialAPI.ViewModels;

namespace CarTutorialAPI.Web.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BrandsController : ControllerBase
    {
        [HttpGet]

        public IEnumerable<BrandViewModel> Get()

        {

            return new List<BrandViewModel>() { new BrandViewModel { Name = "test" } };

        }
    }
}