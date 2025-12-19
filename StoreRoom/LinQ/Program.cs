/*
     What is LINQ ?
        - stands for : Langage Integrated Query
        - Gives us the capability to query objects in C# natively

        You can query :
            - Objects in memory, eg : collections (LINQ to Objects)
            - Databases (LINQ to Entities)
            - XML (LINQ to XML)
            - ADO.NET Data Sets (LINQ to Data Sets)
         */

using LinQ;

var books = new BookRepository().GetBooks();

//LINQ Query Operators
var cheaperBooks = from b in books
                   where b.Price < 10
                   orderby b.Title
                   select b.Title;

/*---the same -----*/

//LINQ Extension Methods
var cheapBooks = books
                    .Where(b => b.Price < 10)
                    .OrderBy(b => b.Title)
                    .Select(b => b.Title);

foreach (var bk in cheapBooks)
{
    // Console.WriteLine(book.Title);
    Console.WriteLine(bk);
}


/*------------------------------------------------------------------*/
var book = books.Single(b => b.Title == "ASP.NET MVC"); //throw an exception if nothing found
var book2 = books.SingleOrDefault(b => b.Title == "ASP.NET MVC++"); //return null if nothing found

Console.WriteLine(book.Title);
Console.WriteLine(book2 == null ? "null" : book2.Title);

/*-------------------------------------------------------------------*/

var book3 = books.First(); //first element of the collection
var book4 = books.First(b => b.Title == "C# Advanced Topics"); //first element of the collection
var book5 = books.FirstOrDefault(); //return null if nothing found 

Console.WriteLine(book3.Title);
Console.WriteLine(book4.Price);
Console.WriteLine(book5 == null ? "null" : book5.Title);

var book6 = books.Last(); //first element of the collection
var book7 = books.Last(b => b.Title == "C# Advanced Topics"); //first element of the collection
var book8 = books.LastOrDefault(); //return null if nothing found 

Console.WriteLine(book6.Title);
Console.WriteLine(book7.Price);
Console.WriteLine(book8 == null ? "null" : book8.Title);

/*-------------------------------------------------------------------*/

var books9 = books.Skip(2).Take(3); //used for paging data
                                    //skip 2 records or two objects and take 3
foreach (var bb in books9)
{
    Console.WriteLine(bb.Title);
}


/* --------------------------------------------------------------------*/

var count = books.Count();
Console.WriteLine(count);

var maxPrice = books.Max(b => b.Price);
var minPrice = books.Min(b => b.Price);
var sumPriceofAllBook = books.Sum(b => b.Price);
var average = books.Average(b => b.Price);

Console.WriteLine("maxPrice : {0} and min price : {1} and sum of all books : {2}, and finally average = {3}", maxPrice, minPrice, sumPriceofAllBook, average);
Console.WriteLine();
Console.WriteLine("Advance Topics..");
Console.WriteLine();

// Let's learn some Join related stuff..

// Create Object of student and course lists
var studentList = new List<Student>();
var courseList = new List<Course>();

// Add some students
studentList.Add(new Student { Name = "Vivek", CourseId = 1 });
studentList.Add(new Student { Name = "Gaurav", CourseId = 2 });
studentList.Add(new Student { Name = "Sanjay", CourseId = 1 });
studentList.Add(new Student { Name = "Nikunj", CourseId = 3 });

// Add some courses
courseList.Add(new Course { CourseId = 1, CourseName = "Math", Students = new List<Student>() { studentList[0], studentList[2] } });
courseList.Add(new Course { CourseId = 2, CourseName = "Science", Students = new List<Student>() { studentList[1] } });

Console.WriteLine("Inner Join.");

var innerJoinQuery =    from s in studentList
                        join c in courseList
                        on s.CourseId equals c.CourseId
                        select new { StudentName = s.Name, CourseName = c.CourseName };

foreach(var result in innerJoinQuery)
{
    Console.WriteLine($"{result.StudentName} - {result.CourseName}");
}

Console.WriteLine();
Console.WriteLine("Group Join..");

// Group students by course (group join)
var groupJoinQuery =
    from course in courseList
    join student in studentList
    on course.CourseId equals student.CourseId
    into studentGroup
    select new { CourseName = course.CourseName, Students = studentGroup };

// Print the results
foreach (var group in groupJoinQuery)
{
    Console.WriteLine(group.CourseName);
    foreach (var student in group.Students)
    {
        Console.WriteLine("   " + student.Name);
    }
}

Console.WriteLine();
Console.WriteLine("Left Outer Join..");

var leftJoinQuery =
    from student in studentList            // 'student' is the left collection
    join course in courseList            // 'course' is the right collection
    on student.CourseId equals course.CourseId into studentGroup // Group matching courses
    from item in studentGroup.DefaultIfEmpty() // Handle non-matching students
    select new
    {
        StudentName = student.Name,
        CourseName = item?.CourseName ?? "Not Enrolled" // Handle potential nulls
    };

foreach (var result in leftJoinQuery)
{
    Console.WriteLine($"{result.StudentName} - {result.CourseName}");
}


Console.WriteLine();
Console.WriteLine("Cross Join..");

var crossJoinQuery =
    from student in studentList
    from course in courseList
    select new { StudentName = student.Name, CourseName = course.CourseName };

foreach (var result in crossJoinQuery)
{
    Console.WriteLine($"{result.StudentName} - {result.CourseName}");
}

Console.ReadLine();



// Reference: https://medium.com/@ajuatahcodingarena/master-data-manipulation-with-linq-joins-in-c-bf08d312080b







