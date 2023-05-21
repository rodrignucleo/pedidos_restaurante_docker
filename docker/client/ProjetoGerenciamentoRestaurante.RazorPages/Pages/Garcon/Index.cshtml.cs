using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json;
using ProjetoGerenciamentoRestaurante.RazorPages.Models;

namespace ProjetoGerenciamentoRestaurante.RazorPages.Pages.Garcon
{
    public class Index : PageModel
    {

        public List<GarconModel> GarconList { get; set; } = new();

        public Index(){

        }

        public async Task<IActionResult> OnGetAsync(){
            var httpClient = new HttpClient();
            var url = HttpConst.http + "/Garcon";
            var requestMessage = new HttpRequestMessage(HttpMethod.Get, url);
            var response = await httpClient.SendAsync(requestMessage);
            var content = await response.Content.ReadAsStringAsync();

            GarconList = JsonConvert.DeserializeObject<List<GarconModel>>(content)!;
            
            return Page();
        }
    }
}