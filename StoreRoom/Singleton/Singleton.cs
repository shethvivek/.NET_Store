namespace Singleton
{
    /// <summary>
	/// 1) create constructor as private
	/// 2) make class as sealed
	/// 3) create static property which return instance of object
	/// 4) create private static readonly variable for lock
	/// 5) add lock to prevent another object creation - thread safety
	/// 6) again add if condition before lock - double checked locking
	/// </summary>
	class Singleton
    {
        private static int counter = 0;
        private static Singleton instance = null;
        private static readonly Object obj = new Object();
        // this is static property.. which will return only singleTon object.

        public static Singleton getInstace
        {
            get
            {
                if (instance == null)
                {
                    lock (obj)
                    {
                        if (instance == null)
                            instance = new Singleton();
                    }
                }

                return instance;
            }
        }

        public Singleton()
        {
            counter++;
            Console.WriteLine("Object count is " + counter);
        }
        public void PrintMessage(string message)
        {
            Console.WriteLine(message);
        }
    }
}
