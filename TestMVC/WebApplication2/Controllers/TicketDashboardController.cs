using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace WebApplication2.Controllers
{
    public class TicketDashboardController : Controller
    {
        // GET: TicketDashboard
        public ActionResult Index()
        {
            return View();
        }
        
        public ActionResult DisplayMonthlyGraph(int? ANbMonthsBack)
        {
            var cnx = new SqlConnection("");
            DateTime n = DateTime.Now;
            n = n.AddMonths(1).AddDays(-1);

            if (!ANbMonthsBack.HasValue)
                ANbMonthsBack = 0;
            for (int i = 0;i< ANbMonthsBack;i++)
            {
                DateTime debutMois = n.AddMonths(-1).AddDays(1);

                SqlCommand cmd =
                        new SqlCommand($"SELECT COUNT(*) FROM tTickets WHERE Ouvert='Fermé' AND DateFermeture BETWEEN {debutMois.ToString("DD-MM-YYYY")} AND {n.ToString("DD-MM-YYYY")}");                    

                n = n.AddMonths(-1);
            }
            
                        
            return null;
        }

        public ActionResult DisplayDailyGraph(int? ANbDaysBack)
        {
            var cnx = new SqlConnection("");
            DateTime n = DateTime.Now;

            if (!ANbDaysBack.HasValue)
                ANbDaysBack = 0;
            for (int i = 0; i < ANbDaysBack; i++)
            {
                DateTime debutMois = n.AddMonths(-1).AddDays(1);

                SqlCommand cmd =
                        new SqlCommand($"SELECT COUNT(*) FROM tTickets WHERE Ouvert='Fermé' AND DateFermeture BETWEEN {debutMois.ToString("DD-MM-YYYY")} AND {n.ToString("DD-MM-YYYY")} GROUP BY DateFermeture");

                n = n.AddDays(-1);
            }


            return null;
        }
    }
}