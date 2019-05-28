using CarTutorialAPI.Maps;
using CarTutorialAPI.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CarTutorialAPI.Web.API.App_Start
{
    public class DBInitializeConfig

    {

        private IUserMap userMap;

        public DBInitializeConfig(IUserMap _userMap)

        {

            userMap = _userMap;

        }

        public void DataTest()

        {

            Users();

        }

        private void Users()

        {

            userMap.Create(new UserViewModel() { id = 1, name = "Pablo" });

            userMap.Create(new UserViewModel() { id = 2, name = "Diego" });

        }

    }
}
