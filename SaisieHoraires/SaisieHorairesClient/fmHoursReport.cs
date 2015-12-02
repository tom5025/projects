using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;
using System.Data.SqlClient;
using Microsoft.Reporting.WinForms;
using SaisieHorairesClient.SaisieHorairesServiceRef;


namespace SaisieHorairesClient
{
    public partial class fmHoursReport : Form
    {
        public fmHoursReport()
        {
            InitializeComponent();
        }

        private void Form2_Load(object sender, EventArgs e)
        {                       
            SaisieHorairesServiceClient cli = new SaisieHorairesServiceClient();

            //reportViewer1.ProcessingMode = ProcessingMode.Local;
            foreach (TimeEntryDataContract a in cli.GetEntries(DateTime.Parse("01/01/2015"), DateTime.Parse("31/12/2015")))
              TimeEntryDataContractBindingSource.Add(a);            

            /* ReportDataSource datasource = new ReportDataSource("TimeEntries", 
                                                     );
             reportViewer1.LocalReport.DataSources.Clear();
             reportViewer1.LocalReport.DataSources.Add(datasource);            */
            this.reportViewer1.RefreshReport();
            /* ReportViewer1.ProcessingMode = ProcessingMode.Local;
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Report.rdlc");
        Customers dsCustomers = GetData("select top 20 * from customers");
        ReportDataSource datasource = new ReportDataSource("Customers", dsCustomers.Tables[0]);
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(datasource);*/           
        }
    }
}
