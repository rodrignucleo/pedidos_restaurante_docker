using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json;
using ProjetoGerenciamentoRestaurante.RazorPages.Models;

namespace ProjetoGerenciamentoRestaurante.RazorPages.Pages.Garcon
{
    public class Details : PageModel
    {
        public GarconModel GarconModel { get; set; } = new();

        public Details(){
            
        }

        public async Task<IActionResult> OnGetAsync(int? id){

            if(id == null){
                return NotFound();
            }

            var httpClient = new HttpClient();
            var url = HttpConst.http + $"/Garcon/Details/{id}";
            var requestMessage = new HttpRequestMessage(HttpMethod.Get, url);
            var response = await httpClient.SendAsync(requestMessage);

            if(!response.IsSuccessStatusCode){
                return NotFound();
            }

            var content = await response.Content.ReadAsStringAsync();
            GarconModel = JsonConvert.DeserializeObject<GarconModel>(content)!;
            
            return Page();
        }
    }
}