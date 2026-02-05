using Microsoft.EntityFrameworkCore;
using todoList.Models;

namespace todoList.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }
        public DbSet<Todo> Todos => Set<Todo>();
    }
}
