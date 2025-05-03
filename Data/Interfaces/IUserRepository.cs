using GiveTeam.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace GiveTeam.Data
{
    public interface IUserRepository : IRepository<User>
    {
        Task<User> GetByEmailAsync(string email);
        Task<User> GetByExternalLoginAsync(string provider, string externalId);
        Task<IEnumerable<User>> GetTeamMembersAsync(int teamId);
        Task<bool> EmailExistsAsync(string email);
    }
}
