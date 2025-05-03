# GiveTeam - Charity Fundraising Competition Platform

GiveTeam is a web application that allows users to form teams that compete to raise the most money for selected charities. The application tracks donations in real-time, displays leaderboards, and facilitates social sharing to encourage participation.

## Features

- User registration and authentication system
- Team creation and management
- Charity profiles and integration
- Secure donation processing
- Time-bound fundraising competitions
- Real-time leaderboards
- Achievement badges and milestones
- Reporting and analytics dashboard

## Technology Stack

- **Frontend**: HTML5, CSS3, Vanilla JavaScript
- **Backend**: C# with ASP.NET Core
- **Database**: MySQL
- **Authentication**: JWT-based authentication

## Getting Started

### Prerequisites

- .NET 6.0 SDK
- MySQL Server
- Visual Studio or Visual Studio Code

### Installation

1. Clone the repository
2. Update the connection string in `appsettings.json` to point to your MySQL server
3. Run database migrations:
   ```
   dotnet ef database update
   ```
4. Run the application:
   ```
   dotnet run
   ```

## Project Structure

- **Controllers/**: API controllers
- **Models/**: Domain models
- **Data/**: Data access layer
- **Services/**: Business logic
- **Helpers/**: Utility classes
- **wwwroot/**: Static files (HTML, CSS, JavaScript)

## Development Guidelines

- Follow SOLID design principles
- Use proper validation and error handling
- Write unit tests for all core functionality
- Follow secure coding practices for payment processing
- Implement proper data validation and sanitization
- Ensure GDPR compliance for user data
