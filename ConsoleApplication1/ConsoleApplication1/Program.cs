using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using Castle.Windsor;
using Castle.MicroKernel.Registration;

namespace ConsoleApplication1
{
    class Program
    {
        public static WindsorContainer Container { get; set; }
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
            /*Console.WriteLine("truc");

            Parallel.Invoke(work1, work2);

            Console.WriteLine("finito");*/
            Container = new WindsorContainer();         
            Container.Register(Component.For<IClassA>().ImplementedBy<ClassA>());
            Container.Register(Component.For<IClassB>().ImplementedBy<ClassB>());
            Container.Register(Component.For<IClassC>().ImplementedBy<ClassC>());
            //Optionnel :D
            //Container.Register(Component.For<IClassD>().ImplementedBy<ClassD>());

            var workObj = Container.Resolve<IClassA>();
            workObj.test();
            Console.Read();
        }
    }
}
