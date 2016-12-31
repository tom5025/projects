using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;

namespace ConsoleApplication1
{
    class Program
    {
        static void work1()
        {
            Console.WriteLine("truc1");
            Thread.Sleep(10000);
            Console.WriteLine("truc2");
        }

        static void work2()
        {
            Console.WriteLine("work 2 begin");
            Thread.Sleep(5000);
            Console.WriteLine("work 2 end");
        }

        static void Main(string[] args)
        {
            Console.WriteLine("truc");

            Parallel.Invoke(work1, work2);

            Console.WriteLine("finito");
        }
    }
}
