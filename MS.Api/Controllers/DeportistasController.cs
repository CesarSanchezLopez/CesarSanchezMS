using Microsoft.AspNetCore.Mvc;
using MS.Core.Models;
using MS.Core.Interfaces;
using MS.Api.Interfaces;
using Microsoft.AspNetCore.Authorization;

namespace MS.Api.Controllers
{
    public class DeportistasController : Controller, IDeportistasController
    {
        private IDeportistas _Repo;


        public DeportistasController(IDeportistas pRepo)
        {
            _Repo = pRepo;
        }
        public IActionResult Index()
        {
            return View();
        }

        [Authorize]
        [HttpGet("Deportistas")]
        [Route("api/Deportistas")]
        public async Task<List<Deportista>> Deportistas()
        {
            return await _Repo.Deportistas();
        }

        [HttpGet("DeportistasModalidad")]
        [Route("api/DeportistasModalidad")]
        public async Task<List<Deportista>> DeportistasModalidad()
        {
            return await _Repo.DeportistasModalidad();
        }
    }
}
