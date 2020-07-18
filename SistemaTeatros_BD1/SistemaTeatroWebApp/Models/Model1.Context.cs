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
        public virtual DbSet<sysdiagrams> sysdiagrams { get; set; }
        public virtual DbSet<Teatros> Teatros { get; set; }
        public virtual DbSet<Usuarios> Usuarios { get; set; }
    
        public virtual int spAddPersonaAndUsuario(string nombre, Nullable<System.DateTime> fechaNac, Nullable<long> cedula, string direccion, Nullable<long> telefonoCelular, Nullable<long> telefonoCasa, Nullable<long> telefonoOtro, string email, Nullable<int> idTeatro, string sexo, string usuario, string password, Nullable<int> idAcceso)
        {
            var nombreParameter = nombre != null ?
                new ObjectParameter("Nombre", nombre) :
                new ObjectParameter("Nombre", typeof(string));
    
            var fechaNacParameter = fechaNac.HasValue ?
                new ObjectParameter("FechaNac", fechaNac) :
                new ObjectParameter("FechaNac", typeof(System.DateTime));
    
            var cedulaParameter = cedula.HasValue ?
                new ObjectParameter("Cedula", cedula) :
                new ObjectParameter("Cedula", typeof(long));
    
            var direccionParameter = direccion != null ?
                new ObjectParameter("Direccion", direccion) :
                new ObjectParameter("Direccion", typeof(string));
    
            var telefonoCelularParameter = telefonoCelular.HasValue ?
                new ObjectParameter("TelefonoCelular", telefonoCelular) :
                new ObjectParameter("TelefonoCelular", typeof(long));
    
            var telefonoCasaParameter = telefonoCasa.HasValue ?
                new ObjectParameter("TelefonoCasa", telefonoCasa) :
                new ObjectParameter("TelefonoCasa", typeof(long));
    
            var telefonoOtroParameter = telefonoOtro.HasValue ?
                new ObjectParameter("TelefonoOtro", telefonoOtro) :
                new ObjectParameter("TelefonoOtro", typeof(long));
    
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            var idTeatroParameter = idTeatro.HasValue ?
                new ObjectParameter("IdTeatro", idTeatro) :
                new ObjectParameter("IdTeatro", typeof(int));
    
            var sexoParameter = sexo != null ?
                new ObjectParameter("Sexo", sexo) :
                new ObjectParameter("Sexo", typeof(string));
    
            var usuarioParameter = usuario != null ?
                new ObjectParameter("Usuario", usuario) :
                new ObjectParameter("Usuario", typeof(string));
    
            var passwordParameter = password != null ?
                new ObjectParameter("Password", password) :
                new ObjectParameter("Password", typeof(string));
    
            var idAccesoParameter = idAcceso.HasValue ?
                new ObjectParameter("IdAcceso", idAcceso) :
                new ObjectParameter("IdAcceso", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spAddPersonaAndUsuario", nombreParameter, fechaNacParameter, cedulaParameter, direccionParameter, telefonoCelularParameter, telefonoCasaParameter, telefonoOtroParameter, emailParameter, idTeatroParameter, sexoParameter, usuarioParameter, passwordParameter, idAccesoParameter);
        }
    
        public virtual int spAddPresentacion(Nullable<System.DateTime> fecha, Nullable<System.TimeSpan> hora, Nullable<int> idProduccion)
        {
            var fechaParameter = fecha.HasValue ?
                new ObjectParameter("Fecha", fecha) :
                new ObjectParameter("Fecha", typeof(System.DateTime));
    
            var horaParameter = hora.HasValue ?
                new ObjectParameter("Hora", hora) :
                new ObjectParameter("Hora", typeof(System.TimeSpan));
    
            var idProduccionParameter = idProduccion.HasValue ?
                new ObjectParameter("IdProduccion", idProduccion) :
                new ObjectParameter("IdProduccion", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spAddPresentacion", fechaParameter, horaParameter, idProduccionParameter);
        }
    
        public virtual int spAddProduccion(string nombre, string descripcion, string tipo, Nullable<System.DateTime> fecha_Init, Nullable<System.DateTime> feccha_Fin, Nullable<int> iD_Teatro)
        {
            var nombreParameter = nombre != null ?
                new ObjectParameter("Nombre", nombre) :
                new ObjectParameter("Nombre", typeof(string));
    
            var descripcionParameter = descripcion != null ?
                new ObjectParameter("Descripcion", descripcion) :
                new ObjectParameter("Descripcion", typeof(string));
    
            var tipoParameter = tipo != null ?
                new ObjectParameter("Tipo", tipo) :
                new ObjectParameter("Tipo", typeof(string));
    
            var fecha_InitParameter = fecha_Init.HasValue ?
                new ObjectParameter("Fecha_Init", fecha_Init) :
                new ObjectParameter("Fecha_Init", typeof(System.DateTime));
    
            var feccha_FinParameter = feccha_Fin.HasValue ?
                new ObjectParameter("Feccha_Fin", feccha_Fin) :
                new ObjectParameter("Feccha_Fin", typeof(System.DateTime));
    
            var iD_TeatroParameter = iD_Teatro.HasValue ?
                new ObjectParameter("ID_Teatro", iD_Teatro) :
                new ObjectParameter("ID_Teatro", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spAddProduccion", nombreParameter, descripcionParameter, tipoParameter, fecha_InitParameter, feccha_FinParameter, iD_TeatroParameter);
        }
    
        public virtual int spAddTeatro(string nombre, Nullable<int> boleteria, string email, string sitioWeb, Nullable<int> telefono)
        {
            var nombreParameter = nombre != null ?
                new ObjectParameter("Nombre", nombre) :
                new ObjectParameter("Nombre", typeof(string));
    
            var boleteriaParameter = boleteria.HasValue ?
                new ObjectParameter("Boleteria", boleteria) :
                new ObjectParameter("Boleteria", typeof(int));
    
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            var sitioWebParameter = sitioWeb != null ?
                new ObjectParameter("SitioWeb", sitioWeb) :
                new ObjectParameter("SitioWeb", typeof(string));
    
            var telefonoParameter = telefono.HasValue ?
                new ObjectParameter("Telefono", telefono) :
                new ObjectParameter("Telefono", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spAddTeatro", nombreParameter, boleteriaParameter, emailParameter, sitioWebParameter, telefonoParameter);
        }
    
        public virtual int spCambiarEstadoProduccion(Nullable<int> id_Estado, Nullable<int> id_Produccion)
        {
            var id_EstadoParameter = id_Estado.HasValue ?
                new ObjectParameter("Id_Estado", id_Estado) :
                new ObjectParameter("Id_Estado", typeof(int));
    
            var id_ProduccionParameter = id_Produccion.HasValue ?
                new ObjectParameter("Id_Produccion", id_Produccion) :
                new ObjectParameter("Id_Produccion", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spCambiarEstadoProduccion", id_EstadoParameter, id_ProduccionParameter);
        }
    
        public virtual int spDefinirPrecioBloqueParaProduccion(Nullable<int> id_Bloque, Nullable<int> id_Produccion, Nullable<decimal> precio)
        {
            var id_BloqueParameter = id_Bloque.HasValue ?
                new ObjectParameter("Id_Bloque", id_Bloque) :
                new ObjectParameter("Id_Bloque", typeof(int));
    
            var id_ProduccionParameter = id_Produccion.HasValue ?
                new ObjectParameter("Id_Produccion", id_Produccion) :
                new ObjectParameter("Id_Produccion", typeof(int));
    
            var precioParameter = precio.HasValue ?
                new ObjectParameter("Precio", precio) :
                new ObjectParameter("Precio", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spDefinirPrecioBloqueParaProduccion", id_BloqueParameter, id_ProduccionParameter, precioParameter);
        }
    
        public virtual ObjectResult<Nullable<int>> spGetIdTeatroFromUsuario(string usuario)
        {
            var usuarioParameter = usuario != null ?
                new ObjectParameter("Usuario", usuario) :
                new ObjectParameter("Usuario", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<int>>("spGetIdTeatroFromUsuario", usuarioParameter);
        }
    
        public virtual ObjectResult<spGetMatchingUser_Result> spGetMatchingUser(string usuario)
        {
            var usuarioParameter = usuario != null ?
                new ObjectParameter("Usuario", usuario) :
                new ObjectParameter("Usuario", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spGetMatchingUser_Result>("spGetMatchingUser", usuarioParameter);
        }
    
        public virtual ObjectResult<spGetPresentacionesByProduccion_Result> spGetPresentacionesByProduccion(Nullable<int> idProduccion)
        {
            var idProduccionParameter = idProduccion.HasValue ?
                new ObjectParameter("IdProduccion", idProduccion) :
                new ObjectParameter("IdProduccion", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spGetPresentacionesByProduccion_Result>("spGetPresentacionesByProduccion", idProduccionParameter);
        }
    
        public virtual ObjectResult<spGetPresentacionesRangoFechas_Result> spGetPresentacionesRangoFechas(Nullable<System.DateTime> fecha_Inicio, Nullable<System.DateTime> fecha_Final)
        {
            var fecha_InicioParameter = fecha_Inicio.HasValue ?
                new ObjectParameter("Fecha_Inicio", fecha_Inicio) :
                new ObjectParameter("Fecha_Inicio", typeof(System.DateTime));
    
            var fecha_FinalParameter = fecha_Final.HasValue ?
                new ObjectParameter("Fecha_Final", fecha_Final) :
                new ObjectParameter("Fecha_Final", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spGetPresentacionesRangoFechas_Result>("spGetPresentacionesRangoFechas", fecha_InicioParameter, fecha_FinalParameter);
        }
    
        public virtual ObjectResult<spGetProduccionById_Result> spGetProduccionById(Nullable<int> idProduccion)
        {
            var idProduccionParameter = idProduccion.HasValue ?
                new ObjectParameter("IdProduccion", idProduccion) :
                new ObjectParameter("IdProduccion", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spGetProduccionById_Result>("spGetProduccionById", idProduccionParameter);
        }
    
        public virtual ObjectResult<spGetProduccionesByTeatro_Result> spGetProduccionesByTeatro(Nullable<int> idTeatro)
        {
            var idTeatroParameter = idTeatro.HasValue ?
                new ObjectParameter("IdTeatro", idTeatro) :
                new ObjectParameter("IdTeatro", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spGetProduccionesByTeatro_Result>("spGetProduccionesByTeatro", idTeatroParameter);
        }
    
        public virtual ObjectResult<spGetBloqueByTeatro_Result> spGetBloqueByTeatro(Nullable<int> idTeatro)
        {
            var idTeatroParameter = idTeatro.HasValue ?
                new ObjectParameter("IdTeatro", idTeatro) :
                new ObjectParameter("IdTeatro", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spGetBloqueByTeatro_Result>("spGetBloqueByTeatro", idTeatroParameter);
        }
    
        public virtual ObjectResult<spGetFilasByBloque_Result> spGetFilasByBloque(Nullable<int> idBloque)
        {
            var idBloqueParameter = idBloque.HasValue ?
                new ObjectParameter("IdBloque", idBloque) :
                new ObjectParameter("IdBloque", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spGetFilasByBloque_Result>("spGetFilasByBloque", idBloqueParameter);
        }
    
        public virtual ObjectResult<spGetTeatroById_Result> spGetTeatroById(Nullable<int> idTeatro)
        {
            var idTeatroParameter = idTeatro.HasValue ?
                new ObjectParameter("IdTeatro", idTeatro) :
                new ObjectParameter("IdTeatro", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spGetTeatroById_Result>("spGetTeatroById", idTeatroParameter);
        }
    
        public virtual ObjectResult<spGetTeatros_Result> spGetTeatros()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spGetTeatros_Result>("spGetTeatros");
        }
    
        public virtual int spAddBloque(string nombreBloque, Nullable<int> idTeatro)
        {
            var nombreBloqueParameter = nombreBloque != null ?
                new ObjectParameter("NombreBloque", nombreBloque) :
                new ObjectParameter("NombreBloque", typeof(string));
    
            var idTeatroParameter = idTeatro.HasValue ?
                new ObjectParameter("IdTeatro", idTeatro) :
                new ObjectParameter("IdTeatro", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spAddBloque", nombreBloqueParameter, idTeatroParameter);
        }
    }
}
