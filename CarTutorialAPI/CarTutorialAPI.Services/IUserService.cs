using CarTutorialAPI.Models;
using System.Collections.Generic;

namespace CarTutorialAPI.Services
{
    public interface IUserService
    {
        User Create(User domain);
        bool Delete(int id);
        bool Update(User domain);
        List<User> GetAll();
    }
}