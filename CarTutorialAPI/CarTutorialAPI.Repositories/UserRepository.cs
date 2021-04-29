using CarTutorialAPI.Models;
using CarTutorialAPI.Models.Context;
using System;
using System.Collections.Generic;
using System.Linq;

namespace CarTutorialAPI.Repositories
{
    public class UserRepository : BaseRepository, IUserRepository

    {

        public UserRepository(IApplicationContext context)

            : base(context)

        { }

        public User Save(User domain)

        {

            try

            {


                var us = Context.UsersDB.Add(domain);
                Context.SaveChanges();

                return us.Entity;
            }

            catch (Exception ex)

            {

                //ErrorManager.ErrorHandler.HandleError(ex);

                throw ex;

            }

        }

        public bool Update(User domain)

        {

            try

            {
                

                Context.UsersDB.Update(domain);
                Context.SaveChanges();

                return true;

            }

            catch (Exception ex)

            {

                //ErrorManager.ErrorHandler.HandleError(ex);

                throw ex;

            }

        }

        public bool Delete(int id)

        {

            try

            {

                User user = Context.UsersDB.Where(x => x.Id.Equals(id)).FirstOrDefault();



                if (user != null)

                {

                    Context.UsersDB.Remove(user);
                    Context.SaveChanges();

                    return true;

                }

                else

                {

                    return false;

                }

            }

            catch (Exception ex)

            {

                //ErrorManager.ErrorHandler.HandleError(ex);

                throw ex;

            }

        }

        public List<User> GetAll()

        {

            try

            {

                return Context.UsersDB.OrderBy(x => x.Name).ToList();

            }

            catch (Exception ex)

            {

                //ErrorManager.ErrorHandler.HandleError(ex);

                throw ex;

            }

        }

    }
}
