using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using MvcColleagues.Models.SiteMembers;
using NHibernate;
using NHibernate.Criterion;
using NHibernate.Linq;

namespace MvcColleagues.Repositories
{
    public class SiteMemberRepository : Repository<SiteMember>
    {

        public SiteMemberRepository() {}

        public SiteMemberRepository(ISession session)
        {
            this._session = session;
        }

        public override IQueryable<SiteMember> GetAll()
        {
            return _session.Query<SiteMember>();
        }


        public IList<SiteMember> GetSuggestedColleagues(List<Colleague> colleagues)
        {
            var potentialColleagues = from c in colleagues where c.Uid2 != MvcApplication.IAmMember select c.Uid2;

            var uid1Colleagues = (from c in colleagues where c.Uid1 == MvcApplication.IAmMember select c.Uid2);
            var notColleagues = potentialColleagues.Except(uid1Colleagues);

            var members = _session.CreateCriteria<SiteMember>()
                                   .Add(Restrictions.Eq("Uid", MvcApplication.IAmMember))
                                   .List<SiteMember>();

            var myRecord = members[0];

            members = _session.CreateCriteria<SiteMember>()
                                .Add(Restrictions.In("Uid", notColleagues.ToList()))
                                .AddOrder(Order.Asc("LevelId"))
                                .AddOrder(Order.Asc("FunctionId"))
                                .AddOrder(Order.Asc("IndustryId"))
                                .List<SiteMember>();

            List<SiteMember> suggestedColleagues = new List<SiteMember>();

           
            int offsetMult = 1;

            // Find all colleagues with equal Level ID, Funditon ID and Industry ID
            // The webpage will contain a “Suggested Colleagues” module which renders up to seven members 
            // according to the following filtering and ranking criteria
            // 1.  Not your Colleague yet.
            // 2.  Those with the same <level_id> as yours, if there is a tie, then same <function_id>, then same <industry_id>. 
            //     (Note: for example, if two members have same <level_id> and <function_id> as yours, but both have 
            //     different <industry_id> as yours, they are considered equivalent in ranking) [BTW the latter as a stated requirement doesn't make any sense ... Bert
            // 3.  Those with <level_id> exactly one above you, if applicable. Note level=4 is above level=3. If there is a 
            //     tie, then same <function_id>, then same <industry_id> (similar note as #2).
            // 4.  Those with <level_id> exactly one below you, if there is a tie, then same <function_id>, then same <industry_id> (same note as #2).
            // 5.  Those with <level_id> exactly two above you, … (similar note as #2)
            // 6.  Those with <level_id> exactly two below you, … (similar note as #2)
            // 7.  -- and so on, until seven members are filled.
           
            for (int offset = 0; offset < 100; offset++)
            {
                if (members.Count == 0)
                    break;

                for (int alt = 0; alt < 2; alt++)
                {
                    if (members.Count == 0)
                        break;

                    if (alt == 0)
                        alt++;
                    else
                    {
                        // look for levels 1 above then 1 below, 2 above, 2 below ...
                        offset = offset*offsetMult;
                        offsetMult *= -1;
                    }

                    foreach (var member in members)
                    {
                        if (member.LevelId != myRecord.LevelId + offset)
                            continue; // skip  lower level

                        if (member.FunctionId == myRecord.FunctionId && member.IndustryId == myRecord.IndustryId)
                        {
                            suggestedColleagues.Add(member);
                            if (suggestedColleagues.Count == 7)
                                return suggestedColleagues;
                            members.Remove(member);
                            continue;
                        }
                        if (member.FunctionId == myRecord.FunctionId  )
                        {
                            suggestedColleagues.Add(member);
                            if (suggestedColleagues.Count == 7)
                                return suggestedColleagues;
                            members.Remove(member);
                            continue;
                        }

                        suggestedColleagues.Add(member);
                        if (suggestedColleagues.Count == 7)
                            return suggestedColleagues;
                        members.Remove(member);
                    }
                }
            }
         


            return suggestedColleagues;
        }


     public IList<SiteMember> GetSharedColleagues(int uid, IList<Colleague> colleagues)
        {
            var member = new SiteMember();
            List<int> sharedColleagueUids = member.GetSharedColleagues(colleagues, MvcApplication.IAmMember, uid );
           
            var criteria = _session.CreateCriteria<SiteMember>()
                                   .Add(Restrictions.In("Uid", sharedColleagueUids));

            var items = criteria.List<SiteMember>();


          
            return items;
        }

   
        public IList<SiteMember> GetPage(int start, int pageSize , IList<Colleague> colleagues )
        {
            if (colleagues.Count == 0)
                return new List<SiteMember>();

            var criteria = _session.CreateCriteria<SiteMember>()
                                .SetFirstResult(start)
                                .SetMaxResults(pageSize);

            var items = criteria.List<SiteMember>();
           

            foreach (var item in items)
            {

                item.GetSharedColleagues(colleagues, MvcApplication.IAmMember, item.Uid);
            }
            return items;
        }
    }
}