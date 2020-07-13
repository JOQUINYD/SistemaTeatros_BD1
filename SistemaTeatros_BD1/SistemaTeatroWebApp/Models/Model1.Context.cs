﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SistemaTeatroWebApp.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class SistemaTeatros_BD1Entities : DbContext
    {
        public SistemaTeatros_BD1Entities()
            : base("name=SistemaTeatros_BD1Entities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<C__RefactorLog> C__RefactorLog { get; set; }
        public virtual DbSet<Accesos> Accesos { get; set; }
        public virtual DbSet<Bloques> Bloques { get; set; }
        public virtual DbSet<BoletoCompras> BoletoCompras { get; set; }
        public virtual DbSet<BoletoComprasFilas> BoletoComprasFilas { get; set; }
        public virtual DbSet<Filas> Filas { get; set; }
        public virtual DbSet<Personas> Personas { get; set; }
        public virtual DbSet<Precios> Precios { get; set; }
        public virtual DbSet<Presentaciones> Presentaciones { get; set; }
        public virtual DbSet<Producciones> Producciones { get; set; }
        public virtual DbSet<ProduccionEstados> ProduccionEstados { get; set; }
        public virtual DbSet<ProduccionesTipos> ProduccionesTipos { get; set; }
        public virtual DbSet<sysdiagrams> sysdiagrams { get; set; }
        public virtual DbSet<Teatros> Teatros { get; set; }
        public virtual DbSet<Usuarios> Usuarios { get; set; }
    
        public virtual ObjectResult<spGetMatchingUser_Result> spGetMatchingUser(string usuario, string password)
        {
            var usuarioParameter = usuario != null ?
                new ObjectParameter("Usuario", usuario) :
                new ObjectParameter("Usuario", typeof(string));
    
            var passwordParameter = password != null ?
                new ObjectParameter("Password", password) :
                new ObjectParameter("Password", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spGetMatchingUser_Result>("spGetMatchingUser", usuarioParameter, passwordParameter);
        }
    }
}