import createHttpError from 'http-errors';
import user from '../models/User';
import { RequestHandler } from 'express';
// import * as argon2 from 'argon2'; // used for hashing password
import { UserDTO, LoginDTO } from '../dto/Userdto';
import { UserService } from '../services/UserService';
import createTokens from '../../utils/jwt';
import * as jwt from "jsonwebtoken"


export class UserController {
  private __services: UserService;
  constructor(us: UserService) {
    this.__services = us;
  }
  createUser: RequestHandler<unknown, unknown, UserDTO, unknown> = async (
    req,
    res,
    next,
  ) => {
    const firstname = req.body.firstname;
    const lastname = req.body.lastname;
    const passwordRaw = req.body.password;
    const address = req.body.address;
    const phone_no = req.body.phone_no;
    try {
      if (!firstname || !lastname || !passwordRaw || !address) {
        throw createHttpError(400, 'Please enter valid credentials ');
      }
      const existingUser = await this.__services.getUserByPhoneNumber(phone_no);
      if (existingUser) {
        throw createHttpError(409, 'This user already exists'); // conflict
      }
      // This is
      // const hashedPassword = await argon2.hash(passwordRaw);
      const newUser = await this.__services.createUser(
      firstname,
      lastname,
      phone_no,
      passwordRaw,
      address,
      );
      const {accessToken, refreshToken}=createTokens(newUser._id);      
      res.cookie('token',refreshToken,{
        httpOnly:true,
        secure:false,
        sameSite:'lax',
        maxAge: 7 * 24 * 60 * 60 * 1000,
        
      })
      res.status(200).json({token:accessToken, message:"login successful ", data:newUser});
      res.status(201).json(newUser);
    } catch (error) {
      next(error);
    }
  };

  login: RequestHandler<unknown, unknown, LoginDTO, unknown> = async (
    req,
    res,
    next,
  ) => {
    const phone_no = req.body.phone_no;
    const password = req.body.password;

    if (!phone_no || !password) {
      throw createHttpError(400, 'Please enter credentials');
    }
    try {
      const loginUser = await this.__services.login(phone_no, password);
      if (!loginUser) {
        throw createHttpError(404, "User doesn't exist");
      }

    const {accessToken, refreshToken}=createTokens(loginUser._id);      
      res.cookie('token',refreshToken,{
        httpOnly:true,
        secure:false,
        sameSite:'lax',
        maxAge: 7 * 24 * 60 * 60 * 1000,
        
      })
      res.status(200).json({accessToken:accessToken, refreshToken:refreshToken, message:"login successful ", data:loginUser});
      
    } catch (error) {
      console.error(error);
      next(error);
    }
  };
  verifyToken: RequestHandler<unknown, unknown,unknown, unknown> = async(req,res,next) => {
    const accessToken = req.headers["authorization"]?.split(' ')[1];

    if (!accessToken) {
      throw createHttpError(404,"Token is missing")
    }
    console.log("Access token: ",accessToken);
    try {
      const decoded=jwt.verify(accessToken,process.env.JWT_TOKEN!)
      console.log("Decoded: ",decoded);
      res.status(200).json({id:decoded})
      
    } catch (error) {
      console.error('Verification error:', error);
      next(error)
    }
    
  }

  logout: RequestHandler<unknown, unknown,unknown, unknown> = async(req,res,next) => {
    try {
      console.log(req.cookies);

      res.clearCookie("token", {
        httpOnly: true,
        secure: false,
        sameSite: "lax",
      });      

      console.log("Cookies after clear (should be unchanged in req):", req.cookies);
      res.status(200).json({ data: "Logout successful" });

    } catch (error) {
      console.error(error);
      next(error)
    }
  }
  refresh: RequestHandler<unknown, unknown,unknown, unknown> = async(req,res,next) => {
    const {token} = req.cookies
    if (!token) {
      throw createHttpError(401,"refresh token not found")
  }
  try {
    // 3. Verify the refresh token's authenticity and expiration
    const decoded = jwt.verify(token, process.env.JWT_REFRESH_SECRET!);
    
    // 4. If the refresh token is valid, generate a NEW access token
    const newAccessToken = jwt.sign(
        { id: typeof decoded === 'object' && decoded !== null && 'id' in decoded ? (decoded as jwt.JwtPayload)['id'] : undefined },
        process.env.JWT_SECRET!,
        { expiresIn: '15m' }
    );

    res.status(200).json({ accessToken: newAccessToken });

} catch (error) {
   
    res.clearCookie('token');
    next(error)
}
  }
}

//For Getting all Users

export const getAllUser: RequestHandler = async (req, res, next) => {
  const allUsers = await user.find().exec();

  try {
    if (!allUsers) {
      throw createHttpError(404, 'No users found');
    }

    res.status(200).json(allUsers);
  } catch (error) {
    next(error);
  }
};

// For Getting a specific user
