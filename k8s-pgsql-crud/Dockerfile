FROM mcr.microsoft.com/dotnet/aspnet:6.0 as base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 as build
WORKDIR /src
COPY ["models/models.csproj","models/models.csproj"]
COPY ["k8s-pgsql-crud/k8s-pgsql-crud.csproj","k8s-pgsql-crud/k8s-pgsql-crud.csproj"]
RUN dotnet restore "k8s-pgsql-crud/k8s-pgsql-crud.csproj"
COPY . .
WORKDIR /src/k8s-pgsql-crud
RUN dotnet build "k8s-pgsql-crud.csproj" -c Release -o /app/build

FROM build as publish
RUN dotnet publish "k8s-pgsql-crud.csproj" -c Release -o /app/publish

FROM base as final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT dotnet k8s-pgsql-crud.dll

