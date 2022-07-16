FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
# Install NodeJs
RUN apt-get update && \
apt-get install -y wget && \
apt-get install -y gnupg2 && \
wget -qO- https://deb.nodesource.com/setup_16.x | bash - && \
apt-get install -y build-essential nodejs
# End Install
WORKDIR /src
COPY ["DemoApp.Data.Object/DemoApp.Data/DemoApp.Data.csproj", "DemoApp.Data.Object/DemoApp.Data/"]
COPY DemoApp.Logger/Logger/DemoApp.InfrastructureLibrary.csproj DemoApp.Logger/Logger/ 
COPY DemoApp.Repository/RepositoryInterface/RepositoryInterface.csproj DemoApp.Repository/RepositoryInterface/ 
COPY DemoApp.Repository/Repository/Repository.csproj DemoApp.Repository/Repository/ 
COPY DemoApp.Service/ServiceInterface/ServiceInterface.csproj DemoApp.Service/ServiceInterface/ 
COPY DemoApp.Service/Service/Service.csproj DemoApp.Service/Service/ 
COPY DemoApp.Common/Utility.Helper/Utility.Helper.csproj DemoApp.Common/Utility.Helper/ 
COPY DemoApp.Data.Object/DemoApp.Base/DemoApp.Base.csproj DemoApp.Data.Object/DemoApp.Base/ 
COPY DemoApp.Data.Object/Data.Object/Data.Entity.csproj DemoApp.Data.Object/Data.Object/ 
COPY DemoApp.Vml/ViewModel/ViewModel.csproj DemoApp.Vml/ViewModel/ 
COPY DemoApp.Vml/VmlInterface/VmlInterface.csproj DemoApp.Vml/VmlInterface/ 
COPY DemoApp.Vml/Vml/Vml.csproj DemoApp.Vml/Vml/ 
COPY DemoApp.Web/DemoApp.Web.UI/DemoApp.Web.UI.csproj DemoApp.Web/DemoApp.Web.UI/ 
RUN dotnet restore "DemoApp.Web/DemoApp.Web.UI/DemoApp.Web.UI.csproj"
COPY . .
WORKDIR "/src/DemoApp.Web/DemoApp.Web.UI"
RUN dotnet build "DemoApp.Web.UI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DemoApp.Web.UI.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT dotnet DemoApp.Web.UI.dll 
#END