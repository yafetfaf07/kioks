import createHttpError from 'http-errors';
import { RequestHandler } from 'express';
import { OrderService } from '../services/OrderService';
import mongoose from 'mongoose';
import { OrderDTOs } from '../dto/Orderdto';
// import OrderProduct from '../models/OrderProduct';
import Product from '../models/Product';

// This is for creaing product

export class OrderController {
  private _services: OrderService;
  constructor(ps: OrderService) {
    this._services = ps;
  }
  createOrder: RequestHandler<unknown, unknown, OrderDTOs> = async (
    req,
    res,
    next,
  ) => {
    try {
      const { uid, product } = req.body;
      const order = await this._services.createOrder(
        new mongoose.Types.ObjectId(uid),
        new Date(),
        product,
      );
      if (order) {

        for(let i=0; i<product.length; i++) {
          await Product.updateOne(
            { _id: product[i].pid },
            {
              $inc: {
                changedQuantity: -product[i].quantity,
                quantity: product[i].quantity,
              },
            }
          );
          
        }
      

        // Only called after all updates are done
      } else {
        throw createHttpError(400, 'Please enter full info');
      }
      // const existingOrder = await this._services.getOrderById(order._id);
      res.status(201).json(order);
    } catch (error) {
      console.error('Error in Order Controller', error);
      next(error);
    }
  };

  getAllOrders: RequestHandler<unknown, unknown, unknown> = async (
    req,
    res,
    next,
  ) => {
    try {
      const allOrders = await this._services.getAllOrders();
      if (allOrders) {
        res.status(200).json(allOrders);
      } else {
        throw createHttpError(404, 'No Orders found');
      }
    } catch (error) {
      next(error);
    }
  };

  getOrderByUserId: RequestHandler<{ id: string }, unknown, unknown> =
    async (req, res, next) => {
      const id = new mongoose.Types.ObjectId(req.params.id);
      try {
        const getOrder = await this._services.getUserOrderedProducts(id);
        if (getOrder.length == 0) {
          throw createHttpError(404, 'No orders found');
        } else {
          res.status(200).json(getOrder);
        }
      } catch (error) {
        console.error(error);
        next(error);
      }
    };
  getOrderByDeliveryId: RequestHandler<
    { id: string },
    unknown,
    unknown,
    unknown
  > = async (req, res, next) => {
    const id = new mongoose.Types.ObjectId(req.params.id);

    try {
      const getOrder = await this._services.getOrdersByDeliveryId(id);
      if (getOrder.length == 0) {
        throw createHttpError(404,{ message: 'No order found' });
      } else {
        res.status(200).json(getOrder);
      }
    } catch (error) {
      console.error(error);
      next(error);
    }
  };
}
