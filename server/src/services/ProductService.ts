import Product from '../models/Product';
import mongoose from 'mongoose';
interface updateProduct {
  name:string,
  quantity:number
}
export class ProductService {
  async createProduct(
    name: string,
    price: number,
    imageUrl: string,
    category: string,
    quantity: number,
    changedQuantity:number,
    merchantId: mongoose.Types.ObjectId,
  ) {
    return await Product.create({
      name: name,
      price: price,
      imageUrl: imageUrl,
      category: category,
      quantity: quantity,
      changedQuantity:changedQuantity,
      mid: merchantId,
    });
  }

  async getAllProduct() {
    return await Product.find().exec();
  }
  async getAllProductById(id: mongoose.Types.ObjectId) {
    return await Product.find({ _id: id });
  }

  async getProductByMerchantId(merchant_id: mongoose.Types.ObjectId) {
    return await Product.find({ mid: merchant_id }).exec();
  }
  async getProductByName(name: string) {
    return await Product.find({ name: name}).exec();
  }
  async getProductByMerchantName(name: string, merchant_id: mongoose.Types.ObjectId) {
    return await Product.find({ 
      name: { $regex: `^${name}`, $options: 'i' }, 
      mid: merchant_id 
    }).exec();
  }
  async getProductByCategory(category: string) {
    const getProduct = await Product.aggregate([
      { $match: { category: category } },
  
      // Group by merchant ID
      {
        $group: {
          _id: "$mid"
        }
      },
  
      // Lookup merchant details
      {
        $lookup: {
          from: "merchants",
          localField: "_id",
          foreignField: "_id",
          as: "merchant"
        }
      },
  
      { $unwind: "$merchant" },
  
      // Lookup comments to calculate ratings
      {
        $lookup: {
          from: "comments",
          localField: "_id",
          foreignField: "mid",
          as: "ratings"
        }
      },
  
      // Compute average rating
      {
        $addFields: {
          overallRating: {
            $cond: [
              { $gt: [{ $size: "$ratings" }, 0] },
              {
                $divide: [
                  { $sum: "$ratings.rating" },
                  { $size: "$ratings" }
                ]
              },
              null // or 0
            ]
          }
        }
      },
  
      // Return relevant fields
      {
        $project: {
          _id: 0,
          mid: "$merchant._id",
          firstname: "$merchant.firstname",
          address: "$merchant.address",
          overallRating: 1
        }
      }
    ]);
  
    return getProduct;
  }
  

  async updateProduct(id:mongoose.Types.ObjectId, body:updateProduct) {
    
    await Product.findByIdAndUpdate(id,{$set:body}, {
      new:true,
      runValidators:true
    })

  }
}
