using System.Globalization;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjetoGerenciamentoRestaurante.RazorPages.Models
{
    public class MesaModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int MesaId { get; set; }

        [Required(ErrorMessage = "Número é obrigatório!")]
        public int Numero { get; set; }

        [Required(ErrorMessage = "Status é obrigatório!")]
        public bool Status { get; set; }
        
        public DateTime? HoraAbertura { get; set; }
        // { 
        //     get { return this.HoraAbertura; } 
        //     set => SetHoraAbertura(value);
        // }

        // public DateTime? GetHoraAbertura(){
        //     if(HoraAbertura != null){
        //         return DateTime.ParseExact(HoraAbertura.ToString(), "yyyy-MM-dd HH:mm:ss", null);
        //     }

        //     return null;
        // }

        // public void SetHoraAbertura(DateTime? horaAbertura){
            
        //     if (horaAbertura != null)
        //     {
        //         this.HoraAbertura = DateTime.Parse(horaAbertura.Value.ToString("yyyy-MM-ddTHH:mm:ss"));
        //     }
        //     else{
        //         // DateTime a = DateTime.Now;

        //         this.HoraAbertura = horaAbertura;
        //     }
        //     // HoraAbertura = horaAbertura;
            
            
        // }
    }
}