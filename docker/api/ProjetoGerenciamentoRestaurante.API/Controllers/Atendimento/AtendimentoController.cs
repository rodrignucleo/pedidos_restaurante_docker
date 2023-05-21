using System;
using System.Globalization;
using ProjetoGerenciamentoRestaurante.API.Models;
using ProjetoGerenciamentoRestaurante.API.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ProjetoGerenciamentoRestaurante.API.Controllers.Atendimento
{
    [ApiController]
    [Route("api/[controller]")]
    public class AtendimentoController : ControllerBase
    {
        public List<AtendimentoModel> AtendimentosList { get; set; } = new();

        [HttpGet]
        [Route("/Atendimento")]
        public IActionResult Get([FromServices] AppDbContext context){
            var atendimentos = context.Atendimento!
                            .Include(m => m.Mesa)
                            .Select(a => new{
                                a.AtendimentoId,
                                a.Mesa,
                                a.MesaId,
                                a.AtendimentoFechado,
                                a.DataCriacao,
                                a.DataSaida
                            }).ToList();

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
            
            foreach(var a in atendimentos){
                AtendimentoModel atendimento = new();

                atendimento.AtendimentoId = atendimento.AtendimentoId;
                atendimento.Mesa = a.Mesa;
                atendimento.MesaId = a.MesaId;
                atendimento.AtendimentoFechado= a.AtendimentoFechado;
                atendimento.DataCriacao = a.DataCriacao;
                atendimento.DataSaida = a.DataSaida;

                foreach (var p in pedidoList){
                    if(p.AtendimentoId == a.AtendimentoId && p is not null){
                        PedidoModel pedido = new();

                        pedido.PedidoId = p.PedidoId;
                        pedido.AtendimentoId = p.AtendimentoId;
                        pedido.Atendimento = p.Atendimento;
                        pedido.GarconId = p.GarconId;
                        pedido.Garcon = p.Garcon;
                        pedido.HorarioPedido = p.HorarioPedido;

                        atendimento.Pedidos.Add(pedido);
                    }
                }
                AtendimentosList.Add(atendimento);
            }
            
            return Ok(AtendimentosList);
        }
        
        [HttpGet("/Atendimento/Details/{id:int}")]
        public IActionResult GetById([FromRoute] int id, 
            [FromServices] AppDbContext context)
        {
            var atendimentoModel = context.Atendimento!.Include(p => p.Mesa).FirstOrDefault(x => x.AtendimentoId == id);
            
            if (atendimentoModel == null){
                return NotFound();
            }
            
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
            
            AtendimentoModel atendimento = new();

            atendimento.AtendimentoId = atendimento.AtendimentoId;
            atendimento.Mesa = atendimentoModel!.Mesa;
            atendimento.MesaId = atendimentoModel.MesaId;
            atendimento.AtendimentoFechado= atendimentoModel.AtendimentoFechado;
            atendimento.DataCriacao = atendimentoModel.DataCriacao;
            atendimento.DataSaida = atendimentoModel.DataSaida;

            foreach (var p in pedidoList){
                if(p.AtendimentoId == atendimentoModel.AtendimentoId && p is not null){
                    PedidoModel pedido = new();

                    pedido.PedidoId = p.PedidoId;
                    pedido.AtendimentoId = p.AtendimentoId;
                    pedido.Atendimento = p.Atendimento;
                    pedido.GarconId = p.GarconId;
                    pedido.Garcon = p.Garcon;
                    pedido.HorarioPedido = p.HorarioPedido;

                    atendimento.Pedidos.Add(pedido);
                }
            }
            
            return Ok(atendimento);
        }

        [HttpPost("/Atendimento/Create")]
        public IActionResult Post([FromBody] AtendimentoModel atendimentoModel,
            [FromServices] AppDbContext context)
        {
            var atendimentoToAdd = context.Mesa!.FirstOrDefault(x => x.MesaId == atendimentoModel.MesaId);

            if (atendimentoToAdd == null) {
                return NotFound();
            }
            if(atendimentoToAdd!.Status == false){
                context.Atendimento!.Add(atendimentoModel);
                // Altera o status da mesa e sua hora de abertura
                atendimentoToAdd.Status = true;
                atendimentoToAdd.HoraAbertura = DateTime.Now.AddHours(1.50);
                atendimentoModel.DataCriacao = DateTime.Now;
                context.SaveChanges();
                return Created($"/{atendimentoModel.AtendimentoId}", atendimentoModel);
            }
            else{
                return RedirectToPage("/Atendimento/Create");
            }
            
        }

        [HttpPut("/Atendimento/Edit/{id:int}")]
        public IActionResult Put([FromRoute] int id, 
            [FromBody] AtendimentoModel atendimentoModel,
            [FromServices] AppDbContext context)
        {   
            var model = context.Atendimento!.Include(p => p.Mesa).FirstOrDefault(x => x.AtendimentoId == id);
            if (model == null) {
                return NotFound();
            }
            var mesaAntigaId = model.MesaId;
            var mesaAntiga = context.Mesa!.FirstOrDefault(x => x.MesaId == atendimentoModel.MesaId);
            mesaAntiga!.Status = true;
            mesaAntiga!.HoraAbertura = DateTime.Now.AddHours(1);
            
            model.MesaId = atendimentoModel.MesaId;
            model.Mesa!.Status = false;
            model.Mesa!.HoraAbertura = null;

            context.Atendimento!.Update(model);

            context.SaveChanges();
            return Ok(model);
        }

        [HttpDelete("/Atendimento/Delete/{id:int}")]
        public IActionResult Delete([FromRoute] int id, 
            [FromServices] AppDbContext context)
        {
            var atendimentoToDelete = context.Atendimento!.Include(p => p.Mesa).FirstOrDefault(x => x.AtendimentoId == id);

            if (atendimentoToDelete == null) {
                return NotFound();
            }

            // Altera o status da mesa e sua hora de abertura
            atendimentoToDelete.Mesa!.Status = false;
            atendimentoToDelete.Mesa.HoraAbertura = null;
            
            context.Atendimento!.Remove(atendimentoToDelete);
            context.SaveChanges();
            
            return Ok(atendimentoToDelete);
        }
    }
}