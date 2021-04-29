using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication1
{
    public interface IClassC
    {
        void TestC();
    }
    public class ClassC : IClassC
    {
        public void TestC()
        {
            Console.WriteLine("Hello C");
        }
    }
}
