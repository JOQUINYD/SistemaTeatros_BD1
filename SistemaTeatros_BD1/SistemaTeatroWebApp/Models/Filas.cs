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
    
    public partial class Filas
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Filas()
        {
            this.Boletos = new HashSet<Boletos>();
        }
    
        public string Letra { get; set; }
        public int NumAsientos { get; set; }
        public int IdBloque { get; set; }
    
        public virtual Bloques Bloques { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Boletos> Boletos { get; set; }
    }
}
