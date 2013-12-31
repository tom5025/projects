using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConsoleApplication1
{
    class POI
    {
        public int id;
        public string name;
        public string address;
        public string tel;
        public double longitude;
        public double latitude;
    }

    
    class Program
    {
        static List<POI> POIList;

        static void EUR_StoreIt(string AValue)
        {
            string[] split = AValue.Split(';');
            
                POI newOne = new POI();
                newOne.id = Convert.ToInt32(split[0]);
                newOne.name = split[1];
                newOne.address = split[2];
                newOne.tel = split[3];
                newOne.longitude = Convert.ToDouble(split[4]);
                newOne.latitude = Convert.ToDouble(split[5]);

                POIList.Add(newOne);
        }

        static double DegreeToRadian(double angle)
        {
            return Math.PI * angle / 180.0;
        }

        static double EUR_GetDistanceBetween(POI A, POI B)
        {
            double x = (DegreeToRadian(B.longitude) - DegreeToRadian(A.longitude)) * (Math.Cos(DegreeToRadian(A.latitude) + DegreeToRadian(B.latitude)) / 2);
            double y = (DegreeToRadian(B.latitude) - DegreeToRadian(A.latitude));
            return (Math.Sqrt(Math.Pow(x, 2) + Math.Pow(y, 2)) * 6371);
        }

        static void Main(string[] args)
        {
            double inputLongitude = Convert.ToDouble(Console.ReadLine());
            double inputLatitude = Convert.ToDouble(Console.ReadLine());
            int n = Convert.ToInt32(Console.ReadLine());
            
            POIList = new List<POI>();

            //store informations
            for (int i = 0; i < n; i++)
            {
                EUR_StoreIt(Console.ReadLine());    
            }

            //calculer la distance 
            double lastDistance = -1;
            POI thePOI = null;
            foreach (POI item in POIList)
            {
                POI userPOI = new POI();
                userPOI.latitude = inputLatitude;
                userPOI.longitude = inputLongitude;

                double curDist = EUR_GetDistanceBetween(userPOI, item);
                if ( (curDist < lastDistance) || (lastDistance == -1) )
                {
                    lastDistance = curDist;
                    thePOI = item;
                }
            }

            if (thePOI != null)
            {
                Console.WriteLine(thePOI.name);
            }
            else
            {
                Console.WriteLine("Rien trouvé");
            }
        }
    }
}
