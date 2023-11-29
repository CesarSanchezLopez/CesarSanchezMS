using Microsoft.Data.SqlClient;
using MS.Core.Interfaces;
using MS.Core.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;




namespace MS.Infra.Repositories
{
    public class DeportistasRepo : IDeportistas
    {
        private readonly DbContext _context;
        public DeportistasRepo(DbContext context) // Constructor DI Injection
        {
            _context = context;
        }



        public async Task<List<Deportista>> Deportistas()
        {
            List<Deportista> estados = new List<Deportista>();


         
            using var connection = _context.CreateConnection();

            using (var command = new SqlCommand("SP_Deportistas", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
               
                connection.Open();

               
                using (SqlDataReader objReader = command.ExecuteReader())
                {
                    if (objReader.HasRows)
                    {
                        while (objReader.Read())
                        {

                            estados.Add(new Deportista
                            {
                                Id = objReader.GetInt32(objReader.GetOrdinal("Id")),
                                Nombre = objReader.GetString(objReader.GetOrdinal("Nombre")),
                                CodPáis = objReader.GetString(objReader.GetOrdinal("CodPais")),

                            });

                        }
                    }
                }

                command.ExecuteNonQuery();
            }

            return await Task.FromResult(estados);
        }

        public async Task<List<Deportista>> DeportistasModalidad()
        {
            List<Deportista> estados = new List<Deportista>();



            using var connection = _context.CreateConnection();

            using (var command = new SqlCommand("SP_DeportistasModalidad", connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                connection.Open();


                using (SqlDataReader objReader = command.ExecuteReader())
                {
                    if (objReader.HasRows)
                    {
                        while (objReader.Read())
                        {
                            List<Modalidad>? modalidades = new List<Modalidad>();
                            estados.Add(new Deportista
                            {
                                
                                Id = objReader.GetInt32(objReader.GetOrdinal("Id")),
                                Nombre = objReader.GetString(objReader.GetOrdinal("Nombre")),
                                CodPáis = objReader.GetString(objReader.GetOrdinal("CodPais")),
                                Valor = objReader.GetInt32(objReader.GetOrdinal("Valor")),
                                Total = objReader.GetInt32(objReader.GetOrdinal("Total")),
                                Modalidad = objReader.GetString(objReader.GetOrdinal("Modalidad")),
                                //Modalidades = modalidades.Add(new Modalidad { Id=1,Nombre=""})
                            });

                        }
                    }
                }

                command.ExecuteNonQuery();
            }

            return await Task.FromResult(estados);
        }
    }
}
