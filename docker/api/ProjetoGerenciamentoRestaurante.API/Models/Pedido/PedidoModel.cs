using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace ProjetoGerenciamentoRestaurante.API.Models
{
    public class PedidoModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int PedidoId { get; set; }

        [ForeignKey("Atendimento")]
        public int AtendimentoId { get; set; }
        public AtendimentoModel? Atendimento { get; set; }

        [ForeignKey("Garcon")]
        public int GarconId { get; set; }
        public GarconModel? Garcon { get; set; }
        
        public DateTime HorarioPedido;

        public List<ProdutoModel>? Produtos;

        public DateTime GetHorarioPedido(){
            return HorarioPedido;
        }
        public void SetHorarioPedido(string horarioPedido){
            HorarioPedido =  DateTime.ParseExact(horarioPedido, "HH:mm:ss", null);
        }
    }
}