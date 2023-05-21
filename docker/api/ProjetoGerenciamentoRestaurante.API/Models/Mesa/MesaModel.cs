using System.Globalization;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjetoGerenciamentoRestaurante.API.Models
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
        
        public DateTime? HoraAbertura { 
            get => HoraAbertura; 
            set => SetHoraAbertura(value);
        }

        public DateTime? GetHoraAbertura(){
            if(HoraAbertura != null){
                return DateTime.ParseExact(HoraAbertura.ToString(), "yyyy-MM-dd HH:mm:ss", null);
            }

            return null;
        }

        public void SetHoraAbertura(DateTime? horaAbertura){
            
            // if (horaAbertura != null)
            // {
            //     HoraAbertura = DateTime.Parse(horaAbertura.ToString());
            // }
            // else{
            //     HoraAbertura = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture));
            // }
            HoraAbertura = horaAbertura;
            
            
        }
    }
}