
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build-env
WORKDIR /app

# copy project file and restore (adjust PROJECT arg if your .csproj name differs)
COPY MyWebAPI.csproj ./

RUN dotnet restore 

# copy the rest and publish
COPY . ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build-env /app/out .
EXPOSE 80
ENTRYPOINT ["dotnet", "MyWebAPI.dll"]