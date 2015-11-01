﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Ce code a été généré par un outil.
//     Version du runtime :4.0.30319.42000
//
//     Les modifications apportées à ce fichier peuvent provoquer un comportement incorrect et seront perdues si
//     le code est régénéré.
// </auto-generated>
//------------------------------------------------------------------------------



[System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
[System.ServiceModel.ServiceContractAttribute(ConfigurationName="ITimeWS")]
public interface ITimeWS
{
    
    [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/ITimeWS/AddTimeEntry", ReplyAction="http://tempuri.org/ITimeWS/AddTimeEntryResponse")]
    void AddTimeEntry(string project, string prestation, string desc);
    
    [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/ITimeWS/AddTimeEntry", ReplyAction="http://tempuri.org/ITimeWS/AddTimeEntryResponse")]
    System.Threading.Tasks.Task AddTimeEntryAsync(string project, string prestation, string desc);
}

[System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
public interface ITimeWSChannel : ITimeWS, System.ServiceModel.IClientChannel
{
}

[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
public partial class TimeWSClient : System.ServiceModel.ClientBase<ITimeWS>, ITimeWS
{
    
    public TimeWSClient()
    {
    }
    
    public TimeWSClient(string endpointConfigurationName) : 
            base(endpointConfigurationName)
    {
    }
    
    public TimeWSClient(string endpointConfigurationName, string remoteAddress) : 
            base(endpointConfigurationName, remoteAddress)
    {
    }
    
    public TimeWSClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
            base(endpointConfigurationName, remoteAddress)
    {
    }
    
    public TimeWSClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
            base(binding, remoteAddress)
    {
    }
    
    public void AddTimeEntry(string project, string prestation, string desc)
    {
        base.Channel.AddTimeEntry(project, prestation, desc);
    }
    
    public System.Threading.Tasks.Task AddTimeEntryAsync(string project, string prestation, string desc)
    {
        return base.Channel.AddTimeEntryAsync(project, prestation, desc);
    }
}
