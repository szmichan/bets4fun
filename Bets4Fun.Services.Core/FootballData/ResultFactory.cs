using Newtonsoft.Json;

namespace Bets4Fun.Services.FootballData
{
    public class ResultFactory<T>
    {
        public T FromJson(string json, JsonSerializerSettings settings) => JsonConvert.DeserializeObject<T>(json, settings);
    }
}
