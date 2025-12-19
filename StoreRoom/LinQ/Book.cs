namespace LinQ
{
    public class Book
    {
        public string Title { get; set; }
        public float Price { get; set; }

    }

    public class Student
    {
        public int StudentId { get; set; } // Optional, if there's no inherent ID
        public string Name { get; set; }
        public int CourseId { get; set; }
    }
    public class Course
    {
        public int CourseId { get; set; }
        public string CourseName { get; set; }
        public List<Student> Students { get; set; }

    }
}
