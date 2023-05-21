using ProjetoGerenciamentoRestaurante.API.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjetoGerenciamentoRestaurante.API.Models;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace ProjetoGerenciamentoRestaurante.API.Controllers.Pedido
{
    [ApiController]
    [Route("api/[controller]")]
    
    public class PedidoViewController : ControllerBase
    {
        public List<PedidoViewModel>pedidoViewList { get; set; } = new ();

        [HttpGet]
        [Route("/PedidoView")]

        public IActionResult Get([FromServices] AppDbContext context){
            var pedidoList = context.Pedido!
                            .Include(g => g.Garcon)
                            .Include(a => a.Atendimento)
                            .Include(m => m.Atendimento!.Mesa)
                            .Select(p => new{
                                p.PedidoId,
                                p.AtendimentoId,
                                p.Atendimento,
                                p.GarconId,
                                p.Garcon,
                                p.HorarioPedido
                            })
                            .ToList();
            var pedidoProdutoList = context.PedidoProduto!
                            .Include(p => p.Pedido)
                            .Include(x => x.Produto)
                            .Select(h => new{
                                h.PedidoProdutoId,
                                h.PedidoId,
                                h.Pedido,
                                h.ProdutoId,
                                h.Produto,
                                h.Quantidade
                            })
                            .ToList();
            var garconList = context.Garcon!.ToList();

            foreach (var g in garconList){
                PedidoViewModel pedido = new();
                pedido.Garcon = g;
                pedidoViewList.Add(pedido);
            }

            foreach (var p in pedidoList){
                foreach (var v in pedidoViewList) {
                    if(p.GarconId == v.Garcon!.GarconId){
                        v.countPedidos += 1;
                    }
                }
            }

            foreach (var p in pedidoProdutoList){
                foreach (var v in pedidoViewList){
                    if(p.Pedido!.GarconId == v.Garcon!.GarconId){
                        var total = p.Produto!.Preco * p.Quantidade;
                        v.totalVendas += total;
                        v.quantidadeTotal += p.Quantidade;
                    }
                }
            }

            // var options = new JsonSerializerOptions
            // {
            //     ReferenceHandler = ReferenceHandler.Preserve,
            //     MaxDepth = 32
            // };

            // var jsonString = JsonSerializer.Serialize(pedidoViewList, options);

            // return Content(jsonString, "application/json");
            return Ok(pedidoViewList);
        }
    }
}