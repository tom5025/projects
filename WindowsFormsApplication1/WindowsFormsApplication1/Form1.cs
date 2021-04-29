using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }


        public class WEURFormulas
        {
            List<IWEURFormula> list;
            IEnumerable<IWEURFormula> GatherFormulasFromCell(ref string cellSt)
            {                
                foreach (var x in this.list)
                {
                    if (x.GatherFormulaFromCell(ref cellSt))
                    {
                        yield return x;
                    }
                }

            }

            public delegate void machin(string s1);
            public event machin truc;
            public event EventHandler<MouseEventArgs> a;
        }

        public interface IWEURFormula
        {
            string GetFormulaName();
            bool GatherFormulaFromCell(ref string cellSt);
        }

        public class WEURFormula : IWEURFormula
        {
            public string GetFormulaName()
            {
                return "WINEURGLBALANCE";
            }

            public bool GatherFormulaFromCell(ref string cellSt)
            {
                if (cellSt.Contains(GetFormulaName()))
                {                    
                    string theFormula = cellSt.Substring(cellSt.IndexOf(GetFormulaName() + $"{GetFormulaName().Length + 1}"),
                                                         cellSt.Length);
                    theFormula = cellSt.Substring(1, cellSt.IndexOf(")")-1);
                }
                return false;
            }
        }
         
        private void button1_Click(object sender, EventArgs e)
        {

            string st = "=-WINEURGLBALANCE()+WINEURGETBUDGET()+WINEURGLBALANCE()";

        }
    }
}
