using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json;
using ProjetoGerenciamentoRestaurante.RazorPages.Models;


namespace ProjetoGerenciamentoRestaurante.RazorPages.Pages
{
    public class Index : PageModel
    {
        public List<PedidoViewModel>PedidoViewList { get; set; } = new();
        
        public Index(){}
       
        public async Task<IActionResult> OnGetAsync(){
            var httpClient = new HttpClient();
            var url = HttpConst.http + "/PedidoView";
            var requestMessage = new HttpRequestMessage(HttpMethod.Get, url);
            var response = await httpClient.SendAsync(requestMessage);
            var content = await response.Content.ReadAsStringAsync();

            PedidoViewList = JsonConvert.DeserializeObject<List<PedidoViewModel>>(content)!;
            return Page();
        }

    }
}