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
    
    public partial class Teatros
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Teatros()
        {
            this.Bloques = new HashSet<Bloques>();
            this.Personas = new HashSet<Personas>();
            this.Producciones = new HashSet<Producciones>();
        }
    
        public int Id { get; set; }
        public string Nombre { get; set; }
        public int Boleteria { get; set; }
        public string Email { get; set; }
        public string SitioWeb { get; set; }
        public int Telefono { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Bloques> Bloques { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Personas> Personas { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Producciones> Producciones { get; set; }
    }
}
