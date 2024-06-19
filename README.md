# Kitchen Network
Kitchen Network is a web platform designed to connect food-service owners with culinary professionals for hiring, production, and research and development purposes.

## Problem Statement
For many food-service owners, finding the right talent and resources necessary for operations can be a significant challenge. Traditional hiring processes are often slow and inefficient, leading to delays in production and increased costs. Additionally, scaling up operations and exploring new culinary concepts without access to a centralized platform for qualified professionals and suppliers further complicates these efforts.

## Solution
Kitchen Network addresses these challenges by providing an all-in-one platform where food-service owners can efficiently connect with skilled culinary professionals. This reduces the time and resources needed to hire suitable candidates and facilitates smoother operations and development within the food-service industry.

## Features
### For Food-Service Owners:
  - **User Management**:
    - Create and manage business profiles.
    - Sign up via email/password.
    - Authentication handled by Devise.
  - **Job Listings**:
    - Post job openings with detailed descriptions, skills required, location, and salary range.
    - Edit or delete job listings as needed.
    - Receive and manage applications from culinary professionals.
  - **Messaging System**:
    - Communicate with applicants and hired professionals within the platform.
  - **Payment Processing**:
    - Pay fees for successful job placements facilitated through the platform using Stripe API.
    - Securely enter payment details and manage transactions.
  - **Rating and Reviews**:
    - Rate and review culinary professionals based on their performance.
    - Provide feedback to help others make informed decisions.
      
### For Culinary Professionals:
  - **Profile Management**:
    - Create and manage profiles showcasing skills, experience, availability, and portfolio.
    - Upload profile pictures and resumes.
    - Authentication handled by Devise.
  - **Job Search and Application**:
    - Browse job listings with detailed job descriptions and requirements.
     - Apply for jobs by submitting profiles.
    - Track application statuses.
  - **Messaging System**:
    - Communicate with food-service owners regarding job opportunities and project details.
  - **Rating and Reviews**:
    - Rate and review food-service owners based on professional experience.
    - Share detailed feedback to assist others in decision-making.
  - **Payment Management**:
    - Receive payments for services rendered through the platform securely and promptly.
      
### For Admins:
  - **User Management**:
    - View and manage all user accounts (food-service owners and culinary professionals).
    - Edit user profiles as necessary.
  - **Payment and Transaction Management**:
    - Monitor and manage all payment transactions to ensure smooth platform operation.

## Technologies Used
- **Ruby on Rails**: Backend framework
- **HTML.erb**: Frontend templating
- **Tailwind CSS**: Styling framework for frontend
- **Devise**: Authentication solution
- **Stimulus**: Frontend JavaScript framework for interactivity
- **PostgreSQL**: Database management system
- **Stripe API**: Payment processing and transactions

## Installation and Setup
To run this project locally, follow these steps:

1. Clone the repository: ```git clone https://github.com/dhanniela/kitchen-network.git```
2. Navigate into the project directory: ```cd kitchen-network```
3. Install dependencies: ```bundle install```
4. Set up the database: ```rails db:create```
                        ```rails db:migrate```
5. Set up environment variables for Stripe API keys in .env file:  ```STRIPE_API_KEY=your_stripe_api_key_here```
6. Start the Rails server: ```rails server```
7. Open your web browser and visit ```http://localhost:3000``` to view the application.

## Contributing
Contributions are welcome! This project is intended for educational purposes, and we appreciate any enhancements or bug fixes you can provide. To contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch: ```git checkout -b feature/enhancement or bugfix/issue-description```
3. Make your changes.
4. Commit your changes: ```git commit -am 'Add feature/enhancement' or 'Fix bug: issue description'```
5. Push to the branch: ```git push origin feature/enhancement or bugfix/issue-description```
6. Create a new **Pull Request**.

## Acknowledgment
We would like to express our gratitude to the dedicated team members who contributed their time and expertise to this project. Your collaborative spirit and hard work were essential in developing a platform that addresses real-world challenges in the food-service industry. Thank you for your invaluable contributions and commitment to making this project a success.

## Credits
Kitchen Network draws inspiration from the need to streamline hiring and operational processes in the food-service industry. The platform aims to connect food-service owners with skilled culinary professionals efficiently. Design and functionalities are influenced by modern web development practices to enhance user experience and operational effectiveness.

## License
This project is for personal and educational purposes only. All content related to Kitchen Network, including its design, functionalities, and concept, is the property of its respective owners.