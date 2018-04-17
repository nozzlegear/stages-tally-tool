FROM microsoft/dotnet:2.0-sdk
WORKDIR /app

# Install mono
RUN apt-get -qq update
RUN apt-get -qq install -y mono-complete libc-bin

# copy project and restore as distinct layers
COPY paket.* ./
COPY .paket .paket
COPY *.fsproj ./
RUN dotnet restore

# copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o dist

CMD ["/app/dist/stages-tally-tool"]
