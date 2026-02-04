# Usa la imagen oficial de .NET 8 SDK para compilar
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia los archivos del proyecto y restaura dependencias
COPY *.csproj ./
RUN dotnet restore

# Copia el resto del código y publica la aplicación
COPY . ./
RUN dotnet publish -c Release -o out

# Usa la imagen de ASP.NET para ejecutar (más ligera)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# ¡IMPORTANTE! Asegúrate de que el nombre sea igual a tu proyecto
ENTRYPOINT ["dotnet", "todoList.dll"]
