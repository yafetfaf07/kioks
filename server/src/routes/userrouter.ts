import { UserController } from "../controllers/userController";
import express from "express";

export class UserRouter {
    private _controller: UserController;
    router;
    constructor(cs: UserController) {
        this._controller = cs;
        this.router = express.Router();
    }
    registerRoutes() {
        this.router.post('/signup', this._controller.createUser.bind(this._controller));
        // this.router.get('/getAllUser', this._controller.getAllUser);
        // this.router.post('/getUserByPhoneNumber', this._controller.getUserByPhoneNumber);
        this.router.post('/login', this._controller.login.bind(this._controller));
        this.router.get('/protected-route', this._controller.verifyToken.bind(this._controller))
        this.router.get('/logout', this._controller.logout.bind(this._controller))
        this.router.get('/refresh', this._controller.refresh.bind(this._controller));
        return this.router;
    }
}