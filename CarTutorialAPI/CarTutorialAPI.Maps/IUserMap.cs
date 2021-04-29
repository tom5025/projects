using CarTutorialAPI.ViewModels;
using System.Collections.Generic;

namespace CarTutorialAPI.Maps
{
    public interface IUserMap
    {
        UserViewModel Create(UserViewModel viewModel);
        bool Update(UserViewModel viewModel);
        bool Delete(int id);
        List<UserViewModel> GetAll();
    }
}