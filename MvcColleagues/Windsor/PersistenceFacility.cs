using System.Reflection;
using Castle.MicroKernel;
using Castle.MicroKernel.Facilities;
using Castle.MicroKernel.Registration;
using FluentNHibernate.Automapping;
using FluentNHibernate.Cfg;
using FluentNHibernate.Cfg.Db;
using FluentNHibernate.Conventions.Helpers;
using NHibernate;
using NHibernate.Cfg;
using NHibernate.Context;
using NHibernate.Tool.hbm2ddl;

namespace MvcColleagues.Windsor
{
    public class PersistenceFacility : AbstractFacility
    {
        /// <summary>
        /// Initializes facility
        /// </summary>
        protected override void Init()
        {
            Kernel.Register(
                Component.For<ISessionFactory>()
                         .UsingFactoryMethod(CreateSessionFactory),
                Component.For<ISession>()
                         .UsingFactoryMethod(OpenSession)
                         .LifestylePerWebRequest());
        }
       
        /// <summary>
        /// Creates a session
        /// </summary>
        /// <param name="kernel"></param>
        /// <returns></returns>
        private static ISession OpenSession(IKernel kernel)
        {
            return kernel.Resolve<ISessionFactory>().OpenSession();
        }

        /// <summary>
        /// Creates and returns a session factory
        /// </summary>
        /// <returns></returns>
        private static ISessionFactory CreateSessionFactory()
        {
            return Fluently.Configure()
                           .Database(CreateDbConfig)
                           .Mappings(m => m.AutoMappings.Add(CreateMappings()))
                           .ExposeConfiguration(UpdateSchema)
                           .CurrentSessionContext<WebSessionContext>()
                           .BuildSessionFactory();
        }

   
        /// <summary>
        /// Returns the connection configuration
        /// </summary>
        /// <returns></returns>
        private static MsSqlConfiguration CreateDbConfig()
        {
            return MsSqlConfiguration
                .MsSql2008
                .ConnectionString(c => c.FromConnectionStringWithKey("colleaguesConn"));
        }

        /// <summary>
        /// Creates and returns mappings
        /// </summary>
        /// <returns></returns>
        private static AutoPersistenceModel CreateMappings()
        {
            return AutoMap
                .Assembly(Assembly.GetCallingAssembly())
                .Where(t => t.Namespace != null && t.Namespace.EndsWith("SiteMembers"))
                .Conventions.Setup(c => c.Add(DefaultCascade.SaveUpdate()));
        }

      
        /// <summary>
        /// Updates the database schema if there are any changes to the model,
        /// or drops and creates it if it doesn't exist
        /// </summary>
        /// <param name="cfg"></param>
        private static void UpdateSchema(Configuration cfg)
        {
            new SchemaUpdate(cfg)
                .Execute(false, true);
        }
    }
}