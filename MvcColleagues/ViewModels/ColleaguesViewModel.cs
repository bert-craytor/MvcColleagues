/* Author:  Bert Craytor
 * Date:    July 2013
 * Purpose: Demo Program based on Inteview Exercise
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MvcColleagues.Models.SiteMembers;

namespace MvcColleagues.ViewModels
{
    public class ColleaguesViewModel
    {
        public List<Colleague> Colleagues { get; set; }  
        public List<SiteMember> SiteMembers { get; set; } 
        private int _start=0;
        private int _pageSize = 10;

     
        void AddColleagues(int me, List<Colleague> colleagues)
        {
            //_colleagues = from colleague in colleagues where colleague.Uid1.Equals(me)  ;
        }

        //void AddSiteMembers(List<SiteMember> siteMembers, List<Colleague> )
        //{
        //   // _siteMembers = siteMembers;
        //}
    }
}