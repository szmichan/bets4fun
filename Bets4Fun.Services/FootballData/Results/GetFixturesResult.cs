using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Globalization;

namespace Bets4Fun.Services.FootballData.Results
{
    public partial class GetFixturesResult
    {
        [JsonProperty("count")]
        public long Count { get; set; }

        [JsonProperty("fixtures")]
        public Fixture[] Fixtures { get; set; }
    }

    public partial class Fixture
    {
        [JsonProperty("id")]
        public int Id { get; set; }

        [JsonProperty("competitionId")]
        public int CompetitionId { get; set; }

        [JsonProperty("date")]
        public DateTimeOffset Date { get; set; }

        [JsonProperty("status")]
        public FixtureStatus Status { get; set; }

        [JsonProperty("matchday")]
        public int Matchday { get; set; }

        [JsonProperty("homeTeamName")]
        public string HomeTeamName { get; set; }

        [JsonProperty("homeTeamId")]
        public int HomeTeamId { get; set; }

        [JsonProperty("awayTeamName")]
        public string AwayTeamName { get; set; }

        [JsonProperty("awayTeamId")]
        public int AwayTeamId { get; set; }

        [JsonProperty("result")]
        public Result Result { get; set; }

        [JsonProperty("odds")]
        public object Odds { get; set; }
    }

    public partial class Result
    {
        [JsonProperty("goalsHomeTeam")]
        public int? GoalsHomeTeam { get; set; }

        [JsonProperty("goalsAwayTeam")]
        public int? GoalsAwayTeam { get; set; }
    }

    public enum FixtureStatus { Scheduled = 0, Timed = 1, Finished = 2, InPlay = 3 };

    public partial class GetFixturesResult
    {
        public static GetFixturesResult FromJson(string json) => JsonConvert.DeserializeObject<GetFixturesResult>(json, Converter.Settings);
    }

    public static class Serialize
    {
        public static string ToJson(this GetFixturesResult self) => JsonConvert.SerializeObject(self, Converter.Settings);
    }

    internal static class Converter
    {
        public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings
        {
            MetadataPropertyHandling = MetadataPropertyHandling.Ignore,
            DateParseHandling = DateParseHandling.None,
            Converters = {
                new StatusConverter(),
                new IsoDateTimeConverter { DateTimeStyles = DateTimeStyles.AssumeUniversal }
            },
        };
    }

    internal class StatusConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(FixtureStatus) || t == typeof(FixtureStatus?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "SCHEDULED":
                    return FixtureStatus.Scheduled;
                case "TIMED":
                    return FixtureStatus.Timed;
                case "FINISHED":
                    return FixtureStatus.Finished;
                case "IN_PLAY":
                    return FixtureStatus.InPlay;
            }
            throw new Exception("Cannot unmarshal type Status");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            var value = (FixtureStatus)untypedValue;
            switch (value)
            {
                case FixtureStatus.Scheduled:
                    serializer.Serialize(writer, "SCHEDULED"); return;
                case FixtureStatus.Timed:
                    serializer.Serialize(writer, "TIMED"); return;
                case FixtureStatus.Finished:
                    serializer.Serialize(writer, "FINISHED"); return;
                case FixtureStatus.InPlay:
                    serializer.Serialize(writer, "IN_PLAY"); return;
            }
            throw new Exception("Cannot marshal type Status");
        }
    }
}