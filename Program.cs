using Microsoft.EntityFrameworkCore;
using todoList.Data;

var builder = WebApplication.CreateBuilder(args);

// 1. Configurar la Base de Datos
String connectionString = Environment.GetEnvironmentVariable("DefaultConnection") ?? builder.Configuration.GetConnectionString("DefaultConnection");

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString)));

// 2. Controladores 
builder.Services.AddControllers();

// 3. CORS
builder.Services.AddCors(options => {
    options.AddPolicy("AllowReact", policy =>
        policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();
app.UseCors("AllowReact");

app.MapControllers(); 

app.Run();