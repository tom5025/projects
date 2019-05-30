using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CarTutorialAPI.ViewModels;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CarTutorialAPI.Web.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CatController : ControllerBase
    {
        [HttpGet]
        public ActionResult<IEnumerable<CategoryViewModel>> Get()
        {
            return new List<CategoryViewModel>() { new CategoryViewModel { Name = "Distribution" } };
        }
    }
}