const request = require("supertest");
const User = require("../../src/models/user");
const sequelize = require("../../src/utils/database.js");

let server;

describe("api/items", () => {
  beforeEach(() => {
    server = require("../../src/app");
  });
  afterEach(async () => {
    await server.close();
    await sequelize.sync({ force: true });
  });

  describe("POST", () => {
    it("should not register a user if the email address is not valid", async () => {
      const user = {
        name: "Leo Boon",
        email: "leo.boon@example",
        password: "Password123!",
        confirmPassword: "Password123!",
      };

      const res = await request(server)
        .post("/api/users")
        .send(user)
        .expect(400);

      expect(res.body).toMatch(/email/);
    });
  });

  describe("POST", () => {
    it("should not register a user if the password format  is not valid", async () => {
      const user = {
        name: "Leo Boon",
        email: "leo.boon@example",
        password: "password123",
        confirmPassword: "password123",
      };
      const res = await request(server)
        .post("/api/users")
        .send(user)
        .expect(400);
    });
  });

  describe("POST", () => {
    it("should not register a user if its password and confirmPassword do not match", async () => {
      const user = {
        name: "Leo Boon",
        email: "leo.boon@example.com",
        password: "Password123!",
        confirmPassword: "Password1234!",
      };
      const res = await request(server)
        .post("/api/users")
        .send(user)
        .expect(400);
    });
  });

  describe("POST", () => {
    it("should not register a user if the email address provided already exits", async () => {
      const user1 = {
        name: "Leo Boon",
        email: "leo.boon@example.com",
        password: "Password123!",
        confirmPassword: "Password123!",
      };
      const user2 = {
        name: "Dany Boon",
        email: "leo.boon@example.com",
        password: "Other123!",
        confirmPassword: "Other123!",
      };

      await request(server).post("/api/users").send(user1);
      const res = await request(server)
        .post("/api/users")
        .send(user2)
        .expect(400);
    });
  });

  describe("POST", () => {
    it("should successfully register and store user data if data validation constraints are respected", async () => {
      const user = {
        name: "Leo Boon",
        email: "leo.boon@example.com",
        password: "Password123!",
        confirmPassword: "Password123!",
      };
      const res = await request(server)
        .post("/api/users")
        .send(user)
        .expect(201);

      const db = await User.findOne({ where: { email: user.email } });

      expect(db).toBeDefined();
    });
  });
});
