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
    
    public partial class Bloques
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Bloques()
        {
            this.Filas = new HashSet<Filas>();
            this.Precios = new HashSet<Precios>();
        }
    
        public int Id { get; set; }
        public string NombreBloque { get; set; }
        public int IdTeatro { get; set; }
    
        public virtual Teatros Teatros { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Filas> Filas { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Precios> Precios { get; set; }
    }
}
