-- GiveTeam Database Schema
-- Following SOLID design principles with proper separation of concerns

-- Create database
CREATE DATABASE IF NOT EXISTS GiveTeam;
USE GiveTeam;

-- Users table
CREATE TABLE Users (
    UserId INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    ProfileImage VARCHAR(255) NULL,
    Bio TEXT NULL,
    CreatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    LastLoginDate DATETIME NULL,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    IsEmailVerified BOOLEAN NOT NULL DEFAULT FALSE,
    VerificationToken VARCHAR(255) NULL,
    ResetPasswordToken VARCHAR(255) NULL,
    ResetPasswordExpiry DATETIME NULL,
    ExternalLoginProvider VARCHAR(50) NULL,
    ExternalLoginId VARCHAR(255) NULL,
    INDEX idx_email (Email)
);

-- Charities table
CREATE TABLE Charities (
    CharityId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT NOT NULL,
    Logo VARCHAR(255) NULL,
    Website VARCHAR(255) NULL,
    Category VARCHAR(50) NOT NULL,
    TaxId VARCHAR(50) NULL,
    ContactEmail VARCHAR(100) NULL,
    ContactPhone VARCHAR(20) NULL,
    Address TEXT NULL,
    IsVerified BOOLEAN NOT NULL DEFAULT FALSE,
    CreatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    INDEX idx_category (Category),
    INDEX idx_name (Name)
);

-- Competitions table
CREATE TABLE Competitions (
    CompetitionId INT AUTO_INCREMENT PRIMARY KEY,
    CharityId INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Description TEXT NOT NULL,
    GoalAmount DECIMAL(15, 2) NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    CreatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL,
    FeaturedImage VARCHAR(255) NULL,
    FOREIGN KEY (CharityId) REFERENCES Charities(CharityId),
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserId),
    INDEX idx_dates (StartDate, EndDate),
    INDEX idx_charity (CharityId)
);

-- Teams table
CREATE TABLE Teams (
    TeamId INT AUTO_INCREMENT PRIMARY KEY,
    CompetitionId INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Description TEXT NULL,
    Logo VARCHAR(255) NULL,
    CreatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL,
    GoalAmount DECIMAL(15, 2) NULL,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (CompetitionId) REFERENCES Competitions(CompetitionId),
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserId),
    INDEX idx_competition (CompetitionId)
);

-- TeamMembers table
CREATE TABLE TeamMembers (
    TeamMemberId INT AUTO_INCREMENT PRIMARY KEY,
    TeamId INT NOT NULL,
    UserId INT NOT NULL,
    JoinDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    IsAdmin BOOLEAN NOT NULL DEFAULT FALSE,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (TeamId) REFERENCES Teams(TeamId),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    UNIQUE KEY unique_team_user (TeamId, UserId),
    INDEX idx_team (TeamId),
    INDEX idx_user (UserId)
);

-- Donations table
CREATE TABLE Donations (
    DonationId INT AUTO_INCREMENT PRIMARY KEY,
    CompetitionId INT NOT NULL,
    TeamId INT NULL,
    UserId INT NULL, -- Can be NULL for anonymous donations
    Amount DECIMAL(15, 2) NOT NULL,
    Message TEXT NULL,
    IsAnonymous BOOLEAN NOT NULL DEFAULT FALSE,
    TransactionId VARCHAR(100) NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    DonationDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    IsRecurring BOOLEAN NOT NULL DEFAULT FALSE,
    RecurringFrequency VARCHAR(20) NULL, -- Monthly, Weekly, etc.
    ReceiptSent BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (CompetitionId) REFERENCES Competitions(CompetitionId),
    FOREIGN KEY (TeamId) REFERENCES Teams(TeamId),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    INDEX idx_competition (CompetitionId),
    INDEX idx_team (TeamId),
    INDEX idx_user (UserId),
    INDEX idx_date (DonationDate)
);

-- Achievements table
CREATE TABLE Achievements (
    AchievementId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT NOT NULL,
    BadgeImage VARCHAR(255) NOT NULL,
    AchievementType ENUM('User', 'Team') NOT NULL,
    ThresholdValue INT NULL, -- For achievements based on numerical values
    CreatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE
);

-- UserAchievements table
CREATE TABLE UserAchievements (
    UserAchievementId INT AUTO_INCREMENT PRIMARY KEY,
    UserId INT NOT NULL,
    AchievementId INT NOT NULL,
    EarnedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CompetitionId INT NULL,
    TeamId INT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (AchievementId) REFERENCES Achievements(AchievementId),
    FOREIGN KEY (CompetitionId) REFERENCES Competitions(CompetitionId),
    FOREIGN KEY (TeamId) REFERENCES Teams(TeamId),
    UNIQUE KEY unique_user_achievement_competition (UserId, AchievementId, CompetitionId),
    INDEX idx_user (UserId)
);

-- TeamAchievements table
CREATE TABLE TeamAchievements (
    TeamAchievementId INT AUTO_INCREMENT PRIMARY KEY,
    TeamId INT NOT NULL,
    AchievementId INT NOT NULL,
    EarnedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CompetitionId INT NOT NULL,
    FOREIGN KEY (TeamId) REFERENCES Teams(TeamId),
    FOREIGN KEY (AchievementId) REFERENCES Achievements(AchievementId),
    FOREIGN KEY (CompetitionId) REFERENCES Competitions(CompetitionId),
    UNIQUE KEY unique_team_achievement_competition (TeamId, AchievementId, CompetitionId),
    INDEX idx_team (TeamId)
);

-- Notifications table
CREATE TABLE Notifications (
    NotificationId INT AUTO_INCREMENT PRIMARY KEY,
    UserId INT NOT NULL,
    Message TEXT NOT NULL,
    NotificationType VARCHAR(50) NOT NULL,
    RelatedEntityId INT NULL, -- Could be TeamId, CompetitionId, etc.
    RelatedEntityType VARCHAR(50) NULL,
    IsRead BOOLEAN NOT NULL DEFAULT FALSE,
    CreatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    INDEX idx_user (UserId),
    INDEX idx_date (CreatedDate)
);

-- Invitations table
CREATE TABLE Invitations (
    InvitationId INT AUTO_INCREMENT PRIMARY KEY,
    TeamId INT NOT NULL,
    Email VARCHAR(100) NOT NULL,
    InvitationCode VARCHAR(100) NOT NULL,
    SentBy INT NOT NULL,
    SentDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    AcceptedDate DATETIME NULL,
    ExpiryDate DATETIME NOT NULL,
    Status ENUM('Pending', 'Accepted', 'Expired', 'Cancelled') NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (TeamId) REFERENCES Teams(TeamId),
    FOREIGN KEY (SentBy) REFERENCES Users(UserId),
    INDEX idx_team (TeamId),
    INDEX idx_email (Email),
    INDEX idx_code (InvitationCode)
);

-- DonationReceipts table
CREATE TABLE DonationReceipts (
    ReceiptId INT AUTO_INCREMENT PRIMARY KEY,
    DonationId INT NOT NULL,
    ReceiptNumber VARCHAR(50) NOT NULL,
    GeneratedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    SentDate DATETIME NULL,
    ReceiptPdfPath VARCHAR(255) NULL,
    FOREIGN KEY (DonationId) REFERENCES Donations(DonationId),
    UNIQUE KEY unique_receipt_number (ReceiptNumber),
    INDEX idx_donation (DonationId)
);
