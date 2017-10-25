using System;

namespace fourscore_csharp {
  class App {
    public void Run() {
      Console.WriteLine("Welcome to Four Score!");
    }
  }

  class Program {
    static void Main(string[] args) {
      App app = new App();
      app.Run();
    }
  }
}
