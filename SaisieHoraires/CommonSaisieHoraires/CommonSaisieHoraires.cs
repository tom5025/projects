using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommonSaisieHoraires
{
    public class SaisieHorairesTools
    {
        public static decimal DecToSexag(decimal inValue)
        {
            //1.30 -> 1.00
            decimal hourPart = decimal.Truncate(inValue);
            //1.30 -> 0.30
            decimal decPart = inValue - hourPart;
            
            //50 en décimal * 60 / 100 = 30 minutes
            decPart = ((decPart * 100) * 60 / 100) / 100;

            return hourPart + decPart;
        }

        public static decimal SexagToDec(decimal inValue)
        {
            //1.30 -> 1.00
            decimal hourPart = decimal.Truncate(inValue);
            //1.30 -> 0.30
            decimal decPart = inValue - hourPart;

            //30 minutes * 100 / 60 = 50 en décimal
            decPart = ((decPart * 100) * 100 / 60) / 100;

            return hourPart + decPart;
        }
    }
}
