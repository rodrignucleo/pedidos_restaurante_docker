using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System;


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
        
        public TimeOnly HorarioPedido { get; set; }

        public List<ProdutoModel>? Produtos;

        // public TimeOnly GetHorarioPedido(){
        //     return HorarioPedido;
        // }
        // public void SetHorarioPedido(string horarioPedido){
        //     HorarioPedido =  DateTime.ParseExact(horarioPedido, "HH:mm:ss", null);
        // }
    }
}