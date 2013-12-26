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
using System.Globalization;

namespace SaisieHorairesClient
{
    public partial class fmMain : Form
    {
        public fmMain()
        {
            InitializeComponent();
        }


        private decimal TimeToDec(decimal inValue)
        {
            //1.30 -> 1.00
            decimal hourPart = decimal.Truncate(inValue);
            //1.30 -> 0.30
            decimal decPart = inValue - hourPart;

            decPart = ((decPart * 100) * 60 / 100) / 100;

            return hourPart + decPart;
        } 


        private void btAdd_Click(object sender, EventArgs e)
        {
            btAdd.Enabled = false;
            try
            {
                if (tbStartTime.Text == "")
                {
                    MessageBox.Show("Heure de début/Temps total obligatoire", "Erreur", 
                                    MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
                    

                string sStartTime = tbStartTime.Text;
                string sEndTime = tbEndTime.Text;


                sStartTime = sStartTime.Replace(":", CultureInfo.CurrentUICulture.NumberFormat.NumberDecimalSeparator);
                sEndTime = sEndTime.Replace(":", CultureInfo.CurrentUICulture.NumberFormat.NumberDecimalSeparator);                



                SaisieHorairesServiceClient cli = new SaisieHorairesServiceClient();

                if (cli.TimeEntryExistsForDay(DateTime.Today))
                {
                    if (MessageBox.Show("Une entrée existe déjà pour ce jour, voulez-vous néanmoins ajouter une entrée supplémentaire ?",
                                        "Question",
                                        MessageBoxButtons.YesNo,
                                        MessageBoxIcon.Question) == DialogResult.No)
                    {
                        return;
                    }                        
                }

                decimal valEndTime, valStartTime;
                decimal.TryParse(sStartTime, out valStartTime);
                decimal.TryParse(sEndTime, out valEndTime);

                /*valEndTime = TimeToDec(valEndTime);
                valStartTime = TimeToDec(valStartTime);*/

                cli.AddNewTimeEntry(dtpTheDate.Value, valStartTime, valEndTime);
                MessageBox.Show("Entrée ajoutée avec succès.");
            }
            finally
            {
                btAdd.Enabled = true;
            }
        }

        private void tbStartTime_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsDigit(e.KeyChar) && !(e.KeyChar == ':')  
                && !(e.KeyChar == 0x8))
            {
                e.Handled = true;
            }
        }

        private void listeDesSaisiesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form1 newFm = new Form1();
            newFm.Show(this);

        }
    }
}
