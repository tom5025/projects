using CarTutorialAPI.Models;
using System.Collections.Generic;

namespace CarTutorialAPI.Repositories
{
    public interface IUserRepository
    {
        User Save(User domain);
        bool Update(User domain);
        bool Delete(int id);
        List<User> GetAll();
    }
}