# Build the standalone .cs file
FROM ://microsoft.com AS build
WORKDIR /src
COPY Program.cs .
RUN dotnet publish Program.cs -c Release -o /app/publish

# Run the compiled binary
FROM ://microsoft.com AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["./Program"]
