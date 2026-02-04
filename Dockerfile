FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia el archivo del proyecto
COPY todoList.csproj ./
RUN dotnet restore todoList.csproj

# Copia todo lo demás y publica
COPY . .
RUN dotnet publish todoList.csproj -c Release -o /app/out

# Etapa final de ejecución
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Configuramos el puerto 8080 para .NET 8
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# REEMPLAZA TU ANTIGUO ENTRYPOINT POR ESTE COMODÍN:
ENTRYPOINT ["sh", "-c", "dotnet $(ls *.dll | head -n 1)"]