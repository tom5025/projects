using CarTutorialAPI.Maps;
using CarTutorialAPI.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CarTutorialAPI.Web.API.Controllers
{
    [Route("api/[controller]")]

    [Authorize]

    public class UserController : Controller

    {

        IUserMap userMap;

        public UserController(IUserMap map)

        {

            userMap = map;

        }

        // GET api/user

        [HttpGet]

        public IEnumerable<UserViewModel> Get()

        {

            return userMap.GetAll();

        }

        // GET api/user/5

        [HttpGet("{id}")]

        public string Get(int id)

        {

            return "value";

        }

        // POST api/user

        [HttpPost]

        public void Post([FromBody]string user)

        {

        }

        // PUT api/user/5

        [HttpPut("{id}")]

        public void Put(int id, [FromBody]string user)

        {

        }

        // DELETE api/user/5

        [HttpDelete("{id}")]

        public void Delete(int id)

        {

        }

    }
}
