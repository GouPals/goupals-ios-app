const { Model, DataTypes } = require("sequelize");
const sequelize = require("../utils/database");
const jwt = require("jsonwebtoken");
const config = require("config");
const Joi = require("joi");

class User extends Model {
  generateAuthToken() {
    return jwt.sign(
      { id: this.id, isAdmin: this.isAdmin },
      config.get("jwtPrivateKey")
    );
  }

  static validate(userData) {
    const schema = Joi.object({
      name: Joi.string().min(5).max(40).required(),
      email: Joi.string().min(5).max(255).required().email(),
      password: Joi.string()
        .min(5)
        .max(255)
        .pattern(
          new RegExp(
            "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]+$"
          )
        )
        .messages({
          "string.pattern.base":
            "Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character.",
        })
        .required(),
      confirmPassword: Joi.string().required().valid(Joi.ref("password")),
    });

    return schema.validate(userData);
  }
}

User.init(
  {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      allowNull: false,
      primaryKey: true,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
      validate: {
        isEmail: true,
      },
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    phoneNumber: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    rating: {
      type: DataTypes.DECIMAL(3, 1),
      allowNull: true,
      validate: {
        min: 0,
        max: 5,
      },
    },
    bio: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    isAdmin: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
    },
  },
  {
    sequelize,
    modelName: "User",
  }
);

module.exports = User;
