using CarTutorialAPI.Maps;
using CarTutorialAPI.Models.Context;
using CarTutorialAPI.Repositories;
using CarTutorialAPI.Services;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CarTutorialAPI.Web.API.App_Start
{
    public class DependencyInjectionConfig
    {
        public static void AddScope(IServiceCollection services)

        {

            services.AddScoped<IApplicationContext, ApplicationContext>();

            services.AddScoped<IUserMap, UserMap>();

            services.AddScoped<IUserService, UserService>();

            services.AddScoped<IUserRepository, UserRepository>();

        }
    }
}
