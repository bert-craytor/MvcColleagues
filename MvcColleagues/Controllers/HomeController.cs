using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using System.Xml;
using System.Xml.Linq;
using MvcColleagues.Models.SiteMembers;
using MvcColleagues.Repositories;
using MvcColleagues.Views;

namespace MvcColleagues.Controllers
{
    public class HomeController : Controller
    {
        private readonly string ColleaguesFileName = Path.Combine(AppDomain.CurrentDomain.BaseDirectory,
                                                                  @"Data\colleagues.xml");

        private readonly string MembersFileName = Path.Combine(AppDomain.CurrentDomain.BaseDirectory,
                                                               @"Data\members.xml");

        private readonly IRepository<Colleague> _colleagueRepository;
        private readonly List<Colleague> _colleagues;
        private readonly SiteMemberRepository _siteMemberRepository;

        private int PageSize = 5;

        public HomeController(SiteMemberRepository siteMemberRepository, IRepository<Colleague> colleagueRepository)
        {
            _siteMemberRepository = siteMemberRepository;
            _colleagueRepository = colleagueRepository;
            _colleagues = _colleagueRepository.GetAll().ToList();
        }

        public ActionResult SuggestedColleagues(int uid)
        {
            // var members = _siteMemberRepository.GetPage(page+1, 5);
            var memberPage = new PagedData<SiteMember>();
            memberPage.CurrentPage = uid;
            memberPage.Data = _siteMemberRepository.GetSuggestedColleagues(_colleagues);

            return PartialView(memberPage);
        }

        public ActionResult SharedColleagues(int uid)
        {
            // var members = _siteMemberRepository.GetPage(page+1, 5);
            var memberPage = new PagedData<SiteMember>();
            memberPage.CurrentPage = uid;
            memberPage.Data = _siteMemberRepository.GetSharedColleagues(uid, _colleagues);

            return PartialView(memberPage);
        }

        public ActionResult MemberPage(int page, int pageSize = 5)
        {
            // var members = _siteMemberRepository.GetPage(page+1, 5);
            var memberPage = new PagedData<SiteMember>();
            page += pageSize;


            memberPage.Data = _siteMemberRepository.GetPage(page, Math.Abs(PageSize), _colleagues);

            if (memberPage.Data.Count < 1)
            {
                page -= pageSize;
                memberPage.Data = _siteMemberRepository.GetPage(page, pageSize, _colleagues);
            }


            memberPage.CurrentPage = page;


            return PartialView(memberPage);
        }

        public ActionResult Index()
        {
            var memberPage = new PagedData<SiteMember>();


            memberPage.Data = _siteMemberRepository.GetPage(1, PageSize, _colleagues);

            if (memberPage.Data == null || !memberPage.Data.Any())
            {
                // _siteMemberRepository.Rollback();

                var errInfo =
                    new HandleErrorInfo(new ApplicationException("There are no members.  Try going to /Home/Seed."),
                                        "Home", "Index");
                return View("Error", model: errInfo);
            }

            memberPage.CurrentPage = 1;

            try
            {
                return View(memberPage);
            }
            catch (Exception e)
            {
                //_siteMemberRepository.Rollback();
                var errInfo = new HandleErrorInfo(e, "Home", "Index");
                return View("Error", model: errInfo);
            }
        }


        // Adds sample data to our database
        public ActionResult Seed()
        {
            XmlReader f1 = XmlReader.Create(ColleaguesFileName);
            XmlReader f2 = XmlReader.Create(MembersFileName);

            XDocument colleagues = XDocument.Load(f1);
            XDocument members = XDocument.Load(f2);


            f1.Close();
            f2.Close();

            try
            {
                LoadMembers(members);
                LoadColleagues(colleagues);
                return RedirectToAction("Index");
            }
            catch (Exception e)
            {
                var errInfo =
                    new HandleErrorInfo(new ApplicationException("An error occurred while loading initial data."),
                                        "Home", "Index");

                return View("Error", model: errInfo);
            }
        }


        private static void QueryColleagues(XDocument doc)
        {
            // Do a simple query and print the results to the console
            var data = from colleague in doc.Descendants("colleague")
                       select new
                           {
                               uid1 = colleague.Element("uid1").Value,
                               uid2 = colleague.Element("uid2").Value,
                           };
            foreach (var p in data)
                Console.WriteLine(p.ToString());

            // Do a more complex query and print the results to the console
            IEnumerable<IGrouping<string, string>> memberColleagues = from colleague in doc.Descendants("colleague")
                                                                      group colleague.Element("uid2").Value
                                                                          by colleague.Element("uid1").Value
                                                                      into memberColleague
                                                                      select memberColleague;

            foreach (var group in memberColleagues)
                Console.WriteLine("Member {0} has {1} colleagues",
                                  group.Key, group.Distinct().Count());
        }

        private void LoadMembers(XDocument doc)
        {
            // Do a simple query and print the results to the console
            IEnumerable<XElement> members = doc.Descendants("member");
            _siteMemberRepository.BeginTransaction();

            foreach (XElement member in members)
            {
                int? uid = ParseInt(member.Element("uid"));

                if (uid == null)
                    continue; // there must be a uid


                var newMember =
                    new SiteMember
                        {
                            Uid = uid.Value,
                            FullName = ParseString(member.Element("full_name")),
                            Company = ParseString(member.Element("company")),
                            LevelId = ParseInt(member.Element("level_id")),
                            JobTitle = ParseString(member.Element("job_title")),
                            Location = ParseString(member.Element("location")),
                            IndustryId = ParseInt(member.Element("industry_id")),
                            JoinDate = ParseDate(member.Element("join_date"))
                        };

                _siteMemberRepository.SaveOrUpdate(newMember);
            }

            _siteMemberRepository.Commit();
        }

        private void LoadColleagues(XDocument doc)
        {
            // Do a simple query and print the results to the console
            IEnumerable<XElement> colleagues = doc.Descendants("colleague");

            _colleagueRepository.BeginTransaction();

            foreach (XElement colleague in colleagues)
            {
                int? uid = ParseInt(colleague.Element("uid1"));

                if (uid == null)
                    continue; // there must be a uid


                var newColleague =
                    new Colleague
                        {
                            Uid1 = uid.Value,
                            Uid2 = ParseInt(colleague.Element("uid2")) ?? 0
                        };

                _colleagueRepository.SaveOrUpdate(newColleague);
            }

            _colleagueRepository.Commit();
        }

        private static DateTime? ParseDate(XElement inVal)
        {
            DateTime outVal;

            if (inVal == null)
                return null;

            if (inVal != null && DateTime.TryParse(inVal.Value, out outVal))
                return outVal;

            return null;
        }

        private static string ParseString(XElement inVal)
        {
            int outVal;

            if (inVal == null)
                return "";

            return inVal.Value;

            return null;
        }

        private static int? ParseInt(XElement inVal)
        {
            int outVal;

            if (inVal == null)
                return null;

            if (Int32.TryParse(inVal.Value, out outVal))
                return outVal;

            return null;
        }


        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}