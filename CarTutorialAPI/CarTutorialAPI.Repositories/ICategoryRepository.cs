using CarTutorialAPI.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace CarTutorialAPI.Repositories
{
    public interface ICategoryRepository
    {
        IEnumerable<Category> GetAll();
    }
}
