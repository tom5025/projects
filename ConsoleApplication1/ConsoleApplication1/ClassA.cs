using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication1
{
    public interface IClassA
    {
        void test();
    }

    public class ClassA : IClassA
    {
        protected IClassB ClassB { get; set; }
        protected IClassC ClassC { get; set; }
        public IClassD ClassD { get; set; } //optional !
        public ClassA(IClassB classB, IClassC classC)
        {
            ClassB = classB;
            ClassC = classC;
        }

        public void test()
        {
            ClassB.TestB();
            ClassC.TestC();
            if (ClassD != null)
                ClassD.TestD();
        }

    }
}
