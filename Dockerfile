# Etapa de compilación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiamos el archivo del proyecto y restauramos dependencias
# Cambia 'todoList.csproj' si tu archivo se llama diferente
COPY *.csproj ./
RUN dotnet restore

# Copiamos el resto del código y compilamos
COPY . ./
RUN dotnet publish -c Release -o out

# Etapa de ejecución
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# IMPORTANTE: Cambia 'todoList.dll' por el nombre real de tu proyecto
ENTRYPOINT ["dotnet", "todoList.dll"]