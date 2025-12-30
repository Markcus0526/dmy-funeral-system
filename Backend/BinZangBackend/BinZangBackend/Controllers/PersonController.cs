using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BinZangBackend.Controllers
{
    public class PersonController : Controller
    {
        //
        // GET: /Person/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Staff()
        {
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "Staff";
            return View();
        }
    }
}
