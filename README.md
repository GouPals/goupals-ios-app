# goupals-ios-app

## Technologies used
- **frontend**: Swift
- **backend**: Javascript as the programming language, Node.js as the runtime environment and Express.js as framework

## Running the application

**Prerequisites**:
<br /> 
Make sure to have **Node.js** and **npm** installed on your computer. Node.js is the runtime environment needed to run JavaScript code outside the browser and npm (Node Package Manager) is used to manage dependencies.
To check that both are installed, you can use the following commands:
   ```
    node -v
   ```
And 
   ```
    npm -v
   ```

Before running the backend server, you should ensure you have the config package and the .env file in your local repository. Those files are used for configuration, especially for connecting the backend to the database. You can find them in the config repository. 

To run the backend server, you should be in the API folder and run the following command:
   ```
    npm start
   ```

## Documentation Backend

### Source Code

All source code is present in the **src** folder. <br /> 

The entry point of the application is the **app.js** class. All startup files will be used when starting the application. 

#### Startup files

- **config.js**: This file is used for setting configuration. For now, it only ensures that a JWT private key has been set.
- **database.js**: This file is used for creating the tables in the database when the application starts. It imports the data models and create them to create a table instance that can then be persisted into the database. To create the tables in the database, it is used the **sync** method on the **sequelize** object. This object is taken from the file responsible for creating the connection with the database.
- **logging**: This file ensures logging the error message into .log files to keep track of server exceptions. For logging, we use the **winston** library. There are two types of logging files. **logfile.log** is used to store errors raised by express when treating request whereas **uncaughtExceptions.log** is used for uncaught errors that occurred outside of request treatments.
- **routes**: This file is responsible for redirecting requests to the different APIs.

#### Authentication and Authorization

For now, authentication is performed based on the user's email and password. These pieces of information are saved in the user table for the moment. For authentication security, we encrypt users' passwords using the **bcrypt** library and we also use salt to add more security.
Authorization is based on JWT tokens. The token is sent back to the client when he logs in. More precisely, we set a header field called **x-auth-token** in the HTTP response.

#### Most important libraries used

- **config**: Used for configuration. It allows us to access specific variables based on the environment we are in. For example, if we are in the development environment, the config library will automatically pick database variables defined in the development.json config file.
- **winston**: Used for logging exceptions.
- **express-async-errors**: Used to handle errors. By using this library, we don't need to create try/catch blocks when treating requests. The library will automatically create those try-catch blocks and raise an error based on the middleware error function defined in the middleware package.
- **jsonwebtoken**: Used for authentication. We use web tokens to check client permission when requests are sent to the server.
- **bcrypt**: Used for hashing password in the database.
### Configuration

All configuration is present in the config package. That's where JSON Token private keys are written, information regarding the connection to the database, and much more. There are different configurations JSON files. One of those files will be used depending on which environment the software is running in. For example, if the application is running in production (environment variable NODE_ENV set to "production"), then the development.json file will be used. default.json file is used for default configuration if no environment has been set.

