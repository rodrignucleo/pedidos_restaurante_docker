FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base

WORKDIR /app

EXPOSE 9001

RUN apt-get update \
 && apt-get install -y --allow-unauthenticated \
 libc6-dev \
 libgdiplus \
 libx11-dev \
 && rm -rf /var/lib/apt/lists/*

ENV DISPLAY :99
ENV ASPNETCORE_URLS=http://+:9001
ENV DisableHttpsRedirection=true

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["./client/ProjetoGerenciamentoRestaurante.RazorPages/ProjetoGerenciamentoRestaurante.RazorPages.csproj", "./"]

RUN dotnet restore "./ProjetoGerenciamentoRestaurante.RazorPages.csproj"
COPY . .

WORKDIR "/src/."

RUN dotnet build "client/ProjetoGerenciamentoRestaurante.RazorPages/ProjetoGerenciamentoRestaurante.RazorPages.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "client/ProjetoGerenciamentoRestaurante.RazorPages/ProjetoGerenciamentoRestaurante.RazorPages.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ProjetoGerenciamentoRestaurante.RazorPages.dll"]

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone