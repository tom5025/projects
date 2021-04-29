using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication1
{
    public interface IClassD
    {
        void TestD();
    }
    public class ClassD : IClassD
    {
        public void TestD()
        {
            Console.WriteLine("Hello D");
        }
    }
}
