using Bets4Fun.BusinessLogic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Web.Security;
using Bets4Fun.Common;

namespace Bets4Fun.Api
{
    public class GetBetRequest
    {
        public int GameId { get; set; }
        public int UserId { get; set; }
    }

    public class GetBetResponse
    {
        public int Team1Score { get; set; }
        public int Team2Score { get; set; }
    }

    public class MakeBetRequest
    {
        public int GameId { get; set; }
        public int UserId { get; set; }
        public int Team1Score { get; set; }
        public int Team2Score { get; set; }
    }

    public class ChangeBetRequest
    {
        public int BetId { get; set; }
        public int Team1Score { get; set; }
        public int Team2Score { get; set; }
    }

    public class GetBetsForGameResponse
    {
        public GetBetsForGameResponse()
        {
            Bets = new List<GetBetsForGameResponseBet>();
        }
        public List<GetBetsForGameResponseBet> Bets { get; set; }
        public GetBetsForGameResponseGame Game { get; set; }
    }

    public class GetBetsForGameResponseBet
    {
        public string BetDateString { get; set; }
        public int UserId { get; set; }
        public string UserLogin { get; set; }

        public int Team1Score { get; set; }
        public int Team2Score { get; set; }
        public decimal? Points { get; set; }
    }

    public class GetBetsForGameResponseGame
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

    [RoutePrefix("api/bets")]
    public class BetsController : ApiController
    {
        [HttpPost]
        public IHttpActionResult GetBet([FromBody]GetBetRequest request)
        {
            DB.BetsRow bet = null;

            try
            {
                bet = BetsLogic.GetBetByUserInGame(request.GameId, request.UserId);
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }

            return Ok(bet == null ? null : new GetBetResponse()
            {
                Team1Score = bet.Team1Score,
                Team2Score = bet.Team2Score
            });
        }

        [HttpGet]
        [Route("game/{gameId}")]
        public IHttpActionResult GetBetsForGame([FromUri]int gameId)
        {
            GetBetsForGameResponse response = new GetBetsForGameResponse();

            try
            {
                DB.GamesRow game = GamesLogic.GetGameById(gameId);

                if (game.GameDate >= DateTimeOffset.UtcNow.AddMinutes(-5) && !Roles.IsUserInRole(User.Identity.Name, "Admin"))
                {
                    return BadRequest("Cannot perform operation! Game has not yet started.");
                }

                response.Game = new GetBetsForGameResponseGame()
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
                };

                DB.BetsDataTable bets = BetsLogic.GetBetsByGameId(gameId);

                if (bets != null)
                {
                    response.Bets = bets.Select(bet => new GetBetsForGameResponseBet()
                    {
                        BetDateString = DateConverter.ConvertToCest(bet.BetDate).ToString("yyyy-MM-dd HH:mm"),
                        UserId = bet.User_Id,
                        UserLogin = bet.User_Login,
                        Team1Score = bet.Team1Score,
                        Team2Score = bet.Team2Score,
                        Points = bet.IsPointsNull() ? null : (decimal?)bet.Points
                    }).ToList();
                }

                //for (int i = 0; i < 100; i++)
                //{
                //    betList.Add(new GetBetsForGameResponse_Bet()
                //    {
                //        BetDateString = "2010-01-01",
                //        UserId = i,
                //        UserLogin = $"Login{i}",
                //        Team1Score = i,
                //        Team2Score = i + 1,
                //    });
                //}
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }

            return Ok(response);
        }

        [HttpPost]
        [Route("makebet")]
        public IHttpActionResult MakeBet([FromBody]MakeBetRequest request)
        {
            try
            {
                DB.BetsRow bet = BetsLogic.GetBetByUserInGame(request.GameId, request.UserId);
                DB.GamesRow game = GamesLogic.GetGameById(request.GameId);

                if (game.GameDate <= DateTimeOffset.UtcNow.AddMinutes(5))
                {
                    return BadRequest("Cannot perform operation! Betting deadline for this game has passed.");
                }

                if (bet == null)
                {
                    BetsLogic.InsertBet(request.GameId, request.UserId, request.Team1Score, request.Team2Score);
                }
                else
                {
                    BetsLogic.UpdateBet(request.GameId, request.UserId, request.Team1Score, request.Team2Score, bet.Id);
                }
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }

            return Ok();
        }

        [HttpPost]
        [Route("{id}/delete")]
        public IHttpActionResult DeleteBet([FromUri]int id)
        {
            try
            { 
                BetsLogic.DeleteBet(id);
            }
            catch(Exception e)
            {
                return InternalServerError(e);
            }

            return Ok();
        }
    }
}