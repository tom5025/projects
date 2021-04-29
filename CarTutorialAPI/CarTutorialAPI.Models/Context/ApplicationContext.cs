using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;
using System;
using System.Collections.Generic;
using System.Text;
using System.Linq;
using CarTutorialAPI.Models.EntityBase;

namespace CarTutorialAPI.Models.Context
{
    public class ApplicationContext : IdentityDbContext<User>, IApplicationContext

    {

        private IDbContextTransaction dbContextTransaction;

        public ApplicationContext(DbContextOptions options)

            : base(options)

        {

        }



        public DbSet<User> UsersDB { get; set; }
        public DbSet<Article> ArticleDB { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Brand> Brands { get; set; }

        public new void SaveChanges()

        {
            SetUpdatedAt();
            base.SaveChanges();
        }

        public new DbSet<T> Set<T>() where T : class

        {

            return base.Set<T>();

        }

        public void BeginTransaction()

        {

            dbContextTransaction = Database.BeginTransaction();

        }

        public void CommitTransaction()

        {

            if (dbContextTransaction != null)

            {

                dbContextTransaction.Commit();

            }

        }

        public void RollbackTransaction()

        {

            if (dbContextTransaction != null)

            {

                dbContextTransaction.Rollback();

            }

        }

        public void DisposeTransaction()

        {

            if (dbContextTransaction != null)

            {

                dbContextTransaction.Dispose();

            }

        }

        protected void SetUpdatedAt()
        {
            // get entries that are being Added or Updated
            var modifiedEntries = ChangeTracker.Entries().Where(x => (x.State == EntityState.Added || x.State == EntityState.Modified));
            var currentTime = DateTime.Now;
            foreach (var entry in modifiedEntries)
            {
                var entity = entry.Entity as EntityBaseClass;
                if (entity != null)
                {
                    entity.Updated = currentTime;
                }
            }
        }

    }
}
