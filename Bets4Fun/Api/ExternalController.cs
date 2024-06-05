using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace Bets4Fun.Api
{
    [RoutePrefix("api/external")]
    public class ExternalController : ApiController
    {
        private static HttpClient _client = new HttpClient();

        [HttpPost]
        [Route("contests/{id:int}/seed")]
        public async Task<IHttpActionResult> Seed([FromUri]int id)
        {
            DB.ContestsRow contest = null;
            //using (var logic = new ContestsLogic())
            //{
            //    contest = logic.GetContestById(id);
            //}

            //if (contest == null || contest.IsExternalIdNull())
            //    return BadRequest();

            //var data = await FootballDataClient.GetFixturesForCompetition(contest.ExternalId);

            //using (var gamesLogic = new GamesLogic())
            //{
            //    foreach (var item in data.Fixtures)
            //    {
            //        gamesLogic.SeedGame(item);
            //    }
            //}

            return Ok();
        }
    }
}