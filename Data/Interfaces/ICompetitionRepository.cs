using GiveTeam.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace GiveTeam.Data
{
    public interface ICompetitionRepository : IRepository<Competition>
    {
        Task<IEnumerable<Competition>> GetActiveCompetitionsAsync();
        Task<IEnumerable<Competition>> GetByCharityAsync(int charityId);
        Task<Competition> GetWithDetailsAsync(int competitionId);
    }
}
