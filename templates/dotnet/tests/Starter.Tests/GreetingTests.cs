using Xunit;

public class GreetingTests
{
    [Fact]
    public void CreatesStarterGreeting()
    {
        Assert.Equal("Hello from the platform starter", Greeting.Create());
    }
}
