import { Types } from 'mongoose';
import Order from '../models/Order';
import OrderProduct from '../models/OrderProduct';
import DeliverPersonnel from '../models/DeliverPersonnel';
// import Product from '../models/Product';

// import * as argon2 from 'argon2'; // used for hashing password

export class OrderService {
  async createOrder(uid: Types.ObjectId, createdAt: Date, product:[{pid:Types.ObjectId, quantity:number}]) {
    const deliverPerssonel = await DeliverPersonnel.find({ isActive: false })
      .select('_id')
      .sort({ noOfOrder: 1 })
      .exec();

    console.log('Deliver Personnel: ', deliverPerssonel);

    const order = await Order.create({
      product:product,
      uid: uid,
      did: deliverPerssonel[0],
      createdAt: createdAt,
    });

    return order;
  }

  async getAllOrders() {
    const orders = await OrderProduct.find().exec();
    return orders;
  }

  async getUserOrderedProducts(userId: Types.ObjectId) {
    // Step 1: Get all orders by user
    const orders = await Order.aggregate([
      { $match: { uid: userId } },
    
      // Join User
      {
        $lookup: {
          from: 'users',
          localField: 'uid',
          foreignField: '_id',
          as: 'user',
        },
      },
      { $unwind: '$user' },
    
      // Unwind products
      { $unwind: '$product' },
    
      // Join Product Details
      {
        $lookup: {
          from: 'products',
          localField: 'product.pid',
          foreignField: '_id',
          as: 'productDetails',
        },
      },
      { $unwind: '$productDetails' },
    
      // Join Merchant
      {
        $lookup: {
          from: 'merchants',
          localField: 'productDetails.mid',
          foreignField: '_id',
          as: 'merchant',
        },
      },
      { $unwind: '$merchant' },
    
      // Group by {orderId, merchantId}
      {
        $group: {
          _id: {
            orderId: '$_id',
            merchantId: '$merchant._id',
          },
          createdAt: { $first: '$createdAt' },
          user: { $first: '$user' },
          did: { $first: '$did' },
          merchant: { $first: '$merchant' },
          products: {
            $push: {
              _id: '$productDetails._id',
              name: '$productDetails.name',
              price: '$productDetails.price',
              imageUrl: '$productDetails.imageUrl',
              quantity: '$product.quantity',
            },
          },
        },
      },
    
      // Project clean output
      {
        $project: {
          _id: 0,
          orderId: '$_id.orderId',
          createdAt: 1,
          merchant: {
            _id: '$merchant._id',
            firstname: '$merchant.firstname',
            address: '$merchant.address',
          },
          user: {
            firstname: '$user.firstname',
            phone_no: '$user.phone_no',
            address: '$user.address',
          },
          products: 1,
        },
      },
    
      // Optional: sort by date
      { $sort: { createdAt: -1 } },
    ]);
    
    


    // Step 2: Get all order products with product & merchant info
 

    // Step 3: Format result (optional)
    return orders;
  }

  async getOrdersByDeliveryId(did: Types.ObjectId) {
    const orders = await Order.aggregate([
      {
        $match: { did },
      },
  
      // Join User
      {
        $lookup: {
          from: 'users',
          localField: 'uid',
          foreignField: '_id',
          as: 'user',
        },
      },
      { $unwind: '$user' },
  
      // Unwind products
      { $unwind: '$product' },
  
      // Join Product Details
      {
        $lookup: {
          from: 'products',
          localField: 'product.pid',
          foreignField: '_id',
          as: 'productDetails',
        },
      },
      { $unwind: '$productDetails' },
  
      // Join Merchant Details
      {
        $lookup: {
          from: 'merchants',
          localField: 'productDetails.mid',
          foreignField: '_id',
          as: 'merchant',
        },
      },
      { $unwind: '$merchant' },
  
      // Group products back per order
      {
        $group: {
          _id: '$_id',
          createdAt: { $first: '$createdAt' },
          user: { $first: '$user' },
          did: { $first: '$did' },
          products: {
            $push: {
              _id: '$productDetails._id',
              name: '$productDetails.name',
              price: '$productDetails.price',
              imageUrl: '$productDetails.imageUrl',
              quantity: '$product.quantity',
              merchant: {
                _id: '$merchant._id',
                firstname: '$merchant.firstname',
                address: '$merchant.address',
              },
            },
          },
        },
      },
  
      // Optional: Project fields
      {
        $project: {
          _id: 1,
          createdAt: 1,
          'user.firstname': 1,
          'user.phone_no': 1,
          'user.address': 1,
          products: 1,
        },
      },
    ]);
  
    return orders;
  }
  
  
}
