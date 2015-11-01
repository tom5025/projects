using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WS;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Net;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            TimeEntry a = new TimeEntry { project = "a", prestation = "b", desc = "c" };

            DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(TimeEntry));
            var memStream = new MemoryStream();
            ser.WriteObject(memStream, a);
            string data =
               Encoding.UTF8.GetString(memStream.ToArray(), 0, (int)memStream.Length);
            WebClient webClient = new WebClient();
            webClient.Headers["Content-type"] = "application/json";
            webClient.Encoding = Encoding.UTF8;
            webClient.UploadString("http://localhost:2014/TimeWS.svc/TimeEntry", "POST", data);              
            Console.WriteLine("Order placed successfully...");
        }
    }
}
