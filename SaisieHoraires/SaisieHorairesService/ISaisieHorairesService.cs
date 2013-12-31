using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace SaisieHorairesService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface ISaisieHorairesService
    {
        [OperationContract]
        TimeEntryDataContract GetTimeEntry(int id);
        [OperationContract]
        void AddNewTimeEntry(DateTime ATheDate, decimal AStartTime, decimal AEndTime);
        [OperationContract]
        bool TimeEntryExistsForDay(DateTime ATheDate);
        [OperationContract]
        List<TimeEntryDataContract> GetEntries(DateTime AFromDate, DateTime AToDate);
    }    
    
    // Use a data contract as illustrated in the sample below to add composite types to service operations.
    // You can add XSD files into the project. After building the project, you can directly use the data types defined there, with the namespace "SaisieHorairesService.ContractType".
    [DataContract]
    public class TimeEntryDataContract
    {
        [DataMember(Order=1)]
        public DateTime TheDate { get;set;}
        [DataMember(Order=2)]
        public decimal StartTime{ get;set;}
        [DataMember(Order=3)]
        public decimal EndTime{ get;set;}
        [DataMember(Order = 4)]
        public decimal SumTime { get; set; }
    }
}
