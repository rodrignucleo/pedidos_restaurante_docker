using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjetoGerenciamentoRestaurante.API.Models
{
    public class AtendimentoModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int AtendimentoId { get; set; }

        [ForeignKey("Mesa")]
        public int MesaId { get; set; }
        public MesaModel? Mesa { get; set; }
        public bool AtendimentoFechado { get; set; }

        public DateTime? DataCriacao { get; set; }
        public DateTime? DataSaida { get; set; }

        public List<PedidoModel>? Pedidos { get; set; }

    }
}