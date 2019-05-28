using CarTutorialAPI.Models;
using CarTutorialAPI.Repositories;
using System;
using System.Collections.Generic;

namespace CarTutorialAPI.Services
{
    public class UserService : IUserService

    {

        private IUserRepository repository;

        public UserService(IUserRepository userRepository)

        {

            repository = userRepository;

        }

        public User Create(User domain)

        {

            return repository.Save(domain);

        }

        public bool Update(User domain)

        {

            return repository.Update(domain);

        }

        public bool Delete(int id)

        {

            return repository.Delete(id);

        }

        public List<User> GetAll()

        {

            return repository.GetAll();

        }

    }
}
