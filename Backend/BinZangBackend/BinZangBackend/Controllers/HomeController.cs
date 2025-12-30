using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BinZangBackend.Models;
using System.Web.Security;
using System.Configuration;

namespace BinZangBackend.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Main/
        [Authorize]
        public ActionResult Index()
        {
            ViewData["level1nav"]="Home";
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["t1"] = "首页";
            ViewData["t2"] = "";
            ViewData["t3"] = "";
            return View();
        }

    }
}
