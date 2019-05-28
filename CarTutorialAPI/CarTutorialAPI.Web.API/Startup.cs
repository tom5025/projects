using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CarTutorialAPI.Models.Context;
using CarTutorialAPI.Web.API.App_Start;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace CarTutorialAPI.Web.API
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            DependencyInjectionConfig.AddScope(services);
            JwtTokenConfig.AddAuthentication(services, Configuration);
            DBContextConfig.Initialize(services, Configuration);
            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_1);
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app,
                              IHostingEnvironment env, 
                              IServiceProvider svp,
                              ApplicationContext dbContext)
        {
            //if (!dbContext.Database.IsInMemory()) // Skip migration for in-memory database used in unit tests
            //    dbContext.Database.Migrate();
            dbContext.Database.Migrate();
            SeedData.Seed(dbContext);
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseHsts();
            }
            DBContextConfig.Initialize(Configuration, env, svp);


            app.UseCors(builder => builder

                .AllowAnyOrigin()

                .AllowAnyMethod()

                .AllowAnyHeader()

                .AllowCredentials());

            app.UseAuthentication();
            app.UseHttpsRedirection();
            app.UseMvc();
        }
    }
}
