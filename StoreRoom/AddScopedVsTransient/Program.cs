using Microsoft.Extensions.DependencyInjection;

//		.AddScoped : Same instance for the Whole request
//			-- Every time a page is viewed(in MVC)
//			-- Not perfect for multi threading.

//     .AddTransient : Different instance every time object is requested or injected.
//			-- Every time, a new instance is Injected.
//			-- suitable for mult-threading.

ServiceCollection collection = new ServiceCollection();
collection.AddScoped<ScopedClass>();
collection.AddTransient<TransientClass>();

var builder = collection.BuildServiceProvider();

Console.Clear();
Parallel.For(1, 10, i => {
    Console.WriteLine($"Scoped ID = {builder.GetService<ScopedClass>().GetHashCode().ToString()}");
    Console.WriteLine($"Transient ID = {builder.GetService<TransientClass>().GetHashCode().ToString()}");
});

Console.WriteLine("Press a key");
Console.ReadLine();


public class ScopedClass
{

}

public class TransientClass
{

}