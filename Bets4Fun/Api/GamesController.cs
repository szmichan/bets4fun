using Bets4Fun.BusinessLogic;
using System;
using System.Web.Http;
using Bets4Fun.Common;

namespace Bets4Fun.Api
{
    public class GetGameResponse
    {
        public string Team1Name { get; set; }
        public string Team2Name { get; set; }
        public string ContestName { get; set; }
        public string GameDateString { get; set; }

        public decimal? Team1Points { get; set; }
        public decimal? DrawPoints { get; set; }
        public decimal? Team2Points { get; set; }

        public string Team1Banner { get; set; }
        public string Team2Banner { get; set; }

        public decimal? MultiplyValue { get; set; }

        public string Description { get; set; }

        public int? Team1Score { get; set; }
        public int? Team2Score { get; set; }
    }

    [RoutePrefix("api/games")]
    public class GamesController : ApiController
    {
        [HttpGet]
        [Route("{id}")]
        public IHttpActionResult GetGame([FromUri]int id)
        {
            DB.GamesRow game = null;

            try
            {
                game = GamesLogic.GetGameById(id);
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }

            return Ok(game == null ? null : new GetGameResponse()
            {
                Team1Name = game.Team1_Name,
                Team2Name = game.Team2_Name,
                ContestName = game.Contest_Name,
                GameDateString = DateConverter.ConvertToCest(game.GameDate).ToString("yyyy-MM-dd, HH:mm"),
                DrawPoints = game.IsDrawPointsNull() ? null : (decimal?)game.DrawPoints,
                Team1Points = game.IsTeam1PointsNull() ? null : (decimal?)game.Team1Points,
                Team2Points = game.IsTeam2PointsNull() ? null : (decimal?)game.Team2Points,
                Team1Banner = $"/App_Themes/Default/Images/banners/{game.Team1_BannerImage}",
                Team2Banner = $"/App_Themes/Default/Images/banners/{game.Team2_BannerImage}",
                MultiplyValue = game.MultiplyValue,
                Description = game.IsDescriptionNull() ? null : game.Description,
                Team1Score = game.IsTeam1ScoreNull() ? null : (int?)game.Team1Score,
                Team2Score = game.IsTeam2ScoreNull() ? null : (int?)game.Team2Score
            });
        }
    }
}