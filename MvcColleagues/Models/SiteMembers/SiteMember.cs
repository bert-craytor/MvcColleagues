using System;
using System.Collections.Generic;
using System.Linq;

namespace MvcColleagues.Models.SiteMembers
{
    public class SiteMember
    {
     
        public virtual int SharedColleaguesCount { get; set; }
        public virtual Guid Id { get; set; }
        public virtual int Uid { get; set; }
        public virtual string FullName { get; set; }
        public virtual string Company { get; set; }
        public virtual string JobTitle { get; set; }
        public virtual string Location { get; set; }
        public virtual int? LevelId { get; set; }
        public virtual int? FunctionId { get; set; }
        public virtual int? IndustryId { get; set; }
        public virtual DateTime? JoinDate { get; set; }

        // work fields
       // public virtual List<int> SharedColleagues { get; set; }
        public virtual List<int> GetSharedColleagues(IList<Colleague> colleagues, int uid1, int uid2)
        {
            SharedColleaguesCount = 0;
            IEnumerable<int> uid1Colleagues = from c in colleagues where c.Uid1 == uid1 select c.Uid2;
            IEnumerable<int> uid2Colleagues = from c in colleagues where c.Uid1 == uid2 select c.Uid2;
            var sharedColleagues = uid1Colleagues.Intersect(uid2Colleagues).ToList();
            SharedColleaguesCount = sharedColleagues.Count();
            return sharedColleagues;
        }
    }
}