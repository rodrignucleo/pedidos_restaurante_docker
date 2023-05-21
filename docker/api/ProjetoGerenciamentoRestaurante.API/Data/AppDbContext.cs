using ProjetoGerenciamentoRestaurante.API.Models;
using Microsoft.EntityFrameworkCore;

namespace ProjetoGerenciamentoRestaurante.API.Data{
    public class AppDbContext : DbContext
    {
        static readonly string connectionString = "host=mysql-container;database=DbRestaurante;user=root;password=12345678";
        public DbSet<GarconModel>? Garcon {get; set;}
        public DbSet<MesaModel>? Mesa {get; set;}
        public DbSet<ProdutoModel>? Produto {get; set;}
        public DbSet<CategoriaModel>? Categoria {get; set;}
        public DbSet<AtendimentoModel>? Atendimento {get; set;}
        public DbSet<PedidoModel>? Pedido {get; set;}
        public DbSet<PedidoProdutoModel>? PedidoProduto {get; set;}

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder){
            optionsBuilder.UseMySql(connectionString,
                                    ServerVersion.AutoDetect(connectionString));
        }
            
        protected override void OnModelCreating(ModelBuilder modelBuilder){
            modelBuilder.Entity<GarconModel>().ToTable("garcon");
            modelBuilder.Entity<MesaModel>().ToTable("mesa");
            modelBuilder.Entity<ProdutoModel>().ToTable("produto");
            modelBuilder.Entity<CategoriaModel>().ToTable("categoria");
            modelBuilder.Entity<AtendimentoModel>().ToTable("atendimento");
            modelBuilder.Entity<PedidoModel>().ToTable("pedido");
            modelBuilder.Entity<PedidoProdutoModel>().ToTable("pedido_produto");
        }
    }
}