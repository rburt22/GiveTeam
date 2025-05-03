using GiveTeam.Models;
using Microsoft.EntityFrameworkCore;

namespace GiveTeam.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }
        
        public DbSet<User> Users { get; set; }
        public DbSet<Charity> Charities { get; set; }
        public DbSet<Competition> Competitions { get; set; }
        public DbSet<Team> Teams { get; set; }
        public DbSet<TeamMember> TeamMembers { get; set; }
        public DbSet<Donation> Donations { get; set; }
        public DbSet<Achievement> Achievements { get; set; }
        public DbSet<UserAchievement> UserAchievements { get; set; }
        public DbSet<TeamAchievement> TeamAchievements { get; set; }
        public DbSet<Notification> Notifications { get; set; }
        public DbSet<Invitation> Invitations { get; set; }
        public DbSet<DonationReceipt> DonationReceipts { get; set; }
        
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Configure relationships and constraints
            modelBuilder.Entity<TeamMember>()
                .HasKey(tm => tm.TeamMemberId);
                
            modelBuilder.Entity<TeamMember>()
                .HasIndex(tm => new { tm.TeamId, tm.UserId })
                .IsUnique();
                
            modelBuilder.Entity<Donation>()
                .Property(d => d.Amount)
                .HasColumnType("decimal(15,2)");
                
            modelBuilder.Entity<Competition>()
                .Property(c => c.GoalAmount)
                .HasColumnType("decimal(15,2)");
                
            modelBuilder.Entity<Team>()
                .Property(t => t.GoalAmount)
                .HasColumnType("decimal(15,2)");
                
            // Add other configurations as needed
        }
    }
}
