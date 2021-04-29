﻿using CarTutorialAPI.Models;
using CarTutorialAPI.Services;
using CarTutorialAPI.ViewModels;
using System;
using System.Collections.Generic;

namespace CarTutorialAPI.Maps
{
    public class UserMap : IUserMap
    {
        IUserService userService;

        public UserMap(IUserService service)

        {

            userService = service;

        }

        public UserViewModel Create(UserViewModel viewModel)

        {

            User user = ViewModelToDomain(viewModel);

            return DomainToViewModel(userService.Create(user));

        }

        public bool Update(UserViewModel viewModel)

        {

            User user = ViewModelToDomain(viewModel);

            return userService.Update(user);

        }

        public bool Delete(int id)

        {

            return userService.Delete(id);

        }

        public List<UserViewModel> GetAll()

        {

            return DomainToViewModel(userService.GetAll());

        }

        public UserViewModel DomainToViewModel(User domain)

        {

            UserViewModel model = new UserViewModel();

            model.name = domain.Name;

            return model;

        }

        public List<UserViewModel> DomainToViewModel(List<User> domain)

        {

            List<UserViewModel> model = new List<UserViewModel>();

            foreach (User of in domain)

            {

                model.Add(DomainToViewModel(of));

            }

            return model;

        }

        public User ViewModelToDomain(UserViewModel officeViewModel)

        {

            User domain = new User();

            domain.Name = officeViewModel.name;

            return domain;

        }
    }
}
