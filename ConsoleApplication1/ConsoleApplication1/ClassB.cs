using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication1
{
    public interface IClassB
    {
        void TestB();
    }
    public class ClassB : IClassB
    {
        public void TestB()
        {
            Console.WriteLine("Hello B");
        }
    }
}
