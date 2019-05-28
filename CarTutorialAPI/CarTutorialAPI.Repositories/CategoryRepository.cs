using System;
using System.Collections.Generic;
using System.Text;
using CarTutorialAPI.Models;
using CarTutorialAPI.Models.Context;
using System.Linq;

namespace CarTutorialAPI.Repositories
{
    public class CategoryRepository : BaseRepository, ICategoryRepository
    {
        CategoryRepository(IApplicationContext ctx) : base(ctx) { }
        public IEnumerable<Category> GetAll()
        {
            return Context.Categories.OrderBy(x => x.Name);
        }
    }
}
