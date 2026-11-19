using System.Net;
using System.Text;

static class Program
{
    private static readonly byte[] ResponseBody = Encoding.UTF8.GetBytes("Hello, World!");

    private static async Task Main()
    {
        using var listener = new HttpListener();
        listener.Prefixes.Add("http://*:8080/");
        listener.Start();

        Console.WriteLine("Listening on http://127.0.0.1:8080/");

        while (true)
        {
            var context = await listener.GetContextAsync();
            await RespondAsync(context);
        }
    }

    private static async Task RespondAsync(HttpListenerContext context)
    {
        var response = context.Response;
        response.ContentType = "text/plain; charset=utf-8";
        response.ContentLength64 = ResponseBody.Length;

        try
        {
            await response.OutputStream.WriteAsync(ResponseBody);
        }
        finally
        {
            response.Close();
        }
    }
}
