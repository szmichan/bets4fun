using Bets4Fun.Services.FootballData.Results;
using System.Configuration;
using System.Net.Http;
using System.Threading.Tasks;

namespace Bets4Fun.Services.FootballData
{
    public class FootballDataClient
    {
        private static readonly string _baseUrl = ConfigurationManager.AppSettings["ExternalApiUrl"];
        private static readonly string _xAuthToken = ConfigurationManager.AppSettings["X-Auth-Token"];
        private static readonly string _xResponseControl = ConfigurationManager.AppSettings["X-Response-Control"];

        private static HttpClient _httpClient;
        private static HttpClient HttpClient
        {
            get
            {
                if (_httpClient == null)
                {
                    _httpClient = new HttpClient();
                    _httpClient.BaseAddress = new System.Uri(_baseUrl);
                    if (!string.IsNullOrWhiteSpace(_xAuthToken))
                        _httpClient.DefaultRequestHeaders.Add("X-Auth-Token", _xAuthToken);
                    if (!string.IsNullOrWhiteSpace(_xResponseControl))
                        _httpClient.DefaultRequestHeaders.Add("X-Response-Control", _xResponseControl);
                }

                return _httpClient;
            }
        }

        public static async Task<GetFixturesResult> GetFixturesForCompetition(int competitionId)
        {
            var url = $"competitions/{competitionId}/fixtures";
            var response = await HttpClient.GetAsync(url);
            var jsonString = await response.Content.ReadAsStringAsync();

            return GetFixturesResult.FromJson(jsonString);
        }
    }
}