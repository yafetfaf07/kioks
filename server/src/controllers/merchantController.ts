import createHttpError from 'http-errors';
import { RequestHandler } from 'express';
import { MerchantDTO, MerchantLogin } from '../dto/Merchantdto';
import { MerchantService } from '../services/MerchantService';

export class MerchantController {
  private __services: MerchantService;
  constructor(ms: MerchantService) {
    this.__services = ms;
  }
  createMerchant: RequestHandler<unknown, unknown, MerchantDTO, unknown> =
    async (req, res, next) => {
      const firstname = req.body.firstname;
      const lastname = req.body.lastname;
      const phone_no = req.body.phone_no;
      const passwordRaw = req.body.password;
      const address = req.body.address;
   
      try {
        if (!firstname || !lastname || !passwordRaw || !address || !phone_no) {
          throw createHttpError(400, 'Please enter valid credentials ');
        }

        const existingUser =
          await this.__services.getMerchantByPhoneNumber(phone_no);
        if (existingUser) {
          throw createHttpError(409, 'This user already exists'); // conflict
        }
        // This is
        // const hashedPassword = await argon2.hash(passwordRaw);

        const newMerchant = await this.__services.createMerchant(
          firstname,
          lastname,
          phone_no,
          passwordRaw,
          address,
       
        );

        res.status(201).json(newMerchant);
      } catch (error) {
        console.error("This is my erroroooooooo",error);
        next(error);
      }
    };

  //For Getting all Users

  getAllMerchant: RequestHandler = async (req, res, next) => {
    const allUsers = await this.__services.getAllMerchant();

    try {
      if (!allUsers) {
        throw createHttpError(404, 'No merchants found');
      }

      res.status(200).json(allUsers);
    } catch (error) {
      next(error);
    }
  };
  getMerchantByName:RequestHandler<{name:string}, unknown,unknown> = async(req,res,next) => {
    const name = req.params.name;

    try {
      const merchantName = await this.__services.getMerchantByName(name);
      if(merchantName.length==0) {
        throw createHttpError(404, "No shops found by this name");
      }
      res.status(200).json(merchantName);
      
    } catch (error) {
      console.error(error);
      next(error);
    }

  }

  // For login purposes

  login: RequestHandler<MerchantLogin, unknown, unknown, unknown> = async (
    req,
    res,
    next,
  ) => {
    const phone_no = req.params.phone_no;
    const password = req.params.password;

    if (!phone_no || !password) {
      throw createHttpError(400, 'Please enter a username');
    }
    try {
      const loginUser = await this.__services.login(phone_no, password);
      if (!loginUser) {
        throw createHttpError(404, "User doesn't exist");
      }
      res.status(200).json(loginUser);
    } catch (error) {
      next(error);
    }
  };
}
// For creating Merchant
