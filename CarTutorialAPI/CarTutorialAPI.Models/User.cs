using Microsoft.AspNetCore.Identity;
using System;

namespace CarTutorialAPI.Models
{
    public class User : IdentityUser
    {

        public string Name { get; set; }

    }
}