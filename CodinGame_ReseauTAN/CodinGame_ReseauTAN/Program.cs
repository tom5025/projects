using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConsoleApplication1
{
    public class StopItem
    {
        //infos
        public string id;
        public string name;
        public string desc;
        public double latitude;
        public double longitude;
        public string idzone;
        public string stopurl;
        public string stoptype;
        public string parentstation;

        public StopItem()
        {
            flag = false;
            weight = -1;
            predecessor = null;
            vertex = new List<Vertex>();
        }

        //algorithm
        public StopItem predecessor;
        public List<Vertex> vertex;
        public double weight;
        public bool flag;
    }

    public class Vertex
    {
        public StopItem dest;
        public double weight;
    }

    public class StopList : List<StopItem>
    {
        static double DegreeToRadian(double angle)
        {
            return Math.PI * angle / 180.0;
        }

        static double GetDistanceBetween(StopItem A, StopItem B)
        {
            double x = (DegreeToRadian(B.longitude) - DegreeToRadian(A.longitude)) * (Math.Cos(DegreeToRadian(A.latitude) + DegreeToRadian(B.latitude)) / 2);
            double y = (DegreeToRadian(B.latitude) - DegreeToRadian(A.latitude));
            return (Math.Sqrt(Math.Pow(x, 2) + Math.Pow(y, 2)) * 6371);
        }

        public StopItem FindStopFromID(string stopID)
        {
            for (int i = 0; i < Count; i++)
            {
                if (this[i].id == stopID)
                {
                    return this[i];                    
                }
            }
            return null;
        }

        public int StoreStop(string line)
        {
            char [] charstotrim = {'"'};

            string[] split = line.Split(',');

            StopItem newItem = new StopItem();
            newItem.id = split[0].Split(':')[1];
            newItem.name = split[1].Trim(charstotrim);
            newItem.desc = split[2];
            newItem.latitude = Convert.ToDouble(split[3]);
            newItem.longitude = Convert.ToDouble(split[4]);
            newItem.idzone = split[5];
            newItem.stopurl = split[6];
            newItem.stoptype = split[7];
            newItem.parentstation = split[8];

            this.Add(newItem);
            return (this.Count - 1);
        }

        public void StoreLink(string line)
        {
            //find the source stop
            string [] split = line.Split(' ');
            string [] sourceSplit = split[0].Split(':');
            string [] destSplit = split[1].Split(':');

            StopItem sourceItem = FindStopFromID(sourceSplit[1]);
            StopItem destItem = FindStopFromID(destSplit[1]);
            sourceItem.vertex.Add(new Vertex() { dest = destItem, weight = GetDistanceBetween(sourceItem, destItem) } );
        }
    }

    class Program
    {
        static void DFS(StopItem curStopItem, StopItem destItem)
        {
            if (curStopItem != destItem)
                curStopItem.flag = true;

            foreach (Vertex curVertex in curStopItem.vertex)
            {                
                if (!curVertex.dest.flag)
                {
                    if ((curVertex.dest.weight > curStopItem.weight + curVertex.weight) ||
                         (curVertex.dest.weight == -1))
                    {
                        curVertex.dest.weight = curStopItem.weight + curVertex.weight;
                        curVertex.dest.predecessor = curStopItem;
                    }
                    DFS(curVertex.dest, destItem);
                }                
            }

        }

        static void Main(string[] args)
        {
            StopList stopList = new StopList();

            string start = Console.ReadLine().Split(':')[1];
            string stop = Console.ReadLine().Split(':')[1];

            //read stops from console input
            int stopCount = Convert.ToInt32(Console.ReadLine());
            for (int i = 0; i < stopCount; i++)
            {
                stopList.StoreStop(Console.ReadLine());        
            }

            //read stop links from console input
            int lkCount = Convert.ToInt32(Console.ReadLine());
            for (int i = 0; i < lkCount; i++)
            {
                stopList.StoreLink(Console.ReadLine());
            }

            //compute the shortest path
            StopItem startItem = stopList.FindStopFromID(start);
            startItem.weight = 0;
            StopItem destItem = stopList.FindStopFromID(stop);
            DFS(startItem, destItem);            
            if (destItem.predecessor == null)
            {
                Console.WriteLine("IMPOSSIBLE");
            }                                  
            else
            {                
                List<string> shortestPath = new List<string>();
                StopItem curItem = destItem;
                while (curItem != null)
                {
                    int insertIndex = shortestPath.Count == 0 ? 0 : shortestPath.Count - 1;

                    shortestPath.Insert(insertIndex, curItem.name);
                    curItem = curItem.predecessor;
                }

                foreach (string curSt in shortestPath)
                {
                    Console.WriteLine(curSt);
                }
            }            
        }
    }
}
