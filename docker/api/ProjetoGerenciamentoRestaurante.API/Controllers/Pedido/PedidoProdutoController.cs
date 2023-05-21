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
    public class PedidoProdutoController : ControllerBase
    {
        [HttpGet]
        [Route("/PedidoProduto/{id:int}")]
        public IActionResult Get([FromRoute] int id, [FromServices] AppDbContext context){
            var pedidoProdutos = context.PedidoProduto!
                .Include(p => p.Pedido)
                    .ThenInclude(p => p!.Garcon)
                .Include(p => p.Pedido)
                    .ThenInclude(p => p!.Atendimento)
                        .ThenInclude(a => a!.Mesa)
                .Include(p => p.Produto)
                .Select(p => new{
                    p.PedidoProdutoId,
                    p.PedidoId,
                    p.Pedido,
                    p.ProdutoId,
                    p.Produto,
                    p.Quantidade
                })
                .Where(e => e.Pedido!.Atendimento!.AtendimentoId  == id)
                .ToList();

            // return Ok(pedidoProdutos);
            var options = new JsonSerializerOptions
            {
                ReferenceHandler = ReferenceHandler.Preserve,
                MaxDepth = 32
            };

            var jsonString = JsonSerializer.Serialize(pedidoProdutos, options);

            return Content(jsonString, "application/json");
        }

        private static DateTime? ParseTime(string? timeString)
        {
            if (timeString != null)
            {
                return DateTime.ParseExact(timeString, "HH:mm:ss", null);
            }
            return null;
        }

        [HttpPut("/PedidoProduto/Edit/{id:int}")]
        public IActionResult Put([FromRoute] int id, 
            [FromBody] AtendimentoModel atendimentoModel,
            [FromServices] AppDbContext context)
        {
            var model = context.Atendimento!.Include(p => p.Mesa).FirstOrDefault(x => x.AtendimentoId == id);

            if (model == null) {
                return NotFound();
            }
            if(model.Mesa!.Status && model.MesaId != model.Mesa.MesaId){
                return RedirectToPage("/Atendimento/Details/"+id);
            }
            else{
                if(model.AtendimentoFechado){
                    model.DataSaida = null;
                    model.AtendimentoFechado = false;
                    model.Mesa!.Status = true;
                    model.Mesa.HoraAbertura = DateTime.Now.AddHours(1);
                }
                else{
                    model.DataSaida = DateTime.Now;
                    model.AtendimentoFechado = true;
                    model.Mesa!.Status = false;
                    model.Mesa!.HoraAbertura = null;
                }
                
                context.Atendimento!.Update(model);
                context.SaveChanges();
                
                return Ok(model);
            }
        }

        [HttpPost("/Pedido/Create")]
        public IActionResult Post([FromBody] PedidoModel pedidoModel,
            [FromServices] AppDbContext context)
        {
            context.Pedido!.Add(pedidoModel);
            context.SaveChanges();
            return Created($"/{pedidoModel.PedidoId}", pedidoModel);
        }

        [HttpPost("/PedidoProduto/Create/{id:int}")]
        public IActionResult Post([FromRoute] int id, [FromBody] PedidoProdutoModel pedidoProdutoModel,
            [FromServices] AppDbContext context)
        {
            pedidoProdutoModel.PedidoId = id;
            context.PedidoProduto!.Add(pedidoProdutoModel);
            context.SaveChanges();
            return Created($"/{pedidoProdutoModel.PedidoProdutoId}", pedidoProdutoModel);
        }
    }
}