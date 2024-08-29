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
- **logging**: This file ensures to log the error message into .log files to keep track of server exceptions. For logging, we use the **winston** library. There are two types of logging files. **logfile.log** is used to store errors raised by express when treating request whereas "**uncaughtExceptions.log**is used for uncaught errors that occurred outside of request treatments.
- **routes**: This file is responsible for redirecting requests to the different APIs.

#### Authentication

Talk about salt and jwt
### Configuration

All configuration is present in the config package. That's where JSON Token private keys are written, information regarding the connection to the database, and much more. There are different configurations JSON files. One of those files will be used depending on which environment the software is running in. For example, if the application is running in production (environment variable NODE_ENV set to "development", then the development.json file will be used). default.json file is used for default configuration if no environment has been set.

