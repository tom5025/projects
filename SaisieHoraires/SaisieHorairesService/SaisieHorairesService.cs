using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.IdentityModel.Selectors;
using DataModel;
using System.Data.Entity;

namespace SaisieHorairesService
{   
    public class CustomUserNameValidator : UserNamePasswordValidator
    {
        [FaultContract(typeof(Exception))]
        public override void Validate(string userName, string password)
        {
            ModelContainer context = new ModelContainer();
            try
            {
                Users entity = (from t
                                in context.UsersSet
                                where (t.Username == userName) &&
                                      (t.Password == password)
                                select t).FirstOrDefault();
            }
            catch (Exception)
            {
                throw new FaultException<Exception>(new Exception("Unknown username or password"));
            }
        }
    }
    
    public class SaisieHorairesService : ISaisieHorairesService
    {
        ModelContainer context = new ModelContainer();

        public TimeEntryDataContract GetTimeEntry(int id)
        {

            if (context == null)
            {
                context = new ModelContainer();
            }

            TimeEntry entity = (from t
                                 in context.TimeEntrySet
                                 where t.Id == id
                                 select t).FirstOrDefault();
            if (entity != null)
            {
                TimeEntryDataContract ret = new TimeEntryDataContract();
                ret.TheDate = entity.TheDate;
                ret.StartTime = entity.StartTime;
                ret.EndTime = entity.EndTime;
                ret.SumTime = 0; //entity.SumTime;
                return ret;
            }                
            else
                throw new Exception("Invalid TimeEntry id");
            
        }

        public void AddNewTimeEntry(DateTime ATheDate, decimal AStartTime, decimal AEndTime)
        {           
            if (context == null)
            {
                context = new ModelContainer();
            }

            TimeEntry newItem = new TimeEntry
            {
                TheDate = ATheDate,
                StartTime = AStartTime,
                EndTime = AEndTime            
            };
            context.TimeEntrySet.Add(newItem);
            context.SaveChanges();            
        }

        public bool TimeEntryExistsForDay(DateTime ATheDate)
        {
            if (context == null)
            {
                context = new ModelContainer();
            }

            try
            {
                    
                TimeEntry res = (from t
                                    in context.TimeEntrySet
                                 where (DbFunctions.TruncateTime(t.TheDate) == DbFunctions.TruncateTime(ATheDate.Date))
                                 select t).First();
                return (res != null);
            }
            catch(Exception)
            {
                return false;
            }
        }

        public List<TimeEntryDataContract> GetEntries(DateTime AFromDate, DateTime AToDate)
        {
            if (context == null)
            {
                context = new ModelContainer();
            }

            List<TimeEntryDataContract> resList = new List<TimeEntryDataContract>();         

            List<TimeEntry> efList = new List<TimeEntry>(from t in context.TimeEntrySet 
                                                         where DbFunctions.TruncateTime(t.TheDate) >= DbFunctions.TruncateTime(AFromDate) &&
                                                               DbFunctions.TruncateTime(t.TheDate) <= DbFunctions.TruncateTime(AToDate)
                                                         orderby t.TheDate
                                                         select t);

            foreach (TimeEntry cur in efList)
            {
                TimeEntryDataContract newItem = new TimeEntryDataContract();
                newItem.TheDate = cur.TheDate;
                newItem.StartTime = cur.StartTime;
                newItem.EndTime = cur.EndTime;
                newItem.SumTime = 0;//cur.SumTime;
                resList.Add(newItem);
            }

            return resList;
        }

    }
}
