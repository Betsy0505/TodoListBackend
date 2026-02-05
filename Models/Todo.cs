using System.ComponentModel.DataAnnotations;

namespace todoList.Models
{
    public class Todo
    {
        [Key]
        public int Id { get; set; }
        [Required(ErrorMessage = "La tarea es obligatoria")]
        [StringLength(200)]
        public string Task { get; set; } = string.Empty;

        public bool IsCompleted { get; set; } = false;
    }
}
