/**
 *          “Yield keyword helps us to do custom stateful iteration over .NET collections.”
 *          
 * There are two scenarios where “yield” keyword is useful:-
 *      -- Customized iteration through a collection without creating a temporary collection.
 *      -- Stateful iteration.
 * 
 * */

class Program
{
    static void Main(string[] args) // Caller
    {
        FillValues(); // Fills the list with 5 values
        foreach (int i in RunningTotal()) // Browses through the list
        {
            Console.WriteLine(i);
        }
        Console.ReadLine();
    }

    #region  Scenario 1:- Customized iteration through a collection

    static List<int> MyList = new List<int>();

    static void FillValues()
    {
        MyList.Add(1); MyList.Add(2); MyList.Add(3); MyList.Add(4); MyList.Add(5);
    }

    /*
     * let’s say the caller only wants values greater than “3” from the collection.
     * So the obvious thing as a c# developer we will do is create a function as shown below.
     * This function will have temporary collection.
     * In this temporary collection we will first add values which are greater than “3” and return the same to the caller.
     * The caller can then iterate through this collection.
     * 
     * */

    static IEnumerable<int> FilterWithoutYield()
    {
        List<int> temp = new List<int>();
        foreach (int i in MyList)
        {
            if (i > 3)
            {
                temp.Add(i);
            }
        }
        return temp;
    }

    /**
     * Now the above approach is fine but it would be great if we would get rid of the collection, so that our code becomes simple. 
     * 
     * “Yield” keyword will return back the control to the caller, 
     * the caller will do his work and re-enter the function from where he had left and continue iteration from that point onwards.
     * 
     * In other words “yield” keyword moves control of the program to and fro between caller and the collection.
     * 
     **/

    static IEnumerable<int> FilterWithYield()
    {
        foreach (int i in MyList)
        {
            if (i > 3) yield return i;
        }
    }

    /**
     *  Step 1:- Caller calls the function to iterate for number’s greater than 3.
     *  
     *  Step 2:- Inside the function the for loop runs from 1 to 2 , 
     *  from 2 to 3 until it encounters value greater than “3” i.e. “4”.
     *  As soon as the condition of value greater than 3 is met the “yield” keyword sends this data back to the caller.
     *  
     *  Step 3:- Caller displays the value on the console and re-enters the function for more data.
     *  This time when it reenters, it does not start from first.
     *  It remembers the state and starts from “5”. The iteration continues further as usual. 
     * 
     **/

    #endregion

    #region Scenario 2:- Stateful iteration

    /**
     * we will browse from 1 to 5 and as we browse we would keep adding the total in variable.
     * So we start with “1” the running total is “1”, 
     * we move to value “2” the running total is previous value “1” plus current value “2” i.e. “3” and so on.
     * 
     * 
     * In other words we would like to iterate through the collection and as we iterate would like to maintain running total state
     * and return the value to the caller ( i.e. console application).
     * So the function now becomes something as shown below. The “runningtotal” variable will have the old value every time the caller re-enters the function.
     * 
     **/


    static IEnumerable<int> RunningTotal()
    {
        int runningtotal = 0;
        foreach (int i in MyList)
        {
            runningtotal += i;
            yield return (runningtotal);

        }
    }


    #endregion

}