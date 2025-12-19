namespace Singleton
{
    class Program
    {
        static void Main(string[] args)
        {
            Parallel.Invoke(
                () => PrintEmployeeDetails(),
                () => PrintStudentDetails()
                );
            //PrintEmployeeDetails();
            //PrintStudentDetails();
            Console.WriteLine("-------------------------------");
        }

        private static void PrintStudentDetails()
        {
            Singleton fromStudent = Singleton.getInstace;
            fromStudent.PrintMessage("from Student");
        }

        private static void PrintEmployeeDetails()
        {
            Singleton fromEmployee = Singleton.getInstace;
            fromEmployee.PrintMessage("from Employee");
        }
    }
}
