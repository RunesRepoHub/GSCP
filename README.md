# GSCP
Game Server Control Panel, this is an easy way to deploy and manage docker game servers.

## Docker Setup

1. - [x] Create Dockerfiles for the Node.js app, PostgreSQL database and the web interface.

2. - [x] Set up Docker Compose for orchestrating the containers.

## Node.js Application

1. - [x] Implement basic Node.js application with Express.js.

2. Set up SSH functionality for executing commands on Linux machines.

3. Implement API endpoints for the specified commands:

    * Start game servers

    * Stop game servers

    * Display running game servers

    * Automatically track running game servers

    * Display game server settings
    
    * Install and start new game servers

## PostgreSQL Database

1. - [x] Set up PostgreSQL database connection in the Node.js app.

2. Design and create the necessary tables for storing game server information.

### Database Schema Design

1. Research and decide on the optimal database schema for storing game server information.

2. Define tables for storing game server settings, status, and any other relevant information.

3. Determine primary keys, foreign keys, and relationships between tables.

### Database Initialization

1. Implement scripts or mechanisms for initializing the database schema and tables.

2. Ensure that the initialization process can be easily executed when setting up the application.

### Database Connection Pooling

1. Implement a connection pooling mechanism to efficiently manage database connections in the Node.js app.

2. Configure connection pool settings for optimal performance.

### Data Validation

1. Implement data validation checks in the Node.js app to ensure that only valid data is stored in the database.

2. Handle potential errors or exceptions that may occur during database operations.

### Indexing and Optimization

1. Identify fields that should be indexed for faster query performance.

2. Optimize database queries for efficiency, especially for frequently used operations.

### Data Encryption

1. Investigate and implement encryption mechanisms for sensitive data stored in the database.

2. Ensure that credentials and other sensitive information are securely stored.

### Database Monitoring

1. Integrate monitoring tools to keep track of database performance.

2. Set up alerts for potential issues or anomalies.

### Documentation

1. Document the database schema, including table structures, relationships, and any constraints.

2. Include information on how to set up and configure the database connection in the README.

## Web interface

1. Create a simple web interface using HTML, CSS, and Nginx.

2. Implement forms or UI components for interacting with the Node.js API.

## Integration

1. Ensure the Node.js app, PostgreSQL, and web interface can communicate seamlessly.

2. Test the end-to-end flow of starting, stopping, and managing game servers.

## Documentation

1. Create a comprehensive README.md (This will be a made for mkdocs not github) file with project description, setup instructions, and usage guidelines.

2. Document the API endpoints and their expected input/output.

## Testing

1. Write unit tests for critical functions in the Node.js app.

2. Conduct integration tests to ensure the entire system works cohesively.

## Continuous Integration

1. Set up a CI/CD pipeline for automated testing and deployment.

## Security

1. Implement secure coding practices, especially when dealing with SSH and user inputs.

2. Ensure that sensitive information (e.g., SSH keys, database credentials) is properly secured.
