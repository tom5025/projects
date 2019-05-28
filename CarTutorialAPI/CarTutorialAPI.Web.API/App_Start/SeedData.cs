using CarTutorialAPI.Models;
using CarTutorialAPI.Models.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CarTutorialAPI.Web.API.App_Start
{
    public static class SeedData
    {
        private static void SeedBrands(IApplicationContext dbContext)
        {
            var brandList = new List<Brand>();
            brandList.Add(new Brand() { Name = "Alfa Romeo" });
            brandList.Add(new Brand() { Name = "Porsche" });
            brandList.Add(new Brand() { Name = "Fiat" });
            brandList.Add(new Brand() { Name = "Peugeot" });
            brandList.Add(new Brand() { Name = "Citroën" });
            brandList.Add(new Brand() { Name = "Renault" });
            brandList.Add(new Brand() { Name = "Dodge" });
            brandList.Add(new Brand() { Name = "Cadillac" });
            brandList.Add(new Brand() { Name = "Lamborghini" });
            brandList.Add(new Brand() { Name = "Ferrari" });
            foreach (var b in brandList)
            {
                dbContext.Brands.Add(b);
            }
        }

        private static void SeedCategories(IApplicationContext dbContext)
        {
            var list = new List<Category>();
            list.Add(new Category() { Name = "Direction et freinage" });
            list.Add(new Category() { Name = "Moteur" });
            list.Add(new Category() { Name = "Embrayage" });
            list.Add(new Category() { Name = "Refroidissement" });
            list.Add(new Category() { Name = "Gestion moteur" });
            list.Add(new Category() { Name = "Carrosserie" });
            list.Add(new Category() { Name = "Extras" });
            list.Add(new Category() { Name = "Filtration" });
            list.Add(new Category() { Name = "Fluides et lubrifiants" });
            list.Add(new Category() { Name = "Boite de vitesses" });
            list.Add(new Category() { Name = "Eclairage" });
            list.Add(new Category() { Name = "Pièces performance" });
            list.Add(new Category() { Name = "Entretien programmé" });
            list.Add(new Category() { Name = "Suspension" });
           

            foreach (var c in list)
            {
                dbContext.Categories.Add(c);
            }
        }

        public static void Seed(IApplicationContext dbContext)
        {
            if (dbContext.Categories.Count() != 0)
                return;

            SeedCategories(dbContext);
            SeedBrands(dbContext);

            dbContext.SaveChanges();
        } 
    }
}
