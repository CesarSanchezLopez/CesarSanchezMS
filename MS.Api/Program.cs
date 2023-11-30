using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.IdentityModel.Tokens;
using MS.Api.Interfaces;
using MS.Api.Services;
using MS.Core.Interfaces;
using MS.Infra;
using MS.Infra.Repositories;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddSingleton<DbContext>();


builder.Services.AddScoped<IDeportistas, DeportistasRepo>();
builder.Services.AddScoped(typeof(IAuthService), typeof(AuthService));//inyectando servicio
                //...
        

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


builder.Services.AddAuthorization(options =>
        options.DefaultPolicy =
        new AuthorizationPolicyBuilder(JwtBearerDefaults.AuthenticationScheme).RequireAuthenticatedUser().Build()
    );
//estos valores los obtenemos de nuestro appsettings
var issuer = builder.Configuration["AuthenticationSettings:Issuer"];
var audience = builder.Configuration["AuthenticationSettings:Audience"];
var signinKey = builder.Configuration["AuthenticationSettings:SigningKey"];
//autenticacion
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
{
    options.Audience = audience;
    options.TokenValidationParameters = new TokenValidationParameters()
    {
        ValidateIssuer = true,
        ValidIssuer = issuer,
        ValidateIssuerSigningKey = true,
        ValidateLifetime = true,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.ASCII.GetBytes(signinKey))
    };
}
);

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
  
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.UseAuthentication();

app.MapControllers();

app.Run();
