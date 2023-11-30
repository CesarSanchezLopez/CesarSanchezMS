namespace MS.Api.Interfaces
{
        public interface IAuthService
        {
            public bool ValidateLogin(string username, string password);
            string GenerateToken(DateTime fechaActual, string username, TimeSpan tiempoValidez);
        }
}
