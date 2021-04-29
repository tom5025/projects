using CarTutorialAPI.Models.Context;

namespace CarTutorialAPI.Repositories
{
    public class BaseRepository
    {        
        public BaseRepository(IApplicationContext context)          
        {
            Context = context;
        }

        protected IApplicationContext Context { get; }
    }
}