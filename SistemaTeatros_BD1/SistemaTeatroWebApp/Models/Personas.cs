//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Personas
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Personas()
        {
            this.Usuarios = new HashSet<Usuarios>();
        }
    
        public string Nombre { get; set; }
        public System.DateTime FechaNac { get; set; }
        public long Cedula { get; set; }
        public string Direccion { get; set; }
        public Nullable<long> TelefonoCelular { get; set; }
        public Nullable<long> TelefonoCasa { get; set; }
        public Nullable<long> TelefonoOtro { get; set; }
        public string Email { get; set; }
        public Nullable<int> IdTeatro { get; set; }
        public string Sexo { get; set; }
    
        public virtual Teatros Teatros { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Usuarios> Usuarios { get; set; }
    }
}
