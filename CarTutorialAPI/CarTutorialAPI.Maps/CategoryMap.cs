using CarTutorialAPI.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using CarTutorialAPI.ViewModels;
using CarTutorialAPI.Models;

namespace CarTutorialAPI.Maps
{
    class CategoryMap
    {
        ICategoryRepository service;

        public CategoryMap(ICategoryRepository service)

        {
            service = service;

        }

    
        public List<CategoryViewModel> GetAll()

        {
            return null;
            //return DomainToViewModel(service.GetAll());

        }



        public List<CategoryViewModel> DomainToViewModel(List<Category> domain)

        {
            return null;
            //List<CategoryViewModel> model = new List<UserViewModel>();

            //foreach (Category of in domain)

            //{

            //    model.Add(DomainToViewModel(of));

            //}

            //return model;

        }
    }
}
