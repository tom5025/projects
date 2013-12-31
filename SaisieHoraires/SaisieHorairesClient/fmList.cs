using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using SaisieHorairesClient.SaisieHorairesServiceRef;
using CommonSaisieHoraires;
using System.Globalization;

namespace SaisieHorairesClient
{
    public partial class fmList : Form
    {
        public fmList()
        {
            InitializeComponent();
        }

        private void fmList_Load(object sender, EventArgs e)
        {
            dtpFrom.Value = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
            dtpTo.Value = new DateTime(DateTime.Today.Year, 
                                        DateTime.Today.Month, 
                                        DateTime.DaysInMonth(DateTime.Today.Year, DateTime.Today.Month));
                       
        }

        private void DisplayTotalHours()
        {
            decimal tot = 0;
            foreach(DataGridViewRow cur in dataGridView1.Rows)
            {
                decimal curval = 0;
                decimal.TryParse(cur.Cells[3].Value.ToString(), out curval);
                tot += SaisieHorairesTools.SexagToDec(curval);
            }
            tbTotalHours.Text = SaisieHorairesTools.DecToSexag(tot).ToString();
            tbTotalHours.Text = tbTotalHours.Text.Replace(CultureInfo.CurrentUICulture.NumberFormat.NumberDecimalSeparator, ":");
        }

        private void btDisplay_Click(object sender, EventArgs e)
        {
            SaisieHorairesServiceClient svc = new SaisieHorairesServiceClient();
            dataGridView1.DataSource = svc.GetEntries(dtpFrom.Value, dtpTo.Value);

            dataGridView1.Columns[0].HeaderText = "Date";
            dataGridView1.Columns[1].HeaderText = "Heure de début";
            dataGridView1.Columns[2].HeaderText = "Heure de fin";
            dataGridView1.Columns[3].HeaderText = "Heures";                        

            DisplayTotalHours();            
        }
    }
}
