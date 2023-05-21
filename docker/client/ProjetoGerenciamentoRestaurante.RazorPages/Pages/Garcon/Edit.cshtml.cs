using System.Text;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json;
using ProjetoGerenciamentoRestaurante.RazorPages.Models;

namespace ProjetoGerenciamentoRestaurante.RazorPages.Pages.Garcon
{
    public class Edit : PageModel
    {

        [BindProperty]
        public GarconModel GarconModel { get; set; } = new();

        public Edit(){
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

        public async Task<IActionResult> OnPostAsync(int id){

            if(!ModelState.IsValid){
                return Page();
            }

            var httpClient = new HttpClient();
            var url = HttpConst.http + $"/Garcon/Edit/{id}";
            var garconJson = JsonConvert.SerializeObject(GarconModel);

            var requestMessage = new HttpRequestMessage(HttpMethod.Put, url);
            requestMessage.Content = new StringContent(garconJson, Encoding.UTF8, "application/json");

            var response = await httpClient.SendAsync(requestMessage);

            if(!response.IsSuccessStatusCode){
                return Page();
            }

            return RedirectToPage("/Garcon/Index");
        }
    }
}