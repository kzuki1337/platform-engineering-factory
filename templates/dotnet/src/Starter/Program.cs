var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/healthz", () => Results.Text("ok\n"));
app.MapGet("/", () => new { message = Greeting.Create() });

app.Run();

public static class Greeting
{
    public static string Create() => "Hello from the platform starter";
}
