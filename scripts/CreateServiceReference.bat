SET target_ns=Originations.Clients.PortfolioSearch
SET target_path=Originations\Clients\PortfolioSearch
SET target_url=https://vsftrdf3crmw.bmwgroup.net/services/OriginationsPortfolioSearch/OriginationsPortfolioSearch.svc
dotnet-svcutil -n "*,%target_ns%" -d "%target_path%" -v Verbose -i "%target_url%"