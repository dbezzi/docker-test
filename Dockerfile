# Build the standalone .cs file
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
RUN dotnet new console -n HelloWorldApp --no-restore
COPY src/Program.cs HelloWorldApp/Program.cs
RUN dotnet publish HelloWorldApp/HelloWorldApp.csproj -c Release -o /app/publish /p:UseAppHost=false

# Run the compiled binary
FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "HelloWorldApp.dll"]
