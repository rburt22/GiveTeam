using GiveTeam.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace GiveTeam.Data
{
    public interface ICharityRepository : IRepository<Charity>
    {
        Task<IEnumerable<Charity>> GetByCategoryAsync(string category);
        Task<IEnumerable<Charity>> GetVerifiedCharitiesAsync();
    }
}
