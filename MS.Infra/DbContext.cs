using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;

namespace MS.Infra
{
    public class DbContext
    {
        private readonly string _SqlConnectionString;
        public DbContext(IConfiguration pConfiguration)
        {
            _SqlConnectionString = pConfiguration.GetConnectionString("DBConnectionString");
        }
        public SqlConnection CreateConnection() => new SqlConnection(_SqlConnectionString);
    }
}
