using GiveTeam.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace GiveTeam.Data
{
    public interface ITeamRepository : IRepository<Team>
    {
        Task<IEnumerable<Team>> GetByCompetitionAsync(int competitionId);
        Task<IEnumerable<Team>> GetByUserAsync(int userId);
        Task<IEnumerable<User>> GetTeamMembersAsync(int teamId);
        Task<bool> IsUserTeamMemberAsync(int teamId, int userId);
        Task<bool> IsUserTeamAdminAsync(int teamId, int userId);
    }
}
