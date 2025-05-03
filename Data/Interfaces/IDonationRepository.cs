using GiveTeam.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace GiveTeam.Data
{
    public interface IDonationRepository : IRepository<Donation>
    {
        Task<IEnumerable<Donation>> GetByUserAsync(int userId);
        Task<IEnumerable<Donation>> GetByTeamAsync(int teamId);
        Task<IEnumerable<Donation>> GetByCompetitionAsync(int competitionId);
        Task<decimal> GetTotalDonationsByTeamAsync(int teamId);
        Task<decimal> GetTotalDonationsByCompetitionAsync(int competitionId);
        Task<decimal> GetTotalDonationsByUserAsync(int userId);
    }
}
