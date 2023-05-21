using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjetoGerenciamentoRestaurante.API.Models
{
    public class PedidoProdutoModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int PedidoProdutoId { get; set; }

        [ForeignKey("Pedido")]
        public int PedidoId { get; set; }
        public PedidoModel? Pedido { get; set; }

        [ForeignKey("Produto")]
        public int ProdutoId { get; set; }
        public ProdutoModel? Produto { get; set; }
        public double Quantidade { get; set; }
    }
}