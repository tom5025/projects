using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;

namespace CarTutorialAPI.Models.Context
{
    public interface  IApplicationContext
    {
        DbSet<User> UsersDB { get; set; }
        DbSet<Article> ArticleDB { get; set; }
        DbSet<Category> Categories { get; set; }
        DbSet<Brand> Brands { get; set; }

        void SaveChanges();
    }
}
