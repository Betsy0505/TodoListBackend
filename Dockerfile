FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia explícitamente el archivo (esto ayuda a debuguear si no existe)
COPY todoList.csproj ./
RUN dotnet restore todoList.csproj

COPY . .
RUN dotnet publish todoList.csproj -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "todoList.dll"]