using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FluentNHibernate.Mapping;
using MvcColleagues.Models;
using MvcColleagues.Models.SiteMembers;

namespace MvcColleagues.Mappings
{
    public class ColleagueMap : ClassMap<Colleague>
    {
        public ColleagueMap()
        {
            Table("Colleague");
            Id(d => d.Id).GeneratedBy.GuidComb();
            Map(d => d.Uid1).Not.Nullable();
            Map(d => d.Uid2).Not.Nullable();
          
        }
    }
}