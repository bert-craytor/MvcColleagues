using Castle.MicroKernel.Registration;
using Castle.MicroKernel.SubSystems.Configuration;
using Castle.Windsor;
using MvcColleagues.Models.SiteMembers;
using MvcColleagues.Repositories;

namespace MvcColleagues.Windsor
{
    public class RepositoriesInstaller : IWindsorInstaller
    {
        public void Install(IWindsorContainer container, IConfigurationStore store)
        {
            container.Register(Classes.FromThisAssembly()
                                      .Where(Component.IsInSameNamespaceAs<Repository<SiteMember>>())
                                      .WithService.DefaultInterfaces()
                                      .LifestyleTransient());
        }
    }
}